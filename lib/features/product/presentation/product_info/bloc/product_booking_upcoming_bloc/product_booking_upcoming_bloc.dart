import 'package:bookie_buddy_web/features/booking/domain/models/booking_model/booking_model.dart';
import 'package:bookie_buddy_web/core/models/pagination_model/pagination_model.dart';
import 'package:bookie_buddy_web/features/product/domain/usecases/get_product_bookings_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'product_booking_upcoming_event.dart';
part 'product_booking_upcoming_state.dart';
part 'product_booking_upcoming_bloc.freezed.dart';

class ProductBookingUpcomingBloc
    extends Bloc<ProductBookingUpcomingEvent, ProductBookingUpcomingState> {
  final GetProductBookingsUseCase _getProductBookings;

  ProductBookingUpcomingBloc(
      {required GetProductBookingsUseCase getProductBookings})
      : _getProductBookings = getProductBookings,
        super(const _Loading()) {
    on<_LoadBookings>(_onLoadBookings);
    on<_LoadNextBookings>(_onLoadNextPageBookings);
  }

  static const String _status = 'upcoming';

  Future<void> _onLoadBookings(
    _LoadBookings event,
    Emitter<ProductBookingUpcomingState> emit,
  ) async {
    emit(const _Loading());
    try {
      final result = await _getProductBookings(
        productId: event.productId,
        status: _status,
      );

      emit(_Loaded(bookings: result.data, nextPageUrl: result.nextPageUrl));
    } catch (e) {
      emit(_Error(e.toString()));
    }
  }

  Future<void> _onLoadNextPageBookings(
    _LoadNextBookings event,
    Emitter<ProductBookingUpcomingState> emit,
  ) async {
    if (state is! _Loaded) return;
    final s = state as _Loaded;

    if (s.nextPageUrl == null || s.isPaginating) return;

    emit(s.copyWith(isPaginating: true));
    try {
      final page = PaginationModel.getPageFromUrl(s.nextPageUrl);
      final result = await _getProductBookings(
        productId: event.productId,
        page: page,
        status: _status,
      );

      emit(
        s.copyWith(
          bookings: [...s.bookings, ...result.data],
          nextPageUrl: result.nextPageUrl,
          isPaginating: false,
        ),
      );
    } catch (e) {
      emit(_Error(e.toString()));
    }
  }
}
