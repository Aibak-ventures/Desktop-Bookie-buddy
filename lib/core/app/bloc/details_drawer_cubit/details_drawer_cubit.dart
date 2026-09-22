import 'package:bookie_buddy_web/core/app/bloc/details_drawer_cubit/details_drawer_type_enum.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

export 'package:bookie_buddy_web/core/app/bloc/details_drawer_cubit/details_drawer_type_enum.dart';

part 'details_drawer_cubit.freezed.dart';

@freezed
abstract class DetailsDrawerState with _$DetailsDrawerState {
  /// [type] and [selectedId] are left untouched by [DetailsDrawerCubit.closeDrawer]
  /// — only [isOpen] flips to false — so they may still name the last drawer
  /// that was open even once it's closed. Every `XDetailsDrawer` already
  /// gates on [isOpenFor] before reading them, so this is harmless today, but
  /// read them directly only inside a branch already gated that way; on their
  /// own they don't tell you whether a drawer is actually showing.
  const factory DetailsDrawerState({
    @Default(false) bool isOpen,
    DetailsDrawerType? type,
    int? selectedId,
  }) = _DetailsDrawerState;
}

extension DetailsDrawerStateX on DetailsDrawerState {
  /// Whether this drawer type is the one currently open. Every `XDetailsDrawer`
  /// widget should gate its `DetailsDrawerShell.isOpen` and content visibility
  /// on this — never on `isOpen` alone — so it never renders for another
  /// drawer's state.
  bool isOpenFor(DetailsDrawerType type) => isOpen && this.type == type;
}

/// A `BlocListener<DetailsDrawerCubit, DetailsDrawerState>.listenWhen` for a
/// specific drawer type: true exactly when that drawer just opened, or
/// switched to a different id while already open. Every `XDetailsDrawer`
/// widget must be permanently mounted (not conditionally built once its type
/// becomes active) for this to fire on a drawer's very first open — see
/// [GlobalDetailsDrawer]'s doc comment for why.
bool Function(DetailsDrawerState, DetailsDrawerState) detailsDrawerOpenedFor(
  DetailsDrawerType type,
) {
  return (previous, current) =>
      current.isOpenFor(type) &&
      current.selectedId != null &&
      (!previous.isOpenFor(type) || previous.selectedId != current.selectedId);
}

/// Single app-wide cubit backing every feature's slide-in details drawer
/// (booking, sales, ...). Only one drawer can be open at a time, so one
/// cubit/one [DetailsDrawerState] is enough — see [DetailsDrawerType] for how
/// to plug in a new drawer.
class DetailsDrawerCubit extends Cubit<DetailsDrawerState> {
  DetailsDrawerCubit() : super(const DetailsDrawerState());

  void open(DetailsDrawerType type, int id) {
    emit(DetailsDrawerState(isOpen: true, type: type, selectedId: id));
  }

  void openBooking(int bookingId) => open(DetailsDrawerType.booking, bookingId);

  void openSales(int saleId) => open(DetailsDrawerType.sales, saleId);

  void closeDrawer() {
    emit(state.copyWith(isOpen: false));
  }

  void toggle(DetailsDrawerType type, int? id) {
    if (state.isOpen && state.type == type && state.selectedId == id) {
      closeDrawer();
    } else if (id != null) {
      open(type, id);
    }
  }
}
