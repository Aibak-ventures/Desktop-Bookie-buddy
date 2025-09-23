import 'dart:developer';

import 'package:bookie_buddy_web/config/logger_config.dart';
import 'package:bookie_buddy_web/core/app_dependencies.dart';
import 'package:bookie_buddy_web/core/error/failures.dart';
import 'package:bookie_buddy_web/core/extensions/string_extensions.dart';
import 'package:bookie_buddy_web/core/models/booking_model/booking_model.dart';
import 'package:bookie_buddy_web/core/models/pagination_model.dart';
import 'package:bookie_buddy_web/core/navigation/navigations.dart';
import 'package:bookie_buddy_web/core/view_model/user_cubit.dart';
import 'package:bookie_buddy_web/features/home/models/carousel_data_model/carousel_data_model.dart';
import 'package:bookie_buddy_web/features/home/repository/dashboard_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'dashboard_bloc.freezed.dart';
part 'dashboard_event.dart';
part 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  final DashboardRepository _repository = getIt.get<DashboardRepository>();
  DashboardBloc() : super(const _Loading()) {
    on<_LoadDashboardData>(_onLoadDashboardData);
    on<_LoadDashboardNextPageData>(_onLoadDashboardNextPageData);
    // on<_Search>(_onSearch);
    on<_UpdateBooking>(_onUpdateBooking);
    on<_LoadIfNot>(_loadIfNot);
  }
  CarouselDataModel? previousCarousel;
  CarouselDataModel carouselResponse = CarouselDataModel(
    upComingCount: 0,
    completedCount: 0,
  );
  Map<String, List<BookingsModel>> _groupBookings(
      List<BookingsModel> bookings) {
    final todayList = <BookingsModel>[];
    final tomorrowList = <BookingsModel>[];
    final upcomingList = <BookingsModel>[];

    for (var booking in bookings) {
      if (booking.pickupDate!.isDateToday) {
        todayList.add(booking);
      } else if (booking.pickupDate!.isDateTomorrow) {
        tomorrowList.add(booking);
      } else {
        upcomingList.add(booking);
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
      _LoadDashboardData event, Emitter<DashboardState> emit) async {
    emit(const _Loading());
    previousCarousel = carouselResponse;
    try {
      navigatorKey.currentContext?.read<UserCubit>().loadUserIfNot();
      final result = await _repository.loadDashboardData(page: 1);
      final bookings = result.$1.data;
      final nextPage = result.$1.nextPageUrl;
      carouselResponse = result.$2;
      // final bookingGroupedList = _groupBookings(bookings);
      emit(
        _Loaded(
          bookingsGrouped: _groupBookings(bookings),
          nextPageUrl: nextPage,
          carouselData: carouselResponse,
        ),
      );

      logIt.i(nextPage);
    } catch (e) {
      emit(
        _Error(e as Failure),
      );
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
      _LoadDashboardNextPageData event, Emitter<DashboardState> emit) async {
    if (state is! _Loaded) return;
    final s = state as _Loaded;

    if (s.nextPageUrl == null || s.isPaginating) return;

    emit(
      s.copyWith(isPaginating: true),
    );

    try {
      final page = PaginationModel.getPageFromUrl(s.nextPageUrl);
      final result = await _repository.loadDashboardData(page: page);
      final newBookings = result.$1.data;
      final nextPage = result.$1.nextPageUrl;
      final newGrouped = _groupBookings(newBookings);

      /// Merge the existing groups with the new groups
      final mergedGrouped = {...s.bookingsGrouped};

      newGrouped.forEach((key, value) {
        if (mergedGrouped.containsKey(key)) {
          mergedGrouped[key] = [...mergedGrouped[key]!, ...value];
        } else {
          mergedGrouped[key] = value;
        }
      });

      emit(
        s.copyWith(
          bookingsGrouped: mergedGrouped,
          nextPageUrl: nextPage,
          carouselData: result.$2,
          isPaginating: false,
        ),
      );
      logIt.i(nextPage);
    } catch (e) {
      emit(
        _Error(e as Failure),
      );
    }
  }

  // Future<void> _onSearch(_Search event, Emitter<DashboardState> emit) async {
  //   emit(const _Loading());

  //   try {
  //     final bookings = await _repository.searchBookings(event.query);

  //     /// You need to group the search result
  //     final groupedBookings = _groupBookings(bookings);

  //     emit(
  //       _Loaded(
  //         bookingsGrouped: groupedBookings,
  //         carouselData: carouselResponse,
  //         nextPageUrl: null,
  //       ),
  //     );
  //   } catch (e) {
  //     emit(
  //       _Error(e as Failure),
  //     );
  //   }
  // }

  Future<void> _onUpdateBooking(
      _UpdateBooking event, Emitter<DashboardState> emit) async {
    if (event.shouldRefresh) {
      log('refreshing');
      add(const DashboardEvent.loadDashboardData());
      return;
    }

    if (event.booking == null) {
      log('booking is null, cancelling update');
      return;
    }

    final s = state as _Loaded;

    final updatedGrouped = {...s.bookingsGrouped};

    updatedGrouped.forEach((key, bookingsList) {
      final index = bookingsList.indexWhere((b) => b.id == event.booking!.id);
      if (index != -1) {
        bookingsList[index] = event.booking!;
      }
    });

    emit(
      s.copyWith(
        bookingsGrouped: updatedGrouped,
      ),
    );
  }

  void _loadIfNot(_LoadIfNot event, Emitter<DashboardState> emit) {
    if (state is! _Loaded) add(const DashboardEvent.loadDashboardData());
  }

  void reset() {
    previousCarousel = null;
    carouselResponse = CarouselDataModel(
      upComingCount: 0,
      completedCount: 0,
    );
  }
}
