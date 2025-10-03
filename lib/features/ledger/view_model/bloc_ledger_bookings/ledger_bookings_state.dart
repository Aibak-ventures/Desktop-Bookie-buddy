part of 'ledger_bookings_bloc.dart';

@freezed
class LedgerBookingsState with _$LedgerBookingsState {
  const factory LedgerBookingsState.loading() = _Loading;

  const factory LedgerBookingsState.loaded({
    required List<LedgerBookingDailyModel> ledgerBookings,
    required String? nextPageUrl,
    @Default(false) bool isPaginating,
    int? clientId,
    @Default(false) bool isFirstFetch,
  }) = _Loaded;

  const factory LedgerBookingsState.error(String error) = _Error;
}

extension LedgerBookingsStateExtension on LedgerBookingsState {
  bool get isLoading => this is _Loading;
  bool get isLoaded => this is _Loaded;
  bool get isError => this is _Error;
}
