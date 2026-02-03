import 'dart:async';
import 'dart:developer';

import 'package:bookie_buddy_web/core/models/sale_details_model/sale_details_model.dart';
import 'package:bookie_buddy_web/core/repositories/sales_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'sales_details_event.dart';
part 'sales_details_state.dart';
part 'sales_details_bloc.freezed.dart';

class SalesDetailsBloc extends Bloc<SalesDetailsEvent, SalesDetailsState> {
  final SalesRepository _repository;

  SalesDetailsBloc({required SalesRepository repository})
      : _repository = repository,
        super(const SalesDetailsState.initial()) {
    on<_FetchSaleDetails>(_onFetchSaleDetails);
    on<_DeleteSale>(_onDeleteSale);
  }

  Future<void> _onFetchSaleDetails(
    _FetchSaleDetails event,
    Emitter<SalesDetailsState> emit,
  ) async {
    emit(const SalesDetailsState.loading());
    try {
      final sale = await _repository.getSaleDetails(event.saleId);
      emit(SalesDetailsState.loaded(sale: sale));
    } catch (e, stack) {
      log(e.toString(), stackTrace: stack);
      emit(SalesDetailsState.error(e.toString()));
    }
  }

  Future<void> _onDeleteSale(
    _DeleteSale event,
    Emitter<SalesDetailsState> emit,
  ) async {
    try {
      await _repository.deleteSale(event.saleId);
      emit(const SalesDetailsState.success(
        message: 'Sale deleted successfully',
        needRefresh: true,
        didPop: true,
      ));
    } catch (e, stack) {
      log(e.toString(), stackTrace: stack);
      emit(SalesDetailsState.error(e.toString()));
    }
  }
}
