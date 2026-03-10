import 'dart:developer';

import 'package:bookie_buddy_web/core/constants/enums/shop_based_enums.dart';
import 'package:bookie_buddy_web/core/repositories/shop_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'add_button_default_action_state.dart';
part 'add_button_default_action_cubit.freezed.dart';

class AddButtonDefaultActionCubit extends Cubit<AddButtonDefaultActionState> {
  final ShopRepository _repository;
  AddButtonDefaultActionCubit({
    required AddButtonDefaultAction initialAction,
    required ShopRepository repository,
  })  : _repository = repository,
        super(
            AddButtonDefaultActionState.initial(initialAction: initialAction));

  void saveDefaultAction(AddButtonDefaultAction action) async {
    try {
      emit(
        state.copyWith(
          status: AddButtonDefaultActionStatus.saving,
          error: null,
        ),
      );
      await _repository.updateShopSettings(
          // addButtonDefaultAction: action as AddButtonDefaultAction?
          );

      emit(
        state.copyWith(
          status: AddButtonDefaultActionStatus.success,
          action: action,
        ),
      );
    } catch (e, stackTrace) {
      log('Error saving default action: $e', stackTrace: stackTrace);
      emit(
        state.copyWith(
          status: AddButtonDefaultActionStatus.failure,
          error: e.toString(),
        ),
      );
    }
  }
}
