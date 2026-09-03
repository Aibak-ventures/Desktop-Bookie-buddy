import 'dart:developer';

import 'package:bookie_buddy_web/features/sales/domain/usecases/create_sale_usecase.dart';
import 'package:bookie_buddy_web/features/sales/domain/usecases/update_sale_usecase.dart';
import 'package:bookie_buddy_web/features/sales/domain/entities/sales_request_entity/sales_request_entity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'save_sales_cubit.freezed.dart';

@freezed
abstract class SaveSalesState with _$SaveSalesState {
  const factory SaveSalesState.initial() = _Initial;
  const factory SaveSalesState.saving() = _Saving;
  const factory SaveSalesState.success([String? message]) = _Success;
  const factory SaveSalesState.failure(String message) = _Failure;
}

class SaveSalesCubit extends Cubit<SaveSalesState> {
  final CreateSaleUseCase _createSaleUseCase;
  final UpdateSaleUseCase _updateSaleUseCase;

  SaveSalesCubit({
    required CreateSaleUseCase createSaleUseCase,
    required UpdateSaleUseCase updateSaleUseCase,
  }) : _createSaleUseCase = createSaleUseCase,
       _updateSaleUseCase = updateSaleUseCase,
       super(const SaveSalesState.initial());

  void saveSales({
    required SalesRequestEntity salesRequest,
    bool isEditMode = false,
  }) async {
    final products = salesRequest.products;

    if (products == null || products.isEmpty) {
      emit(const SaveSalesState.failure('Please add at least one product'));
      return;
    }

    for (final product in products) {
      if (product.amount < 0) {
        emit(const SaveSalesState.failure('Product price cannot be negative'));
        return;
      }

      if (product.quantity <= 0) {
        emit(const SaveSalesState.failure('Product quantity cannot be zero'));
        return;
      }
    }

    final total = products.fold<int>(
      0,
      (sum, p) => sum + (p.amount * p.quantity),
    );

    if (total <= 0) {
      emit(
        const SaveSalesState.failure('Total amount must be greater than zero'),
      );
      return;
    }

    emit(const SaveSalesState.saving());
    try {
      isEditMode
          ? await _updateSaleUseCase(salesRequest)
          : await _createSaleUseCase(salesRequest);

      emit(
        SaveSalesState.success(
          'Sales ${isEditMode ? 'updated' : 'created'} successfully',
        ),
      );
    } catch (e, stack) {
      log('Error occurred while saving sales: $e', stackTrace: stack);
      emit(SaveSalesState.failure(_formatSalesError(e.toString())));
    }
  }

  String _formatSalesError(String rawError) {
    final insufficientStockRegex = RegExp(
      r'Insufficient stock for (.+?)\s*\(.*?\)\.',
      caseSensitive: false,
    );
    final match = insufficientStockRegex.firstMatch(rawError);
    if (match != null) {
      final productName = match.group(1)?.trim() ?? 'a product';
      return 'Not enough stock for "$productName". Please remove it from the sale or reduce the quantity.';
    }

    return rawError;
  }
}
