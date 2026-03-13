import 'dart:developer';

import 'package:bookie_buddy_web/features/settings/domain/usecases/update_shop_settings_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'product_reserve_days_state.dart';
part 'product_reserve_days_cubit.freezed.dart';

/// Manages the number of days a product is reserved (e.g., wash/iron window after booking).
class ProductReserveDaysCubit extends Cubit<ProductReserveDaysState> {
  final UpdateShopSettingsUseCase _updateShopSettings;
  ProductReserveDaysCubit({
    required UpdateShopSettingsUseCase updateShopSettings,
    int initialDays = 1,
  }) : _updateShopSettings = updateShopSettings,
       super(ProductReserveDaysState.initial(initialDays));

  void changeDays(int days) {
    if (state.status.isSaving || days == state.selectedDays) return;
    emit(
      state.copyWith(
        selectedDays: days,
        status: ProductReserveDaysStatus.initial,
      ),
    );
  }

  Future<void> save([int? days]) async {
    if (state.status.isSaving) return;
    emit(state.copyWith(status: ProductReserveDaysStatus.saving, error: null));
    try {
      await _updateShopSettings(
        coolingPeriodDuration: days ?? state.selectedDays,
      );
      log('Product reserve days saved: ${state.selectedDays}');
      emit(
        state.copyWith(
          selectedDays: days ?? state.selectedDays,
          status: ProductReserveDaysStatus.success,
          lastSavedAt: DateTime.now(),
        ),
      );
    } catch (e, stack) {
      log('Save product reserve days failed: $e', stackTrace: stack);
      emit(
        state.copyWith(
          status: ProductReserveDaysStatus.failure,
          error: e.toString(),
        ),
      );
    }
  }
}
