import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:bookie_buddy_web/core/app_dependencies.dart';
import 'package:bookie_buddy_web/features/auth/repository/auth_repository.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_event.dart';
part 'auth_state.dart';
part 'auth_bloc.freezed.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final _repository = getIt.get<AuthRepository>();
  AuthBloc() : super(const _Initial()) {
    on<_LoginRequested>((event, emit) async {
      print('🔥 AuthBloc: LoginRequested event received');
      emit(const AuthState.loading());
      try {
        print('🔥 AuthBloc: Calling repository.loginUser with phone: ${event.phone}');
        await _repository.loginUser(event.phone, event.password);

        emit(const AuthState.authenticated());
      } catch (e, stack) {
        log(e.toString(), stackTrace: stack);
        emit(AuthState.error(e.toString()));
      }
    });
  }
}
