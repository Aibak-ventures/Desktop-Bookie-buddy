import 'dart:developer';

import 'package:bookie_buddy_web/core/repositories/shop_repository.dart';
import 'package:bookie_buddy_web/features/all_shop_summary/models/all_shop_summary_model/all_shop_summary_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'all_shop_summary_state.dart';
part 'all_shop_summary_cubit.freezed.dart';

class AllShopSummaryCubit extends Cubit<AllShopSummaryState> {
  final ShopRepository _repository;
  AllShopSummaryCubit(this._repository)
    : super(const AllShopSummaryState.loading());

  /// Get the current summary date
  DateTime get selectedDate => _selectedDate;

  DateTime _selectedDate = DateTime.now();

  /// Update the current summary date
  void updateSelectedDate(DateTime newDate) {
    _selectedDate = newDate;
  }

  Future<void> fetchAllShopSummary({
    required int year,
    required int month,
    int? shopId,
  }) async {
    if (state is! _Loading) emit(const AllShopSummaryState.loading());

    try {
      final summary = await _repository.getAllShopSummary(
        year: year,
        month: month,
        shopId: shopId,
      );
      emit(AllShopSummaryState.loaded(shopSummary: summary));
    } catch (e, stack) {
      log('Fetch All Shop Summary Error: $e', stackTrace: stack);
      emit(AllShopSummaryState.error(e.toString()));
    }
  }

  AllShopSummaryModel? get getAllShopSummary {
    if (state is _Loaded) {
      return (state as _Loaded).shopSummary;
    }
    return null;
  }
}
