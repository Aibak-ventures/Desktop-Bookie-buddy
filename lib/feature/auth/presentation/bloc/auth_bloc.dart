import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/models/auth_models.dart';
import '../../../../core/models/user_model.dart';
import '../../../../core/usecases/usecase.dart';
import '../../domain/usecases/auth_usecases.dart';

// Events
abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

class LoginRequested extends AuthEvent {
  final String phone;
  final String password;

  const LoginRequested({
    required this.phone,
    required this.password,
  });

  @override
  List<Object?> get props => [phone, password];
}

class RefreshTokenRequested extends AuthEvent {
  final String refreshToken;

  const RefreshTokenRequested({required this.refreshToken});

  @override
  List<Object?> get props => [refreshToken];
}

class GetUserProfileRequested extends AuthEvent {
  const GetUserProfileRequested();
}

class LogoutRequested extends AuthEvent {
  const LogoutRequested();
}

class CheckAuthStatusRequested extends AuthEvent {
  const CheckAuthStatusRequested();
}

// States
abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

class AuthInitial extends AuthState {
  const AuthInitial();
}

class AuthLoading extends AuthState {
  const AuthLoading();
}

class AuthAuthenticated extends AuthState {
  final UserModel user;
  final String accessToken;
  final String refreshToken;

  const AuthAuthenticated({
    required this.user,
    required this.accessToken,
    required this.refreshToken,
  });

  @override
  List<Object?> get props => [user, accessToken, refreshToken];
}

class AuthUnauthenticated extends AuthState {
  const AuthUnauthenticated();
}

class AuthError extends AuthState {
  final String message;

  const AuthError({required this.message});

  @override
  List<Object?> get props => [message];
}

