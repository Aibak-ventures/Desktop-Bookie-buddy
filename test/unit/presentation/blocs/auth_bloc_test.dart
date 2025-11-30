import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:bookie_buddy_web/src/core/errors/failures.dart';
import 'package:bookie_buddy_web/src/domain/entities/auth/user_entity.dart';
import 'package:bookie_buddy_web/src/domain/usecases/auth/login_usecase.dart';
import 'package:bookie_buddy_web/src/domain/usecases/auth/logout_usecase.dart';
import 'package:bookie_buddy_web/src/domain/usecases/auth/get_current_user_usecase.dart';
import 'package:bookie_buddy_web/src/presentation/blocs/auth/auth_bloc.dart';
import 'package:bookie_buddy_web/src/presentation/blocs/auth/auth_event.dart';
import 'package:bookie_buddy_web/src/presentation/blocs/auth/auth_state.dart';

// Mocks
class MockLoginUseCase extends Mock implements LoginUseCase {}
class MockLogoutUseCase extends Mock implements LogoutUseCase {}
class MockGetCurrentUserUseCase extends Mock implements GetCurrentUserUseCase {}

// Fake for params
class FakeLoginParams extends Fake implements LoginParams {}

void main() {
  late AuthBloc authBloc;
  late MockLoginUseCase mockLoginUseCase;
  late MockLogoutUseCase mockLogoutUseCase;
  late MockGetCurrentUserUseCase mockGetCurrentUserUseCase;

  setUpAll(() {
    registerFallbackValue(FakeLoginParams());
  });

  setUp(() {
    mockLoginUseCase = MockLoginUseCase();
    mockLogoutUseCase = MockLogoutUseCase();
    mockGetCurrentUserUseCase = MockGetCurrentUserUseCase();
    authBloc = AuthBloc(
      loginUseCase: mockLoginUseCase,
      logoutUseCase: mockLogoutUseCase,
      getCurrentUserUseCase: mockGetCurrentUserUseCase,
    );
  });

  tearDown(() {
    authBloc.close();
  });

  group('AuthBloc', () {
    final testUser = UserEntity(
      id: 1,
      phone: '1234567890',
      name: 'Test User',
      email: 'test@example.com',
      createdAt: DateTime(2025, 1, 1),
    );

    test('initial state should be AuthInitial', () {
      expect(authBloc.state, equals(const AuthInitial()));
    });

    group('LoginRequested', () {
      blocTest<AuthBloc, AuthState>(
        'should emit [AuthLoading, AuthAuthenticated] when login is successful',
        build: () {
          when(() => mockLoginUseCase(any()))
              .thenAnswer((_) async => Right(testUser));
          return authBloc;
        },
        act: (bloc) => bloc.add(const LoginRequested(
          phone: '1234567890',
          password: 'password123',
        )),
        expect: () => [
          const AuthLoading(),
          AuthAuthenticated(user: testUser),
        ],
        verify: (_) {
          verify(() => mockLoginUseCase(any())).called(1);
        },
      );

      blocTest<AuthBloc, AuthState>(
        'should emit [AuthLoading, AuthError] when login fails',
        build: () {
          when(() => mockLoginUseCase(any()))
              .thenAnswer((_) async => const Left(
                    AuthFailure(message: 'Invalid credentials'),
                  ));
          return authBloc;
        },
        act: (bloc) => bloc.add(const LoginRequested(
          phone: '1234567890',
          password: 'wrongpassword',
        )),
        expect: () => [
          const AuthLoading(),
          const AuthError(message: 'Invalid credentials'),
        ],
      );

      blocTest<AuthBloc, AuthState>(
        'should emit [AuthLoading, AuthError] when validation fails',
        build: () {
          when(() => mockLoginUseCase(any()))
              .thenAnswer((_) async => const Left(
                    ValidationFailure(message: 'Phone and password are required'),
                  ));
          return authBloc;
        },
        act: (bloc) => bloc.add(const LoginRequested(
          phone: '',
          password: '',
        )),
        expect: () => [
          const AuthLoading(),
          const AuthError(message: 'Phone and password are required'),
        ],
      );
    });

    group('LogoutRequested', () {
      blocTest<AuthBloc, AuthState>(
        'should emit [AuthLoading, AuthUnauthenticated] when logout is successful',
        build: () {
          when(() => mockLogoutUseCase())
              .thenAnswer((_) async => const Right(null));
          return authBloc;
        },
        act: (bloc) => bloc.add(const LogoutRequested()),
        expect: () => [
          const AuthLoading(),
          const AuthUnauthenticated(),
        ],
        verify: (_) {
          verify(() => mockLogoutUseCase()).called(1);
        },
      );

      blocTest<AuthBloc, AuthState>(
        'should emit [AuthLoading, AuthError] when logout fails',
        build: () {
          when(() => mockLogoutUseCase())
              .thenAnswer((_) async => const Left(
                    ServerFailure(message: 'Failed to logout'),
                  ));
          return authBloc;
        },
        act: (bloc) => bloc.add(const LogoutRequested()),
        expect: () => [
          const AuthLoading(),
          const AuthError(message: 'Failed to logout'),
        ],
      );
    });

    group('CheckAuthStatus', () {
      blocTest<AuthBloc, AuthState>(
        'should emit [AuthLoading, AuthAuthenticated] when user is logged in',
        build: () {
          when(() => mockGetCurrentUserUseCase())
              .thenAnswer((_) async => Right(testUser));
          return authBloc;
        },
        act: (bloc) => bloc.add(const CheckAuthStatus()),
        expect: () => [
          const AuthLoading(),
          AuthAuthenticated(user: testUser),
        ],
        verify: (_) {
          verify(() => mockGetCurrentUserUseCase()).called(1);
        },
      );

      blocTest<AuthBloc, AuthState>(
        'should emit [AuthLoading, AuthUnauthenticated] when no user is logged in',
        build: () {
          when(() => mockGetCurrentUserUseCase())
              .thenAnswer((_) async => const Left(
                    CacheFailure(message: 'No user logged in'),
                  ));
          return authBloc;
        },
        act: (bloc) => bloc.add(const CheckAuthStatus()),
        expect: () => [
          const AuthLoading(),
          const AuthUnauthenticated(),
        ],
      );
    });
  });
}
