import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:bookie_buddy_web/core/app_dependencies.dart';
import 'package:bookie_buddy_web/features/change_password/repository/change_password_repository.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'reset_password_event.dart';
part 'reset_password_state.dart';
part 'reset_password_bloc.freezed.dart';

class ResetPasswordBloc extends Bloc<ResetPasswordEvent, ResetPasswordState> {
  final ChangePasswordRepository _repository =
      getIt<ChangePasswordRepository>();
  ResetPasswordBloc() : super(const _Initial()) {
    on<_ResetPassword>(_onResetPassword);
  }

  Future<void> _onResetPassword(
      _ResetPassword event, Emitter<ResetPasswordState> emit) async {
    emit(const _Submitted());

    try {
      if (event.oldPassword == event.newPassword) {
        throw 'New password cannot be the same as the old password';
      }
      await _repository.changeAccountPassword(
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
