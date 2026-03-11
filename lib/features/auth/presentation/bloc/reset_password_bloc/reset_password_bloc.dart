import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:bookie_buddy_web/features/auth/domain/usecases/change_account_password_usecase.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'reset_password_event.dart';
part 'reset_password_state.dart';
part 'reset_password_bloc.freezed.dart';

class ResetPasswordBloc extends Bloc<ResetPasswordEvent, ResetPasswordState> {
  final ChangeAccountPasswordUseCase _changePassword;
  ResetPasswordBloc({required ChangeAccountPasswordUseCase changePassword})
      : _changePassword = changePassword,
        super(const _Initial()) {
    on<_ResetPassword>(_onResetPassword);
  }

  Future<void> _onResetPassword(
      _ResetPassword event, Emitter<ResetPasswordState> emit) async {
    emit(const _Submitted());

    try {
      if (event.oldPassword == event.newPassword) {
        throw 'New password cannot be the same as the old password';
      }
      await _changePassword.call(
        oldPassword: event.oldPassword,
        newPassword: event.newPassword,
        logoutFromAllDevices: event.logoutFromAllDevices,
      );

      emit(const _Success());
    } catch (e, stack) {
      log(e.toString(), stackTrace: stack);
      emit(_Error(e.toString()));
    }
  }
}
