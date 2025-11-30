import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:bookie_buddy_web/src/core/errors/failures.dart';
import 'package:bookie_buddy_web/src/domain/entities/auth/user_entity.dart';
import 'package:bookie_buddy_web/src/domain/repositories/auth_repository.dart';
import 'package:bookie_buddy_web/src/domain/usecases/auth/login_usecase.dart';

// Mock repository for testing
class MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  late LoginUseCase useCase;
  late MockAuthRepository mockRepository;

  setUp(() {
    mockRepository = MockAuthRepository();
    useCase = LoginUseCase(repository: mockRepository);
  });

  group('LoginUseCase', () {
    const testPhone = '1234567890';
    const testPassword = 'password123';
    const testDeviceToken = 'device_token_123';

    final testUser = UserEntity(
      id: 1,
      phone: testPhone,
      name: 'Test User',
      email: 'test@example.com',
      createdAt: DateTime(2025, 1, 1),
    );

    test('should return UserEntity when login is successful', () async {
      // Arrange
      when(() => mockRepository.login(
            phone: any(named: 'phone'),
            password: any(named: 'password'),
            deviceToken: any(named: 'deviceToken'),
          )).thenAnswer((_) async => Right(testUser));

      // Act
      final result = await useCase(LoginParams(
        phone: testPhone,
        password: testPassword,
        deviceToken: testDeviceToken,
      ));

      // Assert
      expect(result, equals(Right(testUser)));
      verify(() => mockRepository.login(
            phone: testPhone,
            password: testPassword,
            deviceToken: testDeviceToken,
          )).called(1);
      verifyNoMoreInteractions(mockRepository);
    });

    test('should return AuthFailure when credentials are invalid', () async {
      // Arrange
      const failure = AuthFailure(message: 'Invalid credentials');
      when(() => mockRepository.login(
            phone: any(named: 'phone'),
            password: any(named: 'password'),
            deviceToken: any(named: 'deviceToken'),
          )).thenAnswer((_) async => const Left(failure));

      // Act
      final result = await useCase(LoginParams(
        phone: testPhone,
        password: testPassword,
      ));

      // Assert
      expect(result, equals(const Left(failure)));
      verify(() => mockRepository.login(
            phone: testPhone,
            password: testPassword,
            deviceToken: null,
          )).called(1);
    });

    test('should return NetworkFailure when there is no internet', () async {
      // Arrange
      const failure = NetworkFailure();
      when(() => mockRepository.login(
            phone: any(named: 'phone'),
            password: any(named: 'password'),
            deviceToken: any(named: 'deviceToken'),
          )).thenAnswer((_) async => const Left(failure));

      // Act
      final result = await useCase(LoginParams(
        phone: testPhone,
        password: testPassword,
      ));

      // Assert
      expect(result, equals(const Left(failure)));
    });

    test('should return ValidationFailure when phone is empty', () async {
      // Act
      final result = await useCase(const LoginParams(
        phone: '',
        password: testPassword,
      ));

      // Assert
      expect(result.isLeft(), true);
      result.fold(
        (failure) {
          expect(failure, isA<ValidationFailure>());
          expect((failure as ValidationFailure).message,
              contains('Phone and password are required'));
        },
        (_) => fail('Should return failure'),
      );
      verifyZeroInteractions(mockRepository);
    });

    test('should return ValidationFailure when password is empty', () async {
      // Act
      final result = await useCase(const LoginParams(
        phone: testPhone,
        password: '',
      ));

      // Assert
      expect(result.isLeft(), true);
      result.fold(
        (failure) {
          expect(failure, isA<ValidationFailure>());
          expect((failure as ValidationFailure).message,
              contains('Phone and password are required'));
        },
        (_) => fail('Should return failure'),
      );
      verifyZeroInteractions(mockRepository);
    });

    test('should return ValidationFailure when phone is invalid', () async {
      // Act
      final result = await useCase(const LoginParams(
        phone: '123', // Too short
        password: testPassword,
      ));

      // Assert
      expect(result.isLeft(), true);
      result.fold(
        (failure) {
          expect(failure, isA<ValidationFailure>());
          expect((failure as ValidationFailure).message, contains('Invalid phone'));
        },
        (_) => fail('Should return failure'),
      );
      verifyZeroInteractions(mockRepository);
    });
  });
}
