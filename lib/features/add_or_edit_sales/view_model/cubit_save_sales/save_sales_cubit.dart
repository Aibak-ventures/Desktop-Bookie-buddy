import 'dart:developer';

import 'package:bookie_buddy_web/core/repositories/sales_repository.dart';
import 'package:bookie_buddy_web/features/add_or_edit_sales/models/sales_request_model/sales_request_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'save_sales_state.dart';
part 'save_sales_cubit.freezed.dart';

class SaveSalesCubit extends Cubit<SaveSalesState> {
  final SalesRepository _repository;

  SaveSalesCubit({required SalesRepository repository})
    : _repository = repository,
      super(const SaveSalesState.initial());

  void saveSales({
    required SalesRequestModel salesRequest,
    bool isEditMode = false,
  }) async {
    emit(const SaveSalesState.saving());
    try {
      isEditMode
          ? await _repository.updateSale(salesRequest)
          : await _repository.createSale(salesRequest);

      emit(
        SaveSalesState.success(
          'Sales ${isEditMode ? 'updated' : 'created'} successfully',
        ),
      );
    } catch (e, stack) {
      log('Error occurred while saving sales: $e', stackTrace: stack);
      emit(SaveSalesState.failure(e.toString()));
    }
  }
}
