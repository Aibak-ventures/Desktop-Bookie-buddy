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
    // ✅ VALIDATION FIRST
    final products = salesRequest.products;

    // In edit mode, if products is null, it means products haven't changed
    // So we skip the product validation
    if (!isEditMode || products != null) {
      if (products == null || products.isEmpty) {
        emit(const SaveSalesState.failure('Please add at least one product'));
        return;
      }

      for (final product in products) {
        if (product.amount <= 0) {
          emit(const SaveSalesState.failure(
            'Product price cannot be zero',
          ));
          return;
        }

        if (product.quantity <= 0) {
          emit(const SaveSalesState.failure(
            'Product quantity cannot be zero',
          ));
          return;
        }
      }

      final total = products.fold<int>(
        0,
        (sum, p) => sum + (p.amount * p.quantity),
      );

      if (total <= 0) {
        emit(const SaveSalesState.failure(
          'Total amount must be greater than zero',
        ));
        return;
      }
    }

    // ✅ SAVE
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

