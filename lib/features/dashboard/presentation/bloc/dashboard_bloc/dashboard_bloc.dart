import 'dart:developer';

import 'package:bookie_buddy_web/core/models/pagination_model/pagination_model.dart';
import 'package:bookie_buddy_web/core/models/user_model/user_model.dart';
import 'package:bookie_buddy_web/core/models/booking_model/booking_model.dart';
import 'package:bookie_buddy_web/core/view_model/user_cubit.dart';
import 'package:bookie_buddy_web/features/dashboard/domain/models/desktop_dashboard_response.dart';
import 'package:bookie_buddy_web/features/dashboard/domain/usecases/get_dashboard_desktop_data_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'dashboard_bloc.freezed.dart';
part 'dashboard_event.dart';
part 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  final GetDashboardDesktopDataUseCase _getDashboardDesktopDataUseCase;
  final UserCubit? _userCubit;

  DashboardBloc({
    required GetDashboardDesktopDataUseCase getDashboardDesktopDataUseCase,
    UserCubit? userCubit,
  })  : _getDashboardDesktopDataUseCase = getDashboardDesktopDataUseCase,
        _userCubit = userCubit,
        super(const _Loading()) {
    on<_LoadDashboardData>(_onLoadDashboardData);
    on<_LoadDashboardNextPageData>(_onLoadDashboardNextPageData);
    on<_UpdateData>(_onUpdateData);
    on<_LoadIfNot>(_loadIfNot);
  }

  DesktopDashboardCarouselData? previousCarousel;
  DesktopDashboardCarouselData carouselResponse =
      DesktopDashboardCarouselData.empty();

  // Groups bookings into 'today', 'tomorrow', and 'upcoming' based on their pickup or return dates.
  Map<String, List<BookingsModel>> _groupData(
    List<BookingsModel> bookings, {
    required bool useReturnDate,
  }) {
    final todayList = <BookingsModel>[];
    final tomorrowList = <BookingsModel>[];
    final upcomingList = <BookingsModel>[];

    final today = DateTime.now();
    final tomorrow = today.add(const Duration(days: 1));

    for (final booking in bookings) {
      // Determine the relevant date based on whether it's for returns or upcoming
      final dateString =
          useReturnDate ? booking.returnDate : booking.pickupDate;

      if (dateString == null || dateString.isEmpty) continue;

      try {
        // Parse the string date - handle DD-MM-YYYY HH:mm:ss format from API
        DateTime date;

        if (dateString.contains('-') && dateString.split('-').length == 3) {
          // Handle DD-MM-YYYY HH:mm:ss format from API
          final parts = dateString.split(' ');
          final datePart = parts[0];
          final dateComponents = datePart.split('-');

          if (dateComponents.length == 3) {
            final day = int.parse(dateComponents[0]);
            final month = int.parse(dateComponents[1]);
            final year = int.parse(dateComponents[2]);
            date = DateTime(year, month, day);
          } else {
            continue; // Skip invalid date format
          }
        } else {
          // Try to parse as ISO format (fallback)
          date = DateTime.parse(dateString);
        }

        // Reset time to compare dates only
        final bookingDate = DateTime(date.year, date.month, date.day);
        final todayDate = DateTime(today.year, today.month, today.day);
        final tomorrowDate =
            DateTime(tomorrow.year, tomorrow.month, tomorrow.day);

        if (bookingDate == todayDate) {
          todayList.add(booking);
        } else if (bookingDate == tomorrowDate) {
          tomorrowList.add(booking);
        } else {
          upcomingList.add(booking);
        }
      } catch (e) {
        // Skip bookings with invalid date formats
        log('Error parsing date: $dateString - $e');
        continue;
      }
    }

    return {
      'today': todayList,
      'tomorrow': tomorrowList,
      'upcoming': upcomingList,
    };
  }

  /// Loads the first page of desktop dashboard data using the new v4 API.
  ///
  /// If the loading succeeds, it will emit [DashboardState.loaded] with the
  /// loaded bookings grouped by Today/Tomorrow/Upcoming and carousel response.
  ///
  /// If the loading fails, it will emit [DashboardState.error] with the error.
  Future<void> _onLoadDashboardData(
    _LoadDashboardData event,
    Emitter<DashboardState> emit,
  ) async {
    emit(const _Loading());
    previousCarousel = carouselResponse;

    try {
      final activeShop = event.activeShop ?? _userCubit?.state;
      final response = await _getDashboardDesktopDataUseCase.call(
        page: 1,
        activeShop: activeShop,
      );

      // Group data for UI display
      final upcomingGrouped =
          _groupData(response.upcoming, useReturnDate: false);
      final returnsGrouped =
          _groupData(response.ongoingBookings, useReturnDate: true);

      // Update carousel data
      carouselResponse = response.carouselData;

      emit(
        _Loaded(
          upcomingGrouped: upcomingGrouped,
          returnsGrouped: returnsGrouped,
          nextPageUrl: response.nextPageUrl,
          carouselData: carouselResponse,
          currentPage: response.currentPage,
          totalPages: response.totalPages,
          isPaginating: false,
        ),
      );
    } catch (e) {
      emit(_Error(e.toString()));
    }
  }

  /// Loads the next page of dashboard data using the new v4 API.
  ///
  /// If the state is not [_Loaded], it will do nothing.
  ///
  /// If the next page url is null or the state is already paginating, it will do
  /// nothing.
  ///
  /// It will emit [_Loaded] with the new bookings merged with existing data.
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
      final activeShop = _userCubit?.state;
      final response = await _getDashboardDesktopDataUseCase.call(
        page: page,
        activeShop: activeShop,
      );

      // Group the new data
      final newUpcomingGrouped =
          _groupData(response.upcoming, useReturnDate: false);
      final newReturnsGrouped =
          _groupData(response.ongoingBookings, useReturnDate: true);

      // Merge the existing groups with the new groups
      final mergedUpcomingGrouped = {...s.upcomingGrouped};
      final mergedReturnsGrouped = {...s.returnsGrouped};

      newUpcomingGrouped.forEach((key, value) {
        if (mergedUpcomingGrouped.containsKey(key)) {
          mergedUpcomingGrouped[key] = [
            ...mergedUpcomingGrouped[key]!,
            ...value
          ];
        } else {
          mergedUpcomingGrouped[key] = value;
        }
      });

      newReturnsGrouped.forEach((key, value) {
        if (mergedReturnsGrouped.containsKey(key)) {
          mergedReturnsGrouped[key] = [...mergedReturnsGrouped[key]!, ...value];
        } else {
          mergedReturnsGrouped[key] = value;
        }
      });

      emit(
        s.copyWith(
          upcomingGrouped: mergedUpcomingGrouped,
          returnsGrouped: mergedReturnsGrouped,
          nextPageUrl: response.nextPageUrl,
          carouselData: response.carouselData,
          currentPage: response.currentPage,
          totalPages: response.totalPages,
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
    if (event.shouldRefresh) {
      log('refreshing dashboard data');
      add(DashboardEvent.loadDashboardData(activeShop: _userCubit?.state));
      return;
    }

    if (event.updateBooking == null) {
      log('booking is null, cancelling update');
      return;
    }

    final s = state as _Loaded;

    // Create deep copies of the grouped data
    final updatedUpcomingGrouped = {
      for (final entry in s.upcomingGrouped.entries)
        entry.key: List<BookingsModel>.from(entry.value),
    };
    final updatedReturnsGrouped = {
      for (final entry in s.returnsGrouped.entries)
        entry.key: List<BookingsModel>.from(entry.value),
    };

    final eventId = event.updateBooking?.id;

    if (event.isDeleted) {
      // Remove from both upcoming and returns groups
      updatedUpcomingGrouped.forEach((key, bookingList) {
        bookingList.removeWhere((b) => b.id == eventId);
      });
      updatedReturnsGrouped.forEach((key, bookingList) {
        bookingList.removeWhere((b) => b.id == eventId);
      });
    } else {
      // Update in both groups if found
      updatedUpcomingGrouped.forEach((key, bookingList) {
        final index = bookingList.indexWhere((b) => b.id == eventId);
        if (index != -1) {
          bookingList[index] = event.updateBooking!;
        }
      });
      updatedReturnsGrouped.forEach((key, bookingList) {
        final index = bookingList.indexWhere((b) => b.id == eventId);
        if (index != -1) {
          bookingList[index] = event.updateBooking!;
        }
      });
    }

    emit(s.copyWith(
      upcomingGrouped: updatedUpcomingGrouped,
      returnsGrouped: updatedReturnsGrouped,
    ));
  }

  void _loadIfNot(_LoadIfNot event, Emitter<DashboardState> emit) {
    if (state is! _Loaded) {
      add(DashboardEvent.loadDashboardData(activeShop: _userCubit?.state));
    }
  }

  void reset() {
    previousCarousel = null;
    carouselResponse = DesktopDashboardCarouselData.empty();
  }
}
