import 'package:bookie_buddy_web/core/constants/enums/payment_method_enums.dart';
import 'package:bookie_buddy_web/core/constants/enums/booking_status_enums.dart';
import 'package:bookie_buddy_web/features/booking/domain/entities/additional_charges_entity/additional_charges_entity.dart';
import 'package:bookie_buddy_web/features/booking/domain/entities/document_file_entity/document_file_entity.dart';
import 'package:bookie_buddy_web/features/product/domain/entities/product_entity/product_entity.dart';
import 'package:bookie_buddy_web/features/product/domain/entities/product_selected_entity/product_selected_entity.dart';
import 'package:bookie_buddy_web/features/product/presentation/common/bloc/select_product_bloc/select_product_bloc.dart';
import 'package:bookie_buddy_web/core/di/app_dependencies.dart';
import 'package:flutter/material.dart';

/// Holds all shared form controllers, notifiers, and focus nodes used by both
/// [NewBookingScreen] and [EditNewBookingScreen].
///
/// Call [dispose] inside the screen's [State.dispose] to clean up.
class BookingFormControllers {
  // ── Client details ──────────────────────────────────────────────────────────
  final clientNameController = TextEditingController();
  final clientPhone1Controller = TextEditingController();
  final clientPhone2Controller = TextEditingController();
  final clientAddressController = TextEditingController();
  final staffNameController = TextEditingController();

  int? selectedStaffId;
  int? selectedClientId;
  bool isSearchClientEnabled = false;

  // ── Payment ─────────────────────────────────────────────────────────────────
  final advanceAmountController = TextEditingController();
  final securityAmountController = TextEditingController();
  final discountAmountController = TextEditingController();
  PaymentMethod paymentMethod = PaymentMethod.gPay;
  DeliveryStatus deliveryStatus = DeliveryStatus.booked;

  // ── Description / service / location ────────────────────────────────────────
  final descriptionController = TextEditingController();
  final serviceSearchController = TextEditingController();
  final startLocationController = TextEditingController();
  final pickupLocationController = TextEditingController();
  final destinationLocationController = TextEditingController();
  final runningKilometersController = TextEditingController();

  // ── Inline price editing ─────────────────────────────────────────────────────
  final inlinePriceController = TextEditingController();
  final inlinePriceFocusNode = FocusNode();
  int? editingVariantId;

  // ── Client focus nodes ───────────────────────────────────────────────────────
  final clientNameFocusNode = FocusNode();
  final clientPhone1FocusNode = FocusNode();
  final clientPhone2FocusNode = FocusNode();
  final clientAddressFocusNode = FocusNode();

  // ── Notifiers ────────────────────────────────────────────────────────────────
  final selectedProductsNotifier = ValueNotifier<List<ProductSelectedEntity>>([]);
  final additionalChargesNotifier = ValueNotifier<List<AdditionalChargesEntity>>([]);
  final documentsNotifier = ValueNotifier<List<DocumentFileEntity>>([]);

  // ── Search overlay notifiers ─────────────────────────────────────────────────
  final overlayProducts = ValueNotifier<List<ProductEntity>>([]);
  final overlayIsLoading = ValueNotifier<bool>(false);
  final searchLayerLink = LayerLink();
  OverlayEntry? searchOverlayEntry;

  // ── Product search filter ─────────────────────────────────────────────────────
  final selectedSearchTypeIndex = ValueNotifier<int>(0);
  final priceRange = ValueNotifier<RangeValues>(const RangeValues(0, 50000));
  final maxPriceNotifier = ValueNotifier<double>(50000);
  final isPriceFilterEnabled = ValueNotifier<bool>(false);

  // ── Product bloc ──────────────────────────────────────────────────────────────
  late final SelectProductBloc selectProductBloc;

  BookingFormControllers() {
    selectProductBloc = SelectProductBloc(
      getAvailableProducts: getIt(),
      getProducts: getIt(),
      searchAndFilterProducts: getIt(),
    );
  }

  void removeSearchOverlay() {
    searchOverlayEntry?.remove();
    searchOverlayEntry = null;
    overlayProducts.value = [];
    overlayIsLoading.value = false;
  }

  void dispose() {
    clientNameController.dispose();
    clientPhone1Controller.dispose();
    clientPhone2Controller.dispose();
    clientAddressController.dispose();
    staffNameController.dispose();
    advanceAmountController.dispose();
    securityAmountController.dispose();
    discountAmountController.dispose();
    descriptionController.dispose();
    serviceSearchController.dispose();
    startLocationController.dispose();
    pickupLocationController.dispose();
    destinationLocationController.dispose();
    runningKilometersController.dispose();
    inlinePriceController.dispose();
    inlinePriceFocusNode.dispose();
    clientNameFocusNode.dispose();
    clientPhone1FocusNode.dispose();
    clientPhone2FocusNode.dispose();
    clientAddressFocusNode.dispose();
    selectedProductsNotifier.dispose();
    additionalChargesNotifier.dispose();
    documentsNotifier.dispose();
    overlayProducts.dispose();
    overlayIsLoading.dispose();
    selectedSearchTypeIndex.dispose();
    priceRange.dispose();
    maxPriceNotifier.dispose();
    isPriceFilterEnabled.dispose();
    selectProductBloc.close();
  }
}
