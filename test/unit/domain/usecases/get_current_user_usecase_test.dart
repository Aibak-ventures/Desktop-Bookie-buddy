import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:bookie_buddy_web/src/core/errors/failures.dart';
import 'package:bookie_buddy_web/src/domain/entities/auth/user_entity.dart';
import 'package:bookie_buddy_web/src/domain/repositories/auth_repository.dart';
import 'package:bookie_buddy_web/src/domain/usecases/auth/get_current_user_usecase.dart';

// Mock repository for testing
class MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  late GetCurrentUserUseCase useCase;
  late MockAuthRepository mockRepository;

  setUp(() {
    mockRepository = MockAuthRepository();
    useCase = GetCurrentUserUseCase(repository: mockRepository);
  });

  group('GetCurrentUserUseCase', () {
    final testUser = UserEntity(
      id: 1,
      phone: '1234567890',
      name: 'Test User',
      email: 'test@example.com',
      createdAt: DateTime(2025, 1, 1),
    );

    test('should return UserEntity when user is logged in', () async {
      // Arrange
      when(() => mockRepository.getCurrentUser())
          .thenAnswer((_) async => Right(testUser));

      // Act
      final result = await useCase();

      // Assert
      expect(result, equals(Right(testUser)));
      verify(() => mockRepository.getCurrentUser()).called(1);
      verifyNoMoreInteractions(mockRepository);
    });

    test('should return CacheFailure when no user is logged in', () async {
      // Arrange
      const failure = CacheFailure(message: 'No user logged in');
      when(() => mockRepository.getCurrentUser())
          .thenAnswer((_) async => const Left(failure));

      // Act
      final result = await useCase();

      // Assert
      expect(result, equals(const Left(failure)));
      verify(() => mockRepository.getCurrentUser()).called(1);
    });

    test('should return ServerFailure when fetching user fails', () async {
      // Arrange
      const failure = ServerFailure(message: 'Failed to fetch user');
      when(() => mockRepository.getCurrentUser())
          .thenAnswer((_) async => const Left(failure));

      // Act
      final result = await useCase();

      // Assert
      expect(result, equals(const Left(failure)));
    });
  });
}
