import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:bookie_buddy_web/src/core/errors/failures.dart';
import 'package:bookie_buddy_web/src/domain/repositories/auth_repository.dart';
import 'package:bookie_buddy_web/src/domain/usecases/auth/logout_usecase.dart';

// Mock repository for testing
class MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  late LogoutUseCase useCase;
  late MockAuthRepository mockRepository;

  setUp(() {
    mockRepository = MockAuthRepository();
    useCase = LogoutUseCase(repository: mockRepository);
  });

  group('LogoutUseCase', () {
    test('should successfully logout user', () async {
      // Arrange
      when(() => mockRepository.logout())
          .thenAnswer((_) async => const Right(null));

      // Act
      final result = await useCase();

      // Assert
      expect(result, equals(const Right(null)));
      verify(() => mockRepository.logout()).called(1);
      verifyNoMoreInteractions(mockRepository);
    });

    test('should return ServerFailure when logout fails', () async {
      // Arrange
      const failure = ServerFailure(message: 'Failed to logout');
      when(() => mockRepository.logout())
          .thenAnswer((_) async => const Left(failure));

      // Act
      final result = await useCase();

      // Assert
      expect(result, equals(const Left(failure)));
      verify(() => mockRepository.logout()).called(1);
    });

    test('should return NetworkFailure when there is no internet', () async {
      // Arrange
      const failure = NetworkFailure();
      when(() => mockRepository.logout())
          .thenAnswer((_) async => const Left(failure));

      // Act
      final result = await useCase();

      // Assert
      expect(result, equals(const Left(failure)));
    });
  });
}
