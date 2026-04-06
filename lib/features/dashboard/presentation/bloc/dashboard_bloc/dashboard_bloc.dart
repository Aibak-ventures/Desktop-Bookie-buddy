import 'dart:developer';

import 'package:bookie_buddy_web/core/common/models/pagination_model/pagination_model.dart';
import 'package:bookie_buddy_web/core/common/entities/user_entity/user_entity.dart';
import 'package:bookie_buddy_web/features/booking/domain/entities/booking_entity/booking_entity.dart';
import 'package:bookie_buddy_web/features/auth/presentation/bloc/user_cubit/user_cubit.dart';
import 'package:bookie_buddy_web/features/dashboard/domain/entities/desktop_dashboard_carousel_entity/desktop_dashboard_carousel_entity.dart';
import 'package:bookie_buddy_web/features/dashboard/domain/usecases/get_dashboard_desktop_data_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:bookie_buddy_web/utils/bloc_transforms.dart';

part 'dashboard_bloc.freezed.dart';
part 'dashboard_event.dart';
part 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  final GetDashboardDesktopDataUseCase _getDashboardDesktopDataUseCase;
  final UserCubit? _userCubit;

  DashboardBloc({
    required GetDashboardDesktopDataUseCase getDashboardDesktopDataUseCase,
    UserCubit? userCubit,
  }) : _getDashboardDesktopDataUseCase = getDashboardDesktopDataUseCase,
       _userCubit = userCubit,
       super(const _Loading()) {
    on<_LoadDashboardData>(_onLoadDashboardData);
    on<_LoadDashboardNextPageData>(
      _onLoadDashboardNextPageData,
      transformer: throttleDroppable(),
    );
    on<_UpdateData>(_onUpdateData);
    on<_LoadIfNot>(_loadIfNot);
  }

  DesktopDashboardCarouselEntity? previousCarousel;
  DesktopDashboardCarouselEntity carouselResponse =
      DesktopDashboardCarouselEntity.empty();

  // Groups bookings into 'today', 'tomorrow', and 'upcoming' based on their pickup or return dates.
  Map<String, List<BookingEntity>> _groupData(
    List<BookingEntity> bookings, {
    required bool useReturnDate,
  }) {
    final todayList = <BookingEntity>[];
    final tomorrowList = <BookingEntity>[];
    final upcomingList = <BookingEntity>[];

    final today = DateTime.now();
    final tomorrow = today.add(const Duration(days: 1));

    for (final booking in bookings) {
      final dateString = useReturnDate
          ? booking.returnDate
          : booking.pickupDate;

      if (dateString == null || dateString.isEmpty) {
        upcomingList.add(booking);
        continue;
      }

      try {
        DateTime date;

        if (dateString.contains('-') && dateString.split('-').length == 3) {
          final parts = dateString.split(' ');
          final datePart = parts[0];
          final dateComponents = datePart.split('-');

          if (dateComponents.length == 3) {
            final day = int.parse(dateComponents[0]);
            final month = int.parse(dateComponents[1]);
            final year = int.parse(dateComponents[2]);
            date = DateTime(year, month, day);
          } else {
            continue;
          }
        } else {
          date = DateTime.parse(dateString);
        }

        final bookingDate = DateTime(date.year, date.month, date.day);
        final todayDate = DateTime(today.year, today.month, today.day);
        final tomorrowDate = DateTime(
          tomorrow.year,
          tomorrow.month,
          tomorrow.day,
        );

        if (bookingDate == todayDate) {
          todayList.add(booking);
        } else if (bookingDate == tomorrowDate) {
          tomorrowList.add(booking);
        } else {
          upcomingList.add(booking);
        }
      } catch (e) {
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

  Future<void> _onLoadDashboardData(
    _LoadDashboardData event,
    Emitter<DashboardState> emit,
  ) async {
    emit(const _Loading());
    previousCarousel = carouselResponse;

    try {
      final activeShop = event.activeShop ?? _userCubit?.state;
      final entity = await _getDashboardDesktopDataUseCase.call(
        page: 1,
        activeShop: activeShop,
      );

      final upcomingGrouped = _groupData(
        entity.upcoming,
        useReturnDate: false,
      );
      final returnsGrouped = _groupData(
        entity.ongoingBookings,
        useReturnDate: true,
      );

      carouselResponse = entity.carouselData;

      emit(
        _Loaded(
          upcomingGrouped: upcomingGrouped,
          returnsGrouped: returnsGrouped,
          nextPageUrl: entity.nextPageUrl,
          carouselData: carouselResponse,
          currentPage: entity.currentPage,
          totalPages: entity.totalPages,
          isPaginating: false,
        ),
      );
    } catch (e) {
      emit(_Error(e.toString()));
    }
  }

  Future<void> _onLoadDashboardNextPageData(
    _LoadDashboardNextPageData event,
    Emitter<DashboardState> emit,
  ) async {
    if (state is! _Loaded) return;
    final s = state as _Loaded;

    if (s.nextPageUrl == null || s.isPaginating) return;

    emit(s.copyWith(isPaginating: true));

    try {
      final activeShop = _userCubit?.state;
      final entity = await _getDashboardDesktopDataUseCase.call(
        page: 1,
        nextPageUrl: s.nextPageUrl,
        activeShop: activeShop,
      );

      final newUpcomingGrouped = _groupData(
        entity.upcoming,
        useReturnDate: false,
      );
      final newReturnsGrouped = _groupData(
        entity.ongoingBookings,
        useReturnDate: true,
      );

      final mergedUpcomingGrouped = {...s.upcomingGrouped};
      final mergedReturnsGrouped = {...s.returnsGrouped};

      newUpcomingGrouped.forEach((key, value) {
        final merged = [...?mergedUpcomingGrouped[key], ...value];
        mergedUpcomingGrouped[key] = <int, BookingEntity>{
          for (final booking in merged)
            if (booking.id != null) booking.id!: booking,
        }.values.toList();
      });

      newReturnsGrouped.forEach((key, value) {
        final merged = [...?mergedReturnsGrouped[key], ...value];
        mergedReturnsGrouped[key] = <int, BookingEntity>{
          for (final booking in merged)
            if (booking.id != null) booking.id!: booking,
        }.values.toList();
      });

      emit(
        s.copyWith(
          upcomingGrouped: mergedUpcomingGrouped,
          returnsGrouped: mergedReturnsGrouped,
          nextPageUrl: entity.nextPageUrl,
          carouselData: entity.carouselData,
          currentPage: entity.currentPage,
          totalPages: entity.totalPages,
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

    final updatedUpcomingGrouped = {
      for (final entry in s.upcomingGrouped.entries)
        entry.key: List<BookingEntity>.from(entry.value),
    };
    final updatedReturnsGrouped = {
      for (final entry in s.returnsGrouped.entries)
        entry.key: List<BookingEntity>.from(entry.value),
    };

    final eventId = event.updateBooking?.id;

    if (event.isDeleted) {
      updatedUpcomingGrouped.forEach((key, bookingList) {
        bookingList.removeWhere((b) => b.id == eventId);
      });
      updatedReturnsGrouped.forEach((key, bookingList) {
        bookingList.removeWhere((b) => b.id == eventId);
      });
    } else {
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

    emit(
      s.copyWith(
        upcomingGrouped: updatedUpcomingGrouped,
        returnsGrouped: updatedReturnsGrouped,
      ),
    );
  }

  void _loadIfNot(_LoadIfNot event, Emitter<DashboardState> emit) {
    if (state is! _Loaded) {
      add(DashboardEvent.loadDashboardData(activeShop: _userCubit?.state));
    }
  }

  void reset() {
    previousCarousel = null;
    carouselResponse = DesktopDashboardCarouselEntity.empty();
  }
}
