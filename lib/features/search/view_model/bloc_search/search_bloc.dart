import 'dart:developer';

import 'package:bookie_buddy_web/core/enums/booking_status_enums.dart';
import 'package:bookie_buddy_web/core/models/booking_model/booking_model.dart';
import 'package:bookie_buddy_web/core/models/pagination_model/pagination_model.dart';
import 'package:bookie_buddy_web/core/repositories/booking_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'search_bloc.freezed.dart';
part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final BookingRepository _repository;
  SearchBloc({required BookingRepository repository})
      : _repository = repository,
        super(const _Initial()) {
    on<_Search>(_onSearch);
    on<_LoadNextSearchResults>(_onLoadNextSearchResult);
    on<_Reset>(_onReset);
  }

  Future<void> _onSearch(_Search event, Emitter<SearchState> emit) async {
    emit(const _Loading());
    try {
      final result = await _repository.loadBookingsPagination(
        status: LoadBookingType.all,
        searchQuery: event.query,
        startDate: event.startDate,
        endDate: event.endDate,
      );

      emit(_Loaded(bookings: result.data, nextPageUrl: result.nextPageUrl));
    } catch (e, stack) {
      log(e.toString(), stackTrace: stack);
      emit(_Error(e.toString()));
    }
  }

  Future<void> _onLoadNextSearchResult(
    _LoadNextSearchResults event,
    Emitter<SearchState> emit,
  ) async {
    if (state is! _Loaded) return;
    final s = state as _Loaded;
    if (s.isPaginating || s.nextPageUrl == null) return;

    emit(s.copyWith(isPaginating: true));
    try {
      final page = PaginationModel.getPageFromUrl(s.nextPageUrl);
      final result = await _repository.loadBookingsPagination(
        status: LoadBookingType.all,
        searchQuery: event.query,
        page: page,
        startDate: event.startDate,
        endDate: event.endDate,
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

  Future<void> _onReset(_Reset event, Emitter<SearchState> emit) async {
    emit(const _Initial());
  }
}
