import 'dart:async';
import 'dart:developer';

import 'package:bookie_buddy_web/core/extensions/string_extensions.dart';
import 'package:bookie_buddy_web/core/models/pagination_model/pagination_model.dart';
import 'package:bookie_buddy_web/core/repositories/product_repository.dart';
import 'package:bookie_buddy_web/core/repositories/user_repository.dart';
import 'package:bookie_buddy_web/features/transfer_product/models/transfer_product_history_grouped_model/transfer_product_history_grouped_model.dart';
import 'package:bookie_buddy_web/features/transfer_product/models/transfer_product_history_model/transfer_product_history_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'transfer_product_history_bloc.freezed.dart';
part 'transfer_product_history_event.dart';
part 'transfer_product_history_state.dart';

class TransferProductHistoryBloc
    extends Bloc<TransferProductHistoryEvent, TransferProductHistoryState> {
  final ProductRepository _productRepo;
  final UserRepository _userRepo;
  TransferProductHistoryBloc({
    required ProductRepository productRepo,
    required UserRepository userRepo,
  }) : _productRepo = productRepo,
       _userRepo = userRepo,
       super(const TransferProductHistoryState.loading()) {
    // Event handlers
    on<_LoadTransferHistory>(_onLoadTransferHistory);
    on<_LoadNextPageTransferHistory>(_onLoadNextPageTransferHistory);
  }

  FutureOr<void> _onLoadTransferHistory(
    _LoadTransferHistory event,
    Emitter<TransferProductHistoryState> emit,
  ) async {
    emit(const TransferProductHistoryState.loading());
    try {
      final shopId = _userRepo.getShopId;
      if (shopId == null) {
        emit(const TransferProductHistoryState.error('Shop id not found'));
        return;
      }
      final result = await _productRepo.getTransferProductHistory(
        page: 1,
        shopId: shopId,
      );
      emit(
        TransferProductHistoryState.loaded(
          transferProductsHistory: _groupByDate(result.data),
          nextPageUrl: result.nextPageUrl,
          shopId: shopId,
        ),
      );
    } catch (e, stack) {
      log(e.toString(), stackTrace: stack);
      emit(TransferProductHistoryState.error(e.toString()));
    }
  }

  FutureOr<void> _onLoadNextPageTransferHistory(
    _LoadNextPageTransferHistory event,
    Emitter<TransferProductHistoryState> emit,
  ) async {
    if (state is! _Loaded) return;
    final s = state as _Loaded;
    if (s.isPaginating || s.nextPageUrl == null) return;

    emit(s.copyWith(isPaginating: true));
    try {
      final nextPage = PaginationModel.getPageFromUrl(s.nextPageUrl);
      final result = await _productRepo.getTransferProductHistory(
        page: nextPage,
        shopId: s.shopId,
      );

      emit(
        s.copyWith(
          transferProductsHistory: _groupByDate(
            result.data,
            s.transferProductsHistory,
          ),
          nextPageUrl: result.nextPageUrl,
          isPaginating: false,
        ),
      );
    } catch (e, stack) {
      log(e.toString(), stackTrace: stack);
      emit(TransferProductHistoryState.error(e.toString()));
    }
  }

  List<TransferProductHistoryGroupedModel> _groupByDate(
    List<TransferProductHistoryModel> transferHistory, [
    List<TransferProductHistoryGroupedModel>? lastData,
  ]) {
    try {
      if (transferHistory.isEmpty) return lastData ?? [];
      final Map<String, List<TransferProductHistoryModel>> grouped = {};

      // Group by date
      for (final history in transferHistory) {
        final date = history.transferDate.formatToUiDate();
        grouped.putIfAbsent(date, () => []).add(history);
      }

      // Prepare old data copy
      final oldGroups = lastData != null && lastData.isNotEmpty
          ? List<TransferProductHistoryGroupedModel>.from(lastData)
          : <TransferProductHistoryGroupedModel>[];

      // Check if last date in old matches first date in new
      final lastGroup = oldGroups.isNotEmpty ? oldGroups.removeLast() : null;
      final newFirstDate = grouped.keys.firstOrNull;

      if (lastGroup != null && lastGroup.date == newFirstDate) {
        grouped[newFirstDate]?.insertAll(
          0,
          lastGroup.transferProductHistoryList,
        );
      } else if (lastGroup != null) {
        oldGroups.add(lastGroup);
      }

      // Convert map to list
      final newGroups = grouped.entries
          .map(
            (e) => TransferProductHistoryGroupedModel(
              date: e.key,
              transferProductHistoryList: e.value,
            ),
          )
          .toList();

      // newGroups.sort((a, b) => b.date.compareTo(a.date)); // descending

      return [...oldGroups, ...newGroups];
    } catch (e, stack) {
      log(e.toString(), stackTrace: stack);
      rethrow;
    }
  }
}
