import 'package:bookie_buddy_shared/core/features/booking/domain/entities/booking_payment_history_entity/booking_payment_history_entity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'booking_details_security_refund_history_state.dart';
part 'booking_details_security_refund_history_cubit.freezed.dart';

class BookingDetailsSecurityRefundHistoryCubit
    extends Cubit<BookingDetailsSecurityRefundHistoryState> {
  BookingDetailsSecurityRefundHistoryCubit() : super(const _Collapsed());

  /// Show security refund/deduction history using data from the booking
  /// details API — no separate API call needed.
  void showHistory(List<BookingSecurityRefundHistoryEntity> history) {
    emit(const _Loading());

    try {
      emit(_Expanded(history));
    } catch (e) {
      emit(_Error(e.toString()));
    }
  }

  void collapseHistory() {
    if (state is! _Collapsed) emit(const _Collapsed());
  }

  bool get isExpanded => state is _Expanded;
}
