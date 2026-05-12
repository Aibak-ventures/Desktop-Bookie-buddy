import 'package:bookie_buddy_web/core/constants/enums/booking_status_enums.dart';
import 'package:bookie_buddy_web/core/constants/enums/shop_based_enums.dart';
import 'package:bookie_buddy_web/features/accounts/domain/entities/account_entity/account_entity.dart';
import 'package:bookie_buddy_web/features/booking/domain/entities/additional_charges_entity/additional_charges_entity.dart';
import 'package:bookie_buddy_web/features/booking/domain/entities/booking_other_details_entity/booking_other_details_entity.dart';
import 'package:bookie_buddy_web/features/booking/domain/entities/booking_payment_request_entity/booking_payment_request_entity.dart';
import 'package:bookie_buddy_web/features/booking/domain/entities/booking_request_entity/booking_request_entity.dart';
import 'package:bookie_buddy_web/features/booking/presentation/common/booking_form/booking_type_enum.dart';
import 'package:bookie_buddy_web/features/booking/presentation/old_new_booking/helpers/payment_calculator.dart';
import 'package:bookie_buddy_web/features/client/domain/entities/client_request_entity/client_request_entity.dart';
import 'package:bookie_buddy_web/features/product/domain/entities/product_selected_entity/product_selected_entity.dart';
import 'package:bookie_buddy_web/features/sales/data/models/request_sales_model/request_sales_model.dart';
import 'package:bookie_buddy_web/utils/extensions/date_time_extensions.dart';
import 'package:bookie_buddy_web/utils/phone_number_utils.dart';
import 'package:flutter/material.dart';

/// Builds API request payloads for the new-booking / sales / old-booking flows.
///
/// All methods are pure static functions — no [BuildContext], no BLoC, no side
/// effects. The screen collects the required values from its state and passes
/// them in; this class only assembles the payload.
class BookingRequestBuilder {
  // ---------------------------------------------------------------------------
  // Booking request
  // ---------------------------------------------------------------------------

  /// Assembles [BookingRequestEntity] for [BookingType.booking].
  ///
  /// The screen is responsible for pre-computing:
  /// - [effectiveRentalDays] via [PaymentCalculator.getEffectiveRentalDays]
  /// - [discountInput] from the discount field
  /// - All raw text values (trimmed strings read from controllers)
  /// - [staffId] from StaffSearchCubit before calling
  static BookingRequestEntity buildBookingRequest({
    required List<ProductSelectedEntity> products,
    required List<AdditionalChargesEntity> additionalCharges,
    required BookingType bookingType,
    required int effectiveRentalDays,
    required String runningKm,
    required int discountInput,
    required bool isDiscountPercentage,
    required int? staffId,
    required int? selectedClientId,
    required String clientName,
    required String phone1Raw,
    required String phone2Raw,
    required String address,
    required String locationStart,
    required String locationFrom,
    required String locationTo,
    required int coolingPeriodDays,
    required CoolingPeriodMode coolingPeriodMode,
    required DateTime pickupDate,
    required DateTime returnDate,
    required int? advanceAmount,
    required int? securityAmount,
    required int? securityAccountId,
    required AccountEntity? advanceAccount,
    required DeliveryStatus deliveryStatus,
    required String? description,
    required TimeOfDay? pickupTime,
    required TimeOfDay? returnTime,
    required bool sendPdfToWhatsApp,
  }) {
    // --- Products: apply day multiplier + optional running km ---
    final requestProducts = products.map((product) {
      final multiplier = PaymentCalculator.getDaysMultiplierForProduct(
        product: product,
        bookingType: bookingType,
        effectiveRentalDays: effectiveRentalDays,
      );
      final adjusted = product.copyWith(amount: product.amount * multiplier);
      return runningKm.isNotEmpty
          ? adjusted.copyWith(runningKilometers: runningKm)
          : adjusted;
    }).toList();

    // --- Discount (applied to base price WITHOUT day multiplier) ---
    // Business rule: discount base uses unit amounts only, matching the
    // original screen behavior where productTotal skips day multiplication.
    final productTotal = products.fold<int>(
      0,
      (sum, p) => sum + (p.amount * p.quantity),
    );
    final additionalTotal = additionalCharges.fold<int>(
      0,
      (sum, c) => sum + (c.amount ?? 0),
    );
    final actualDiscount = isDiscountPercentage
        ? ((productTotal + additionalTotal) * discountInput / 100).round()
        : discountInput;

    // --- Client data: only when no existing client is linked ---
    ClientRequestEntity? clientData;
    if (selectedClientId == null) {
      clientData = ClientRequestEntity(
        id: null,
        name: clientName.isEmpty ? null : clientName,
        phone1E164: phone1Raw.isEmpty ? null : toPhone1E164(phone1Raw),
        phone2E164: phone2Raw.isEmpty ? null : toPhone1E164(phone2Raw),
      );
    }

    // --- Location ---
    final hasLocation =
        locationStart.isNotEmpty ||
        locationFrom.isNotEmpty ||
        locationTo.isNotEmpty;
    final otherDetails = hasLocation
        ? BookingOtherDetailsEntity(
            locationStart: locationStart.isEmpty ? null : locationStart,
            locationFrom: locationFrom.isEmpty ? null : locationFrom,
            locationTo: locationTo.isEmpty ? null : locationTo,
          )
        : null;

    // --- Cooling period ---
    final coolingPeriodType = coolingPeriodDays > 0
        ? coolingPeriodMode.value.toLowerCase()
        : null;
    final DateTime effectiveReturnDate;
    final DateTime? effectiveCoolingPeriodDate;
    if (coolingPeriodDays > 0) {
      if (coolingPeriodMode.isAfter) {
        effectiveReturnDate = returnDate;
        effectiveCoolingPeriodDate = returnDate.add(
          Duration(days: coolingPeriodDays),
        );
      } else {
        effectiveReturnDate = returnDate;
        effectiveCoolingPeriodDate = pickupDate.subtract(
          Duration(days: coolingPeriodDays),
        );
      }
    } else {
      effectiveReturnDate = returnDate;
      effectiveCoolingPeriodDate = null;
    }

    // --- Advance payment ---
    final hasAdvance = advanceAmount != null && advanceAmount > 0;

    return BookingRequestEntity(
      clientId: selectedClientId,
      staffId: staffId,
      client: clientData,
      address: address,
      pickupDate: pickupDate.format(),
      returnDate: effectiveReturnDate.format(),
      coolingPeriodDate: effectiveCoolingPeriodDate?.format(),
      coolingPeriodType: coolingPeriodType,
      advanceAmount: advanceAmount,
      securityAmount: securityAmount,
      securityPaymentAccountId: securityAmount != null ? securityAccountId : null,
      discountAmount: actualDiscount,
      purchaseMode: 'normal',
      payments: !hasAdvance
          ? null
          : [
              BookingPaymentRequestEntity(
                accountId: advanceAccount!.id,
                amount: advanceAmount,
              ),
            ],
      deliveryStatus: deliveryStatus,
      products: requestProducts,
      otherDetails: otherDetails,
      additionalCharges: additionalCharges.isNotEmpty ? additionalCharges : null,
      description: description,
      pickupTime: pickupTime,
      returnTime: returnTime,
      sendPdfToWhatsApp: sendPdfToWhatsApp,
    );
  }