// BLoC
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUseCase _loginUseCase;
  final RefreshTokenUseCase _refreshTokenUseCase;
  final GetUserProfileUseCase _getUserProfileUseCase;
  final LogoutUseCase _logoutUseCase;

  AuthBloc({
    required LoginUseCase loginUseCase,
    required RefreshTokenUseCase refreshTokenUseCase,
    required GetUserProfileUseCase getUserProfileUseCase,
    required LogoutUseCase logoutUseCase,
  })  : _loginUseCase = loginUseCase,
        _refreshTokenUseCase = refreshTokenUseCase,
        _getUserProfileUseCase = getUserProfileUseCase,
        _logoutUseCase = logoutUseCase,
        super(const AuthInitial()) {
    
    on<LoginRequested>(_onLoginRequested);
    on<RefreshTokenRequested>(_onRefreshTokenRequested);
    on<GetUserProfileRequested>(_onGetUserProfileRequested);
    on<LogoutRequested>(_onLogoutRequested);
    on<CheckAuthStatusRequested>(_onCheckAuthStatusRequested);
  }

  Future<void> _onLoginRequested(
    LoginRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());
    
    try {
      log('🔐 AuthBloc: Login attempt for phone: ${event.phone}');
      
      final loginRequest = LoginRequest(
        phone: event.phone,
        password: event.password,
      );
      
      final result = await _loginUseCase.call(loginRequest);
      
      if (result.isSuccess) {
        final loginResponse = result.successData;
        log('✅ AuthBloc: Login successful');
        
        // Get user profile after successful login
        final profileResult = await _getUserProfileUseCase.call(const NoParams());
        
        if (profileResult.isSuccess) {
          final user = profileResult.successData;
          emit(AuthAuthenticated(
            user: user,
            accessToken: loginResponse.data.access,
            refreshToken: loginResponse.data.refresh,
          ));
        } else {
          log('❌ AuthBloc: Failed to get user profile: ${profileResult.failureData.message}');
          emit(AuthError(message: profileResult.failureData.message));
        }
      } else {
        log('❌ AuthBloc: Login failed: ${result.failureData.message}');
        emit(AuthError(message: result.failureData.message));
      }
    } catch (e, stack) {
      log('❌ AuthBloc: Unexpected error during login: $e', stackTrace: stack);
      emit(const AuthError(message: 'An unexpected error occurred. Please try again.'));
    }
  }

  Future<void> _onRefreshTokenRequested(
    RefreshTokenRequested event,
    Emitter<AuthState> emit,
  ) async {
    try {
      log('🔄 AuthBloc: Refreshing token');
      
      final refreshRequest = RefreshTokenRequest(refresh: event.refreshToken);
      final result = await _refreshTokenUseCase.call(refreshRequest);
      
      if (result.isSuccess) {
        final refreshResponse = result.successData;
        log('✅ AuthBloc: Token refresh successful');
        
        // Update current state with new tokens if user is authenticated
        if (state is AuthAuthenticated) {
          final currentState = state as AuthAuthenticated;
          emit(AuthAuthenticated(
            user: currentState.user,
            accessToken: refreshResponse.access,
            refreshToken: currentState.refreshToken, // Keep the existing refresh token
          ));
        }
      } else {
        log('❌ AuthBloc: Token refresh failed: ${result.failureData.message}');
        emit(const AuthUnauthenticated());
      }
    } catch (e, stack) {
      log('❌ AuthBloc: Unexpected error during token refresh: $e', stackTrace: stack);
      emit(const AuthUnauthenticated());
    }
  }

  Future<void> _onGetUserProfileRequested(
    GetUserProfileRequested event,
    Emitter<AuthState> emit,
  ) async {
    try {
      log('👤 AuthBloc: Getting user profile');
      
      final result = await _getUserProfileUseCase.call(const NoParams());
      
      if (result.isSuccess) {
        final user = result.successData;
        log('✅ AuthBloc: User profile retrieved successfully');
        
        // Update current state with new user data if authenticated
        if (state is AuthAuthenticated) {
          final currentState = state as AuthAuthenticated;
          emit(AuthAuthenticated(
            user: user,
            accessToken: currentState.accessToken,
            refreshToken: currentState.refreshToken,
          ));
        }
      } else {
        log('❌ AuthBloc: Failed to get user profile: ${result.failureData.message}');
        emit(AuthError(message: result.failureData.message));
      }
    } catch (e, stack) {
      log('❌ AuthBloc: Unexpected error getting user profile: $e', stackTrace: stack);
      emit(const AuthError(message: 'Failed to get user profile. Please try again.'));
    }
  }

  Future<void> _onLogoutRequested(
    LogoutRequested event,
    Emitter<AuthState> emit,
  ) async {
    try {
      log('🚪 AuthBloc: Logout requested');
      
      final result = await _logoutUseCase.call(const NoParams());
      
      if (result.isSuccess) {
        log('✅ AuthBloc: Logout successful');
        emit(const AuthUnauthenticated());
      } else {
        log('❌ AuthBloc: Logout failed: ${result.failureData.message}');
        // Still logout the user from app side even if server call fails
        emit(const AuthUnauthenticated());
      }
    } catch (e, stack) {
      log('❌ AuthBloc: Unexpected error during logout: $e', stackTrace: stack);
      // Still logout the user from app side
      emit(const AuthUnauthenticated());
    }
  }

  Future<void> _onCheckAuthStatusRequested(
    CheckAuthStatusRequested event,
    Emitter<AuthState> emit,
  ) async {
    try {
      log('🔍 AuthBloc: Checking auth status');
      
      // Try to get user profile to check if user is still authenticated
      final result = await _getUserProfileUseCase.call(const NoParams());
      
      if (result.isSuccess) {
        final user = result.successData;
        log('✅ AuthBloc: User is authenticated');
        
        // We would need to get stored tokens here
        // For now, we'll emit unauthenticated and require login
        emit(const AuthUnauthenticated());
      } else {
        log('❌ AuthBloc: User is not authenticated');
        emit(const AuthUnauthenticated());
      }
    } catch (e, stack) {
      log('❌ AuthBloc: Error checking auth status: $e', stackTrace: stack);
      emit(const AuthUnauthenticated());
    }
  }
}
