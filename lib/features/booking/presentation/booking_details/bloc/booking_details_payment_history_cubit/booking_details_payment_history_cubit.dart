import 'package:bookie_buddy_shared/core/features/booking/domain/entities/booking_payment_history_entity/booking_payment_history_entity.dart';
import 'package:bookie_buddy_shared/core/features/booking/domain/entities/booking_refund_history_entity/booking_refund_history_entity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'booking_details_payment_history_state.dart';
part 'booking_details_payment_history_cubit.freezed.dart';

class BookingDetailsPaymentHistoryCubit
    extends Cubit<BookingDetailsPaymentHistoryState> {
  BookingDetailsPaymentHistoryCubit() : super(const _Collapsed());

  /// Show payment history using data from booking details API
  /// No separate API call needed - data comes from booking.paymentHistory and
  /// booking.refundHistory. [refunds] isn't stored in state — the caller
  /// (BookingDetailsPaymentSection) passes booking.refundHistory straight
  /// into BookingPaymentHistoryTile itself; kept as a parameter here only
  /// so this method's signature documents what the caller actually has
  /// available at the call site.
  void showPaymentHistory(
    List<BookingPaymentHistoryEntity> payments,
    List<BookingRefundHistoryEntity> refunds,
  ) {
    emit(const _Loading());

    try {
      // Use the payments data directly from booking details
      emit(_Expanded(payments));
    } catch (e) {
      emit(_Error(e.toString()));
    }
  }

  void collapsePaymentHistory() {
    if (state is! _Collapsed) emit(const _Collapsed());
  }

  bool get isExpanded => state is _Expanded;
}
