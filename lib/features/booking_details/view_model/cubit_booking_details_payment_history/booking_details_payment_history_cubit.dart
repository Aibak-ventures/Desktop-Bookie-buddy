import 'package:bookie_buddy_web/core/repositories/booking_repository.dart';
import 'package:bookie_buddy_web/features/booking_details/models/booking_details_payment_history_model/booking_details_payment_history_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'booking_details_payment_history_state.dart';
part 'booking_details_payment_history_cubit.freezed.dart';

class BookingDetailsPaymentHistoryCubit
    extends Cubit<BookingDetailsPaymentHistoryState> {
  final BookingRepository _repository;

  BookingDetailsPaymentHistoryCubit({required BookingRepository repository})
      : _repository = repository,
        super(const _Collapsed());

  void showPaymentHistory(int bookingId) async {
    emit(const _Loading());

    try {
      final paymentHistory = await _repository.getPaymentHistory(bookingId);
      emit(_Expanded(paymentHistory));
    } catch (e) {
      emit(_Error(e.toString()));
    }
  }

  void collapsePaymentHistory() {
    if (state is! _Collapsed) emit(const _Collapsed());
  }

  bool get isExpanded => state is _Expanded;
}
