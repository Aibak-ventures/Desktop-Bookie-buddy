import 'dart:async';
import 'dart:developer';

import 'package:bookie_buddy_core/core/constants/enums/booking_status_enums.dart';
import 'package:bookie_buddy_core/features/booking/domain/entities/booking_payment_history_entity/booking_payment_history_entity.dart';
import 'package:bookie_buddy_core/features/product/domain/entities/product_info_entity/product_info_entity.dart';
import 'package:bookie_buddy_core/features/booking/domain/entities/booking_details_entity/booking_details_entity.dart';
import 'package:bookie_buddy_web/features/booking/presentation/common/extensions/booking_details_entity_web_extensions.dart';
import 'package:bookie_buddy_web/features/booking/domain/usecases/add_refund_usecase.dart';
import 'package:bookie_buddy_web/features/booking/domain/usecases/delete_refund_usecase.dart';
import 'package:bookie_buddy_web/features/booking/domain/usecases/update_security_refund_usecase.dart';
import 'package:bookie_buddy_web/features/booking/domain/usecases/delete_security_refunded_payment_usecase.dart';
import 'package:bookie_buddy_web/features/booking/domain/usecases/get_booking_usecase.dart';
import 'package:bookie_buddy_web/features/booking/domain/usecases/update_delivery_status_usecase.dart';
import 'package:bookie_buddy_web/features/booking/domain/usecases/update_booking_status_usecase.dart';
import 'package:bookie_buddy_web/features/booking/domain/usecases/update_partial_return_usecase.dart';
import 'package:bookie_buddy_web/features/booking/domain/usecases/update_payment_usecase.dart';
import 'package:bookie_buddy_web/features/booking/domain/usecases/cancel_booking_usecase.dart';
import 'package:bookie_buddy_web/features/booking/domain/usecases/delete_booking_usecase.dart';
import 'package:bookie_buddy_web/features/booking/domain/usecases/delete_payment_usecase.dart';
import 'package:bookie_buddy_web/utils/bloc_transforms.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'booking_details_bloc.freezed.dart';
part 'booking_details_event.dart';
part 'booking_details_state.dart';

