import 'dart:developer';

import 'package:bookie_buddy_web/core/enums/enums.dart';
import 'package:bookie_buddy_web/core/models/user_model/user_model.dart';
import 'package:bookie_buddy_web/core/repositories/shop_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'manage_password_settings_event.dart';
part 'manage_password_settings_state.dart';
part 'manage_password_settings_bloc.freezed.dart';

class ManagePasswordSettingsBloc
    extends Bloc<ManagePasswordSettingsEvent, ManagePasswordSettingsState> {
  final ShopRepository _repository;
  ManagePasswordSettingsBloc(this._repository)
    : super(const ManagePasswordSettingsState.loaded()) {
    on<_Load>(_onLoad);
    on<_UpdateRole>(_onUpdateRole);
    on<_Save>(_onSave);
    on<_ResetChanges>(_onResetChanges);
  }

  void _onLoad(_Load event, Emitter<ManagePasswordSettingsState> emit) {
    emit(
      state.copyWith(
        status: ManagePwdSettingsStatus.ready,
        settings: List.of(event.settings),
        original: List.of(event.settings),
        error: null,
        message: null,
      ),
    );
  }

  void _onUpdateRole(
    _UpdateRole event,
    Emitter<ManagePasswordSettingsState> emit,
  ) {
    if (state.status == ManagePwdSettingsStatus.saving)
      return; // ignore while saving
    final newRole = UserPasswordSettingRole.fromString(event.newRole);
    final updated = state.settings.map((s) {
      if (s == event.target) {
        return s.copyWith(role: newRole);
      }
      return s;
    }).toList();
    emit(state.copyWith(settings: updated));
  }

  Future<void> _onSave(
    _Save event,
    Emitter<ManagePasswordSettingsState> emit,
  ) async {
    if (!state.hasChanges) {
      emit(
        state.copyWith(
          message: 'No changes to save',
          status: ManagePwdSettingsStatus.success,
        ),
      );
      emit(
        state.copyWith(status: ManagePwdSettingsStatus.ready, message: null),
      );
      return;
    }

    emit(
      state.copyWith(
        status: ManagePwdSettingsStatus.saving,
        error: null,
        message: null,
      ),
    );
    try {
      await _repository.updateShopPrivacySettings(state.settings);
      emit(
        state.copyWith(
          status: ManagePwdSettingsStatus.success,
          original: List.of(state.settings),
          message: 'Settings updated successfully',
          lastSavedAt: DateTime.now(),
        ),
      );
      // Transition back to ready (UI can listen for success first)
      emit(state.copyWith(status: ManagePwdSettingsStatus.ready));
    } catch (e, stack) {
      log('Save password settings failed', error: e, stackTrace: stack);
      emit(
        state.copyWith(
          status: ManagePwdSettingsStatus.failure,
          error: e.toString(),
        ),
      );
      // After failure keep user edits, go back to ready so user can retry
      emit(state.copyWith(status: ManagePwdSettingsStatus.ready));
    }
  }

  void _onResetChanges(
    _ResetChanges event,
    Emitter<ManagePasswordSettingsState> emit,
  ) {
    emit(state.copyWith(settings: List.of(state.original)));
  }
}
