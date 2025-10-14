import 'dart:developer';

import 'package:bookie_buddy_web/core/app_dependencies.dart';
import 'package:bookie_buddy_web/core/repositories/auth_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_bloc.freezed.dart';
part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final _repository = getIt.get<AuthRepository>();
  AuthBloc() : super(const _Initial()) {
    on<_LoginRequested>((event, emit) async {
      emit(const AuthState.loading());
      try {
        await _repository.loginUser(
          phone: event.phone,
          password: event.password,
          fcmToken: event.fcmToken,
        );
        emit(const AuthState.authenticated());
      } catch (e, stack) {
        log(e.toString(), stackTrace: stack);
        emit(AuthState.error(e.toString()));
      }
    });
  }
}