class BookingDetailsBloc
    extends Bloc<BookingDetailsEvent, BookingDetailsState> {
  final GetBookingUseCase _getBooking;
  final UpdateDeliveryStatusUseCase _updateDeliveryStatus;
  final UpdateBookingStatusUseCase _updateBookingStatus;
  final UpdatePaymentUseCase _updatePayment;
  final DeletePaymentUseCase _deletePayment;
  final CancelBookingUseCase _cancelBooking;
  final DeleteBookingUseCase _deleteBooking;
  final AddRefundUseCase _addRefund;
  final DeleteRefundUseCase _deleteRefund;
  final UpdateSecurityRefundUseCase _updateSecurityRefund;
  final DeleteSecurityRefundedPaymentUseCase _deleteSecurityRefundedPayment;
  final UpdatePartialReturnUseCase _updatePartialReturn;

  BookingDetailsBloc({
    required GetBookingUseCase getBooking,
    required UpdateDeliveryStatusUseCase updateDeliveryStatus,
    required UpdateBookingStatusUseCase updateBookingStatus,
    required UpdatePaymentUseCase updatePayment,
    required DeletePaymentUseCase deletePayment,
    required CancelBookingUseCase cancelBooking,
    required DeleteBookingUseCase deleteBooking,
    required AddRefundUseCase addRefund,
    required DeleteRefundUseCase deleteRefund,
    required UpdateSecurityRefundUseCase updateSecurityRefund,
    required DeleteSecurityRefundedPaymentUseCase deleteSecurityRefundedPayment,
    required UpdatePartialReturnUseCase updatePartialReturn,
  }) : _getBooking = getBooking,
       _updateDeliveryStatus = updateDeliveryStatus,
       _updateBookingStatus = updateBookingStatus,
       _updatePayment = updatePayment,
       _deletePayment = deletePayment,
       _cancelBooking = cancelBooking,
       _deleteBooking = deleteBooking,
       _addRefund = addRefund,
       _deleteRefund = deleteRefund,
       _updateSecurityRefund = updateSecurityRefund,
       _deleteSecurityRefundedPayment = deleteSecurityRefundedPayment,
       _updatePartialReturn = updatePartialReturn,
       super(const BookingDetailsState.loading()) {
    on<_FetchBookingDetails>(
      _onFetchBookingDetails,
      transformer: debounceDroppable(const Duration(milliseconds: 500)),
    );
    on<_UpdateDeliveryStatus>(
      _onUpdateDeliveryStatus,
      transformer: debounceDroppable(const Duration(milliseconds: 500)),
    );
    on<_UpdateBookingStatus>(_onUpdateBookingStatus);
    on<_UpdatePayment>(_onUpdatePayment);
    on<_DeletePayment>(_onDeletePayment);
    on<_CancelBooking>(_onCancelBooking);
    on<_DeleteBooking>(_onDeleteBooking);
    on<_AddRefund>(_onAddRefund);
    on<_DeleteRefund>(_onDeleteRefund);
    on<_UpdateSecurityRefund>(_onUpdateSecurityRefund);
    on<_DeleteSecurityRefundedPayment>(_onDeleteSecurityRefundedPayment);
    on<_UpdatePartialReturn>(_onUpdatePartialReturn);
  }

  Future<void> _onFetchBookingDetails(
    _FetchBookingDetails event,
    Emitter<BookingDetailsState> emit,
  ) async {
    if (state is! _Loading) emit(const BookingDetailsState.loading());
    try {
      final booking = await _getBooking(event.bookingId);

      emit(BookingDetailsState.loaded(booking: booking));
    } catch (e, stack) {
      log(e.toString(), stackTrace: stack);
      emit(BookingDetailsState.error(e.toString()));
    }
  }

  Future<void> _onUpdateDeliveryStatus(
    _UpdateDeliveryStatus event,
    Emitter<BookingDetailsState> emit,
  ) async {
    final oldState = state;
    try {
      await _updateDeliveryStatus(event.bookingId, event.deliveryStatus);
      if (oldState is _Loaded) {
        emit(
          BookingDetailsState.loaded(
            booking: oldState.booking.copyWith(
              deliveryStatus: event.deliveryStatus,
            ),
          ),
        );
      }
    } catch (e, stack) {
      log(e.toString(), stackTrace: stack);
      _emitFailedWithRollback(emit, e.toString(), oldState);
    }
  }

  Future<void> _onUpdateBookingStatus(
    _UpdateBookingStatus event,
    Emitter<BookingDetailsState> emit,
  ) async {
    final oldState = state;
    try {
      await _updateBookingStatus(event.bookingId, event.bookingStatus);
      if (oldState is _Loaded) {
        emit(
          BookingDetailsState.loaded(
            booking: oldState.booking.copyWith(
              bookingStatus: event.bookingStatus,
            ),
          ),
        );
      }
    } catch (e, stack) {
      log(e.toString(), stackTrace: stack);
      _emitFailedWithRollback(emit, e.toString(), oldState);
    }
  }

  Future<void> _onUpdatePayment(
    _UpdatePayment event,
    Emitter<BookingDetailsState> emit,
  ) async {
    final oldState = state;
    try {
      log(
        '📤 Updating payment: ${event.amount} for booking ${event.bookingId}',
      );
      if (event.useSecurityRefund) {
        await _updateSecurityRefund(
          bookingId: event.bookingId,
          refundAmount: event.amount,
          accountId: event.accountId,
        );
      }
      await _updatePayment(
        bookingId: event.bookingId,
        amount: event.amount,
        accountId: event.accountId,
        paymentDate: event.paymentDate,
      );

      log('✅ Payment updated, refetching booking details...');
      final booking = await _getBooking(event.bookingId);
      log(
        '📥 Fetched booking with ${booking.paymentHistory.length} payments, total: ${booking.actualPaidAmount}',
      );
      emit(BookingDetailsState.loaded(booking: booking));
    } catch (e, stack) {
      log(e.toString(), stackTrace: stack);
      _emitFailedWithRollback(emit, e.toString(), oldState);
    }
  }

  Future<void> _onDeletePayment(
    _DeletePayment event,
    Emitter<BookingDetailsState> emit,
  ) async {
    final oldState = state;
    try {
      await _deletePayment(event.paymentId);

      final booking = await _getBooking(event.bookingId);
      emit(BookingDetailsState.loaded(booking: booking));
      emit(
        const BookingDetailsState.success(
          'Payment deleted successfully',
          needRefresh: true,
        ),
      );
      emit(BookingDetailsState.loaded(booking: booking));
    } catch (e, stack) {
      log(e.toString(), stackTrace: stack);
      _emitFailedWithRollback(emit, e.toString(), oldState);
    }
  }

  Future<void> _onCancelBooking(
    _CancelBooking event,
    Emitter<BookingDetailsState> emit,
  ) async {
    final oldState = state;
    try {
      await _cancelBooking(
        bookingId: event.bookingId,
        refundAmount: event.refundAmount,
        accountId: event.accountId,
      );
      emit(const _Success('Booking cancelled successfully', needRefresh: true));
    } catch (e, stack) {
      log(e.toString(), stackTrace: stack);
      _emitFailedWithRollback(emit, e.toString(), oldState);
    }
  }

  Future<void> _onDeleteBooking(
    _DeleteBooking event,
    Emitter<BookingDetailsState> emit,
  ) async {
    final oldState = state;
    try {
      await _deleteBooking(event.bookingId);
      emit(
        const _Success(
          'Booking deleted successfully',
          didPop: true,
          needRefresh: false,
        ),
      );
    } catch (e, stack) {
      log(e.toString(), stackTrace: stack);
      _emitFailedWithRollback(emit, e.toString(), oldState);
    }
  }

  //
  FutureOr<void> _onAddRefund(
    _AddRefund event,
    Emitter<BookingDetailsState> emit,
  ) async {
    final oldState = state;
    try {
      await _addRefund(
        bookingId: event.bookingId,
        amount: event.amount,
        accountId: event.accountId,
        refundReason: event.refundReason,
      );

      log('✅ Refund added, refetching booking details...');

      final booking = await _getBooking(event.bookingId);
      log(
        '📥 Fetched booking with ${booking.paymentHistory.length} payments, total: ${booking.actualPaidAmount}',
      );
      emit(BookingDetailsState.loaded(booking: booking));
    } catch (e, stack) {
      log(e.toString(), stackTrace: stack);
      _emitFailedWithRollback(emit, e.toString(), oldState);
    }
  }

  //
  FutureOr<void> _onDeleteRefund(
    _DeleteRefund event,
    Emitter<BookingDetailsState> emit,
  ) async {
    final oldState = state;
    try {
      await _deleteRefund(bookingId: event.bookingId, refundId: event.refundId);

      final booking = await _getBooking(event.bookingId);
      emit(BookingDetailsState.loaded(booking: booking));
      emit(
        const BookingDetailsState.success(
          'Refund deleted successfully',
          needRefresh: true,
        ),
      );
      emit(BookingDetailsState.loaded(booking: booking));
    } catch (e, stack) {
      log(e.toString(), stackTrace: stack);
      _emitFailedWithRollback(emit, e.toString(), oldState);
    }
  }

  //
  FutureOr<void> _onUpdateSecurityRefund(
    _UpdateSecurityRefund event,
    Emitter<BookingDetailsState> emit,
  ) async {
    final oldState = state;
    try {
      await _updateSecurityRefund(
        bookingId: event.bookingId,
        refundAmount: event.refundAmount,
        deductionAmount: event.deductionAmount,
        accountId: event.accountId,
        note: event.note,
      );

      final booking = await _getBooking(event.bookingId);
      emit(BookingDetailsState.loaded(booking: booking));
    } catch (e, stack) {
      log(e.toString(), stackTrace: stack);
      _emitFailedWithRollback(emit, e.toString(), oldState);
    }
  }

  //
  FutureOr<void> _onDeleteSecurityRefundedPayment(
    _DeleteSecurityRefundedPayment event,
    Emitter<BookingDetailsState> emit,
  ) async {
    final oldState = state;
    try {
      await _deleteSecurityRefundedPayment(refundId: event.paymentId);

      final booking = await _getBooking(event.bookingId);
      emit(BookingDetailsState.loaded(booking: booking));
      emit(
        BookingDetailsState.success(
          'Security ${event.securityPaymentType.isRefund ? 'refund' : 'deduction'} deleted successfully',
          needRefresh: true,
        ),
      );
      emit(BookingDetailsState.loaded(booking: booking));
    } catch (e, stack) {
      log(e.toString(), stackTrace: stack);
      _emitFailedWithRollback(emit, e.toString(), oldState);
    }
  }

  //
  FutureOr<void> _onUpdatePartialReturn(
    _UpdatePartialReturn event,
    Emitter<BookingDetailsState> emit,
  ) async {
    final oldState = state;
    try {
      final response = await _updatePartialReturn(
        bookingId: event.bookingId,
        returnedProductIds: event.returnedProductIds,
        notReturnedProductIds: event.notReturnedProductIds,
        newReturnDate: event.newReturnDate,
      );

      if (response.status.isInsufficientStock) {
        // Hand the raw payload and the booked items to the UI so it can name
        // the products behind the conflict instead of just failing.
        emit(
          BookingDetailsState.failed(
            'Partial return update failed due to insufficient stock',
            error: response.data,
            products: oldState is _Loaded ? oldState.booking.bookedItems : null,
          ),
        );
        if (oldState is _Loaded) emit(oldState);
        return;
      }

      final booking = await _getBooking(event.bookingId);
      emit(BookingDetailsState.loaded(booking: booking));
      emit(
        const BookingDetailsState.success(
          'Partial return updated successfully',
          needRefresh: true,
        ),
      );
      emit(BookingDetailsState.loaded(booking: booking));
    } catch (e, stack) {
      log(e.toString(), stackTrace: stack);
      _emitFailedWithRollback(emit, e.toString(), oldState);
    }
  }

  void _emitFailedWithRollback(
    Emitter<BookingDetailsState> emit,
    String message,
    BookingDetailsState oldState,
  ) {
    emit(BookingDetailsState.failed(message));
    if (oldState is _Loaded) emit(oldState);
  }

  BookingDetailsEntity? getBooking() {
    final state = this.state;
    if (state is _Loaded) {
      return state.booking;
    }
    return null;
  }
}
