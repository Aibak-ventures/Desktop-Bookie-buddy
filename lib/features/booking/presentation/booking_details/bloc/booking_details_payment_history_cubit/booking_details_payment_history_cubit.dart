import 'package:bookie_buddy_web/features/booking/domain/entities/booking_payment_history_entity/booking_payment_history_entity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'booking_details_payment_history_state.dart';
part 'booking_details_payment_history_cubit.freezed.dart';

class BookingDetailsPaymentHistoryCubit
    extends Cubit<BookingDetailsPaymentHistoryState> {
  BookingDetailsPaymentHistoryCubit() : super(const _Collapsed());

  /// Show payment history using data from booking details API
  /// No separate API call needed - data comes from booking.payments and booking.refunds
  void showPaymentHistory(
    List<BookingPaymentHistoryEntity> payments,
    List<dynamic> refunds,
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
