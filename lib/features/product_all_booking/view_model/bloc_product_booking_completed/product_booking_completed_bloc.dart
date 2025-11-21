import 'package:bookie_buddy_web/core/models/booking_model/booking_model.dart';
import 'package:bookie_buddy_web/core/models/pagination_model/pagination_model.dart';
import 'package:bookie_buddy_web/core/repositories/product_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'product_booking_completed_event.dart';
part 'product_booking_completed_state.dart';
part 'product_booking_completed_bloc.freezed.dart';

class ProductBookingCompletedBloc
    extends Bloc<ProductBookingCompletedEvent, ProductBookingCompletedState> {
  final ProductRepository _repository;
  ProductBookingCompletedBloc({required ProductRepository repository})
      : _repository = repository,
        super(const _Loading()) {
    on<_LoadBookings>(_onLoadBookings);
    on<_LoadNextBookings>(_onLoadNextPageBookings);
  }

  static const String _status = 'completed';

  Future<void> _onLoadBookings(
    _LoadBookings event,
    Emitter<ProductBookingCompletedState> emit,
  ) async {
    emit(const _Loading());
    try {
      final result = await _repository.getProductBookings(
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
    Emitter<ProductBookingCompletedState> emit,
  ) async {
    if (state is! _Loaded) return;
    final s = state as _Loaded;

    if (s.nextPageUrl == null || s.isPaginating) return;

    emit(s.copyWith(isPaginating: true));
    try {
      final page = PaginationModel.getPageFromUrl(s.nextPageUrl);
      final result = await _repository.getProductBookings(
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
