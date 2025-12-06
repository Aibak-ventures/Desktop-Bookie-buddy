import 'dart:developer';

import 'package:bookie_buddy_web/core/extensions/string_extensions.dart';
import 'package:bookie_buddy_web/core/models/pagination_model/pagination_model.dart';
import 'package:bookie_buddy_web/features/home/models/carousel_data_model/carousel_data_model.dart';
import 'package:bookie_buddy_web/features/home/models/dashboard_list_model.dart';
import 'package:bookie_buddy_web/features/home/repository/dashboard_repository.dart';
// import 'package:booking_applica/features/home/repository/dashboard_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'dashboard_bloc.freezed.dart';
part 'dashboard_event.dart';
part 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  final DashboardRepository _repository;
  DashboardBloc({required DashboardRepository repository})
    : _repository = repository,
      super(const _Loading()) {
    on<_LoadDashboardData>(_onLoadDashboardData);
    on<_LoadDashboardNextPageData>(_onLoadDashboardNextPageData);
    on<_UpdateData>(_onUpdateData);
    on<_LoadIfNot>(_loadIfNot);
  }
  CarouselDataModel? previousCarousel;
  CarouselDataModel carouselResponse = CarouselDataModel.initial();

  // Groups bookings into 'today', 'tomorrow', and 'upcoming' based on their pickup or return dates.
  Map<String, List<DashboardListModel>> _groupData(
    List<DashboardListModel> dashboardData, {
    bool isOngoing = false,
  }) {
    final todayList = <DashboardListModel>[];
    final tomorrowList = <DashboardListModel>[];
    final upcomingList = <DashboardListModel>[];

    for (final data in dashboardData) {
      // when using pickup date for grouping we need to check both booking and custom work
      // and use the available one that means that data could be either booking or custom work
      final pickupDate =
          data.booking?.pickupDate ?? data.customWork?.pickupDate;
      // Determine the relevant date based on whether it's ongoing or not
      // For ongoing bookings, use the return date; otherwise, use the pickup date for bookings or custom work.
      final date = isOngoing ? data.booking!.returnDate : pickupDate;
      if (date!.isDateToday) {
        todayList.add(data);
      } else if (date.isDateTomorrow) {
        tomorrowList.add(data);
      } else {
        upcomingList.add(data);
      }
    }

    return {
      'today': todayList,
      'tomorrow': tomorrowList,
      'upcoming': upcomingList,
    };
  }

  /// Loads the first page of dashboard data.
  ///
  /// If the user is not loaded, it will trigger the user loading process.
  ///
  /// If the loading succeeds, it will emit [DashboardState.loaded] with the
  /// loaded bookings, next page url, and carousel response.
  ///
  /// If the loading fails, it will emit [DashboardState.error] with the error.
  Future<void> _onLoadDashboardData(
    _LoadDashboardData event,
    Emitter<DashboardState> emit,
  ) async {
    final s = state is _Loaded && event.useOldState ? state as _Loaded : null;
    emit(const _Loading());
    previousCarousel = carouselResponse;

    try {
      final isOngoing = s?.isOngoing ?? event.isOngoing;
      final result = await _repository.loadDashboardData(isOngoing: isOngoing);
      final data = result.data;
      final nextPage = data.nextPageUrl;
      carouselResponse = result.carousel;
      emit(
        _Loaded(
          dataGrouped: _groupData(data.data, isOngoing: isOngoing),
          nextPageUrl: nextPage,
          carouselData: carouselResponse,
          isOngoing: isOngoing,
        ),
      );
    } catch (e) {
      emit(_Error(e.toString()));
    }
  }

  /// Loads the next page of dashboard data.
  ///
  /// If the state is not [_Loaded], it will do nothing.
  ///
  /// If the next page url is null or the state is already paginating, it will do
  /// nothing.
  ///
  /// It will emit [_Loaded] with the new bookings, next page url, and carousel
  /// response.
  ///
  /// If the loading fails, it will emit [_Error] with the error.
  Future<void> _onLoadDashboardNextPageData(
    _LoadDashboardNextPageData event,
    Emitter<DashboardState> emit,
  ) async {
    if (state is! _Loaded) return;
    final s = state as _Loaded;

    if (s.nextPageUrl == null || s.isPaginating) return;

    emit(s.copyWith(isPaginating: true));

    try {
      final page = PaginationModel.getPageFromUrl(s.nextPageUrl);
      final result = await _repository.loadDashboardData(
        page: page,
        isOngoing: s.isOngoing,
      );
      final newData = result.data;
      final nextPage = newData.nextPageUrl;
      final newGrouped = _groupData(newData.data, isOngoing: s.isOngoing);

      /// Merge the existing groups with the new groups
      final mergedGrouped = {...s.dataGrouped};

      newGrouped.forEach((key, value) {
        if (mergedGrouped.containsKey(key)) {
          mergedGrouped[key] = [...mergedGrouped[key]!, ...value];
        } else {
          mergedGrouped[key] = value;
        }
      });

      emit(
        s.copyWith(
          dataGrouped: mergedGrouped,
          nextPageUrl: nextPage,
          carouselData: result.carousel,
          isPaginating: false,
        ),
      );
    } catch (e) {
      emit(_Error(e.toString()));
    }
  }

  Future<void> _onUpdateData(
    _UpdateData event,
    Emitter<DashboardState> emit,
  ) async {
    if (event.shouldRefresh && !event.isDeleted) {
      log('refreshing');
      add(const DashboardEvent.loadDashboardData());
      return;
    }

    if (event.updateData == null) {
      log('booking is null, cancelling update');
      return;
    }

    final s = state as _Loaded;

    final updatedGrouped = {
      for (final entry in s.dataGrouped.entries)
        entry.key: List<DashboardListModel>.from(entry.value),
    };
    final eventId =
        event.updateData?.booking?.id ?? event.updateData?.customWork?.id;

    if (event.isDeleted) {
      updatedGrouped.forEach((key, dataList) {
        dataList.removeWhere((b) {
          final leftId = b.booking?.id ?? b.customWork?.id;
          return leftId == eventId;
        });
      });
    } else {
      updatedGrouped.forEach((key, dataList) {
        final index = dataList.indexWhere((b) {
          final leftId = b.booking?.id ?? b.customWork?.id;
          return leftId == eventId;
        });
        if (index != -1) {
          dataList[index] = event.updateData!;
        }
      });
    }

    emit(s.copyWith(dataGrouped: updatedGrouped));
  }

  void _loadIfNot(_LoadIfNot event, Emitter<DashboardState> emit) {
    if (state is! _Loaded) add(const DashboardEvent.loadDashboardData());
  }

  void reset() {
    previousCarousel = null;
    carouselResponse = CarouselDataModel.initial();
  }
}