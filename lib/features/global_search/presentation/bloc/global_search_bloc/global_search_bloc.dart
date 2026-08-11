import 'dart:developer';

import 'package:bookie_buddy_web/core/common/models/pagination_model/pagination_model.dart';
import 'package:bookie_buddy_web/features/global_search/domain/entities/global_search_entity/global_search_entity.dart';
import 'package:bookie_buddy_web/features/global_search/domain/usecases/get_global_search_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'global_search_bloc.freezed.dart';
part 'global_search_event.dart';
part 'global_search_state.dart';

class GlobalSearchBloc extends Bloc<GlobalSearchEvent, GlobalSearchState> {
  final GetGlobalSearchUseCase _getGlobalSearchUseCase;
  GlobalSearchBloc({required GetGlobalSearchUseCase getGlobalSearchUseCase})
    : _getGlobalSearchUseCase = getGlobalSearchUseCase,
      super(const _Initial()) {
    on<_Search>(_onSearch);
    on<_LoadNextSearchResults>(_onLoadNextSearchResult);
    on<_Reset>(_onReset);
  }

  Future<void> _onSearch(_Search event, Emitter<GlobalSearchState> emit) async {
    emit(const _Loading());
    try {
      final result = await _getGlobalSearchUseCase(
        searchQuery: event.query,
        startDate: event.startDate,
        endDate: event.endDate,
      );

      emit(_Loaded(searchData: result.data, nextPageUrl: result.nextPageUrl));
    } catch (e, stack) {
      log(e.toString(), stackTrace: stack);
      emit(_Error(e.toString()));
    }
  }

  Future<void> _onLoadNextSearchResult(
    _LoadNextSearchResults event,
    Emitter<GlobalSearchState> emit,
  ) async {
    if (state is! _Loaded) return;
    final s = state as _Loaded;
    if (s.isPaginating || s.nextPageUrl == null) return;

    emit(s.copyWith(isPaginating: true));
    try {
      final page = PaginationModel.getPageFromUrl(s.nextPageUrl);
      final result = await _getGlobalSearchUseCase(
        page: page,
        searchQuery: event.query,
        startDate: event.startDate,
        endDate: event.endDate,
      );

      emit(
        s.copyWith(
          searchData: [...s.searchData, ...result.data],
          nextPageUrl: result.nextPageUrl,
          isPaginating: false,
        ),
      );
    } catch (e) {
      emit(_Error(e.toString()));
    }
  }

  _Loaded? get loadedState => state is _Loaded ? state as _Loaded : null;

  Future<void> _onReset(_Reset event, Emitter<GlobalSearchState> emit) async {
    emit(const _Initial());
  }
}
