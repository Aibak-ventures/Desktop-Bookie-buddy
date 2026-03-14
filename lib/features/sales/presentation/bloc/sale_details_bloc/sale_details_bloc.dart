import 'dart:async';
import 'dart:developer';

import 'package:bookie_buddy_web/features/sales/domain/models/sale_details_model/sale_details_model.dart';
import 'package:bookie_buddy_web/features/sales/domain/usecases/delete_sale_usecase.dart';
import 'package:bookie_buddy_web/features/sales/domain/usecases/get_sale_details_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'sale_details_event.dart';
part 'sale_details_state.dart';
part 'sale_details_bloc.freezed.dart';

class SaleDetailsBloc extends Bloc<SaleDetailsEvent, SaleDetailsState> {
  final GetSaleDetailsUseCase _getSaleDetailsUseCase;
  final DeleteSaleUseCase _deleteSaleUseCase;

  SaleDetailsBloc({
    required GetSaleDetailsUseCase getSaleDetailsUseCase,
    required DeleteSaleUseCase deleteSaleUseCase,
  })  : _getSaleDetailsUseCase = getSaleDetailsUseCase,
        _deleteSaleUseCase = deleteSaleUseCase,
        super(const SaleDetailsState.loading()) {
    on<_GetSaleDetails>(_getSaleDetails);
    on<_DeleteSale>(_deleteSale);
  }

  FutureOr<void> _getSaleDetails(
    _GetSaleDetails event,
    Emitter<SaleDetailsState> emit,
  ) async {
    if (state is! _Loading) emit(const SaleDetailsState.loading());

    try {
      final saleDetails = await _getSaleDetailsUseCase(event.saleId);
      emit(SaleDetailsState.loaded(saleDetails: saleDetails));
    } catch (e, stack) {
      log('Error fetching sale details: $e', stackTrace: stack);
      emit(SaleDetailsState.error(e.toString()));
    }
  }

  FutureOr<void> _deleteSale(
    _DeleteSale event,
    Emitter<SaleDetailsState> emit,
  ) async {
    try {
      final sale = state as _Loaded;
      await _deleteSaleUseCase(event.saleId);
      emit(sale.copyWith(isDeleted: true));
    } catch (e, stack) {
      log('Error deleting sale: $e', stackTrace: stack);
      emit(SaleDetailsState.error(e.toString()));
    }
  }
}
