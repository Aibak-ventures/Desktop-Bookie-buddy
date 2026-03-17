import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'sales_details_drawer_cubit.freezed.dart';

@freezed
class SalesDetailsDrawerState with _$SalesDetailsDrawerState {
  const factory SalesDetailsDrawerState({
    @Default(false) bool isOpen,
    int? selectedSaleId,
  }) = _SalesDetailsDrawerState;
}

class SalesDetailsDrawerCubit extends Cubit<SalesDetailsDrawerState> {
  SalesDetailsDrawerCubit() : super(const SalesDetailsDrawerState());

  void openDrawer(int saleId) {
    emit(state.copyWith(isOpen: true, selectedSaleId: saleId));
  }

  void closeDrawer() {
    emit(state.copyWith(isOpen: false));
  }

  void toggleDrawer(int? saleId) {
    if (state.isOpen && state.selectedSaleId == saleId) {
      closeDrawer();
    } else if (saleId != null) {
      openDrawer(saleId);
    }
  }
}
