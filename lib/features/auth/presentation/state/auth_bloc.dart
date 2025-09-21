import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../../common/enums/event_status.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/services/shared_preference_service.dart';
import '../../../../core/services/device_info_service.dart';
import '../../application/iauth_service.dart';
import '../../domain/model/auth_login_model.dart';

part 'auth_event.dart';
part 'auth_state.dart';
part 'auth_bloc.freezed.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final IAuthService _authService;
  final SharedPreferenceService _sharedPreferenceService;
  final DeviceInfoService _deviceInfoService;

  AuthBloc(
    this._authService,
    this._sharedPreferenceService,
    this._deviceInfoService,
  ) : super(AuthState.initial()) {
    on<LoginEvent>(_onLogin);
    on<LogoutEvent>(_onLogout);
    on<ResetStateEvent>(_resetState);
  }

  FutureOr<void> _onLogin(
      LoginEvent event, Emitter<AuthState> emit) async {
    emit(state.copyWith(
        status: AuthStatus.logging,
        message: null,
        eventStatus: EventStatus.none));
    try {
      debugPrint('🔍 [AuthBloc] Login with phone: ${event.phone}');
      
      final loginModel = AuthLoginModel(
        phone: event.phone,
        password: event.password,
        deviceToken: 'fcm_device_token_123456', // TODO: Get real FCM token
        platform: 'web', // TODO: Get platform from device info
      );

      final response = await _authService.login(loginModel);
      
      debugPrint('🔍 [AuthBloc] Login response: ${response.status}');

      if (response.status == 'success') {
        // Save tokens
        await _sharedPreferenceService.saveAccessToken(response.data.access);
        await _sharedPreferenceService.saveRefreshToken(response.data.refresh);
        
        emit(state.copyWith(
          status: AuthStatus.loggedIn,
          message: response.message,
          eventStatus: EventStatus.success,
        ));
      } else {
        emit(state.copyWith(
          status: AuthStatus.error,
          message: response.message,
          eventStatus: EventStatus.error,
        ));
      }
    } on Failure catch (e) {
      debugPrint('❌ [AuthBloc] Login failure: ${e.message}');
      final status = e.statusCode == 401 ? AuthStatus.invalidCredentials : AuthStatus.error;
      emit(state.copyWith(
          status: status, 
          message: e.message, 
          eventStatus: EventStatus.error));
    } catch (e) {
      debugPrint('❌ [AuthBloc] Login exception: $e');
      emit(state.copyWith(
          status: AuthStatus.error,
          message: 'An unexpected error occurred',
          eventStatus: EventStatus.error));
    }
  }

  FutureOr<void> _onLogout(LogoutEvent event, Emitter<AuthState> emit) async {
    try {
      emit(AuthState.initial().copyWith(status: AuthStatus.logoutLoading));
      
      // Clear tokens
      await _sharedPreferenceService.clearAuthData();
      
      emit(AuthState.initial().copyWith(
          status: AuthStatus.logout,
          message: 'Logout successful',
          eventStatus: EventStatus.success));
    } catch (e) {
      emit(state.copyWith(
          status: AuthStatus.error,
          message: 'Logout failed',
          eventStatus: EventStatus.error));
    }
  }

  FutureOr<void> _resetState(ResetStateEvent event, Emitter<AuthState> emit) async {
    emit(AuthState.initial());
  }
}
