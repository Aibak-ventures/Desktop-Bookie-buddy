import 'package:bloc/bloc.dart';
import 'package:bookie_buddy_web/core/app_dependencies.dart';
import 'package:bookie_buddy_web/core/repositories/booking_repository.dart';
import 'package:bookie_buddy_web/features/booking_details/models/booking_details_payment_history_model/booking_details_payment_history_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'booking_details_payment_history_state.dart';
part 'booking_details_payment_history_cubit.freezed.dart';

class BookingDetailsPaymentHistoryCubit
    extends Cubit<BookingDetailsPaymentHistoryState> {
  final BookingRepository _bookingRepository = getIt.get<BookingRepository>();

  BookingDetailsPaymentHistoryCubit() : super(const _Collapsed());

  void showPaymentHistory(int bookingId) async {
    emit(const _Loading());

    try {
      final paymentHistory =
          await _bookingRepository.getPaymentHistory(bookingId);
      emit(_Expanded(paymentHistory));
    } catch (e) {
      emit(_Error(e.toString()));
    }
  }

  void collapsePaymentHistory() {
    emit(const _Collapsed());
  }

  bool get isExpanded => state is _Expanded;
}
