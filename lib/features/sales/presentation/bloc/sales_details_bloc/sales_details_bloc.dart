import 'dart:async';
import 'dart:developer';

import 'package:bookie_buddy_shared/core/features/sales/domain/entities/sale_details_entity/sale_details_entity.dart';
import 'package:bookie_buddy_web/features/sales/domain/usecases/delete_sale_usecase.dart';
import 'package:bookie_buddy_web/features/sales/domain/usecases/get_sale_details_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'sales_details_bloc.freezed.dart';

@freezed
abstract class SalesDetailsEvent with _$SalesDetailsEvent {
  const factory SalesDetailsEvent.fetchSaleDetails(int saleId) =
      _FetchSaleDetails;

  const factory SalesDetailsEvent.deleteSale(int saleId) = _DeleteSale;
}

@freezed
abstract class SalesDetailsState with _$SalesDetailsState {
  const factory SalesDetailsState.initial() = _Initial;
  const factory SalesDetailsState.loading() = _Loading;
  const factory SalesDetailsState.loaded({required SaleDetailsEntity sale}) =
      _Loaded;
  const factory SalesDetailsState.error(String message) = _Error;
  const factory SalesDetailsState.success({
    required String message,
    @Default(false) bool didPop,
    @Default(false) bool needRefresh,
  }) = _Success;
}

class SalesDetailsBloc extends Bloc<SalesDetailsEvent, SalesDetailsState> {
  final GetSaleDetailsUseCase _getSaleDetailsUseCase;
  final DeleteSaleUseCase _deleteSaleUseCase;

  SalesDetailsBloc({
    required GetSaleDetailsUseCase getSaleDetailsUseCase,
    required DeleteSaleUseCase deleteSaleUseCase,
  }) : _getSaleDetailsUseCase = getSaleDetailsUseCase,
       _deleteSaleUseCase = deleteSaleUseCase,
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
      final sale = await _getSaleDetailsUseCase(event.saleId);
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
      await _deleteSaleUseCase(event.saleId);
      emit(
        const SalesDetailsState.success(
          message: 'Sale deleted successfully',
          needRefresh: true,
          didPop: true,
        ),
      );
    } catch (e, stack) {
      log(e.toString(), stackTrace: stack);
      emit(SalesDetailsState.error(e.toString()));
    }
  }
}