  // ---------------------------------------------------------------------------
  // Sales request
  // ---------------------------------------------------------------------------

  /// Assembles [RequestSalesModel] for [BookingType.sales].
  ///
  /// [isPastDate] must be pre-computed by the caller (`pickupDate < today`).
  static RequestSalesModel buildSalesRequest({
    required List<ProductSelectedEntity> products,
    required int discountInput,
    required bool isDiscountPercentage,
    required int? staffId,
    required String clientPhone,
    required String clientAddress,
    required DateTime saleDate,
    required String? description,
    required bool sendInvoice,
    required int? accountId,
    required bool decreaseStockForPastDate,
    required bool isPastDate,
  }) {
    final variants = products
        .map(
          (p) => <String, dynamic>{
            'id': p.variant.variantId,
            'quantity': p.quantity,
            'amount': p.amount * p.quantity,
          },
        )
        .toList();

    final grossTotal = variants.fold<int>(
      0,
      (sum, item) => sum + ((item['amount'] as int?) ?? 0),
    );
    final discount = isDiscountPercentage
        ? (grossTotal * discountInput / 100).round()
        : discountInput;
    final finalTotal = (grossTotal - discount) > 0 ? (grossTotal - discount) : 0;

    return RequestSalesModel(
      staffId: staffId,
      clientPhone: clientPhone.isEmpty ? null : clientPhone,
      clientAddress: clientAddress.isEmpty ? null : clientAddress,
      saleDate: saleDate.format(),
      description: description,
      sendInvoice: sendInvoice,
      variants: variants,
      paidAmount: finalTotal,
      accountId: accountId,
      discount: discount,
      decreaseStock: decreaseStockForPastDate || !isPastDate,
    );
  }

  // ---------------------------------------------------------------------------
  // Old booking request
  // ---------------------------------------------------------------------------

  /// Assembles [BookingRequestEntity] for [BookingType.oldBooking].
  ///
  /// Old bookings are always marked as [DeliveryStatus.returned] /
  /// [BookingStatus.completed] — that is a fixed business rule.
  static BookingRequestEntity buildOldBookingRequest({
    required List<ProductSelectedEntity> products,
    required BookingType bookingType,
    required int effectiveRentalDays,
    required int? selectedClientId,
    required String clientName,
    required String phone1Raw,
    required String phone2Raw,
    required String address,
    required DateTime? bookedDate,
    required DateTime pickupDate,
    required DateTime returnDate,
    required String? description,
    required int? advanceAccountId,
  }) {
    final requestProducts = products.map((product) {
      final multiplier = PaymentCalculator.getDaysMultiplierForProduct(
        product: product,
        bookingType: bookingType,
        effectiveRentalDays: effectiveRentalDays,
      );
      return product.copyWith(amount: product.amount * multiplier);
    }).toList();

    final totalAmount = requestProducts.fold<int>(
      0,
      (sum, p) => sum + (p.amount * p.quantity),
    );

    return BookingRequestEntity(
      clientId: selectedClientId,
      staffId: null,
      client: selectedClientId == null
          ? ClientRequestEntity(
              id: null,
              name: clientName.isEmpty ? null : clientName,
              phone1E164: phone1Raw.isEmpty ? null : toPhone1E164(phone1Raw),
              phone2E164: phone2Raw.isEmpty ? null : toPhone1E164(phone2Raw),
            )
          : null,
      address: address.isEmpty ? null : address,
      bookedDate: bookedDate?.format(),
      pickupDate: pickupDate.format(),
      returnDate: returnDate.format(),
      advanceAmount: totalAmount,
      deliveryStatus: DeliveryStatus.returned,
      bookingStatus: BookingStatus.completed,
      description: description,
      products: requestProducts,
      oldBookingAccountId: advanceAccountId,
    );
  }

  // ---------------------------------------------------------------------------
  // Shared helpers
  // ---------------------------------------------------------------------------

  /// Converts raw description text into the nullable API field.
  /// Returns null for empty/blank strings so the field is omitted from the payload.
  static String? buildDescription(String text) =>
      text.trim().isEmpty ? null : text.trim();
}
