import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bookie_buddy_web/features/profile/models/shop_activity_model/shop_activity_model.dart';
import 'package:bookie_buddy_web/features/profile/repository/shop_activity_repository.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'shop_activity_log_state.dart';
part 'shop_activity_log_cubit.freezed.dart';

class ShopActivityLogCubit extends Cubit<ShopActivityLogState> {
  final ShopActivityRepository _repository;

  ShopActivityLogCubit(this._repository)
      : super(const ShopActivityLogState.initial());

  Future<void> loadShopActivities({bool refresh = false}) async {
    try {
      if (refresh) {
        emit(const ShopActivityLogState.loading());
      }

      log('Loading shop activities...');
      final result = await _repository.loadShopActivities();

      emit(ShopActivityLogState.loaded(
        activities: result.activities,
        nextPageUrl: result.nextPageUrl,
        isPaginating: false,
      ));
    } catch (e, stack) {
      log('Error in loadShopActivities: $e', stackTrace: stack);
      emit(ShopActivityLogState.error(e.toString()));
    }
  }

  Future<void> loadNextPage() async {
    final currentState = state;
    
    // Only load if we're in loaded state and have a next page URL and not already paginating
    if (currentState is! _Loaded) return;
    final loadedState = currentState;
    
    if (loadedState.nextPageUrl == null || loadedState.isPaginating) return;

    try {
      // Set paginating flag
      emit(loadedState.copyWith(isPaginating: true));

      log('Loading next page: ${loadedState.nextPageUrl}');
      final result = await _repository.loadNextPage(loadedState.nextPageUrl!);

      // Append new activities to existing list
      final updatedActivities = [
        ...loadedState.activities,
        ...result.activities,
      ];

      emit(ShopActivityLogState.loaded(
        activities: updatedActivities,
        nextPageUrl: result.nextPageUrl,
        isPaginating: false,
      ));
    } catch (e, stack) {
      log('Error in loadNextPage: $e', stackTrace: stack);
      // Keep current state but turn off paginating flag
      emit(loadedState.copyWith(isPaginating: false));
    }
  }

  void reset() {
    emit(const ShopActivityLogState.initial());
  }
}
