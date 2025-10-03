part of 'ledger_bookings_bloc.dart';

@freezed
class LedgerBookingsEvent with _$LedgerBookingsEvent {
  const factory LedgerBookingsEvent.loadBookings({int? clientId}) =
      _LoadBookings;
  const factory LedgerBookingsEvent.loadNextPageBookings() =
      _LoadNextPageBookings;
}
