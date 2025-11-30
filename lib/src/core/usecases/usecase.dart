import 'package:dartz/dartz.dart';
import '../errors/failures.dart';

/// Base use case interface
/// 
/// All use cases should extend this class to maintain consistency.
/// Uses Either type for error handling (Left = Failure, Right = Success)
/// 
/// Example:
/// ```dart
/// class LoginUseCase extends UseCase<User, LoginParams> {
///   @override
///   Future<Either<Failure, User>> call(LoginParams params) async {
///     // Implementation
///   }
/// }
/// ```
abstract class UseCase<Type, Params> {
  /// Execute the use case
  /// 
  /// Returns Either<Failure, Type>:
  /// - Left: Contains Failure if operation failed
  /// - Right: Contains Type if operation succeeded
  Future<Either<Failure, Type>> call(Params params);
}

/// Use case that doesn't require parameters
/// 
/// Example:
/// ```dart
/// class GetCurrentUserUseCase extends NoParamsUseCase<User> {
///   @override
///   Future<Either<Failure, User>> call() async {
///     // Implementation
///   }
/// }
/// ```
abstract class NoParamsUseCase<Type> {
  Future<Either<Failure, Type>> call();
}

/// Marker class for use cases that don't require parameters
class NoParams {
  const NoParams();
}
