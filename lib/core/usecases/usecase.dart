import '../errors/failures.dart';

// Simple Result type to replace Either from dartz
class Result<T> {
  final T? data;
  final Failure? failure;

  Result.success(this.data) : failure = null;
  Result.failure(this.failure) : data = null;

  bool get isSuccess => failure == null;
  bool get isFailure => failure != null;

  // Helper methods for easy access
  T get successData {
    if (isSuccess) return data as T;
    throw Exception('Tried to get success data from a failure result');
  }

  Failure get failureData {
    if (isFailure) return failure!;
    throw Exception('Tried to get failure data from a success result');
  }

  // Transform methods
  Result<U> map<U>(U Function(T) transform) {
    if (isSuccess) {
      return Result.success(transform(data as T));
    }
    return Result.failure(failure!);
  }

  Result<U> flatMap<U>(Result<U> Function(T) transform) {
    if (isSuccess) {
      return transform(data as T);
    }
    return Result.failure(failure!);
  }
}

// Base use case with parameters
abstract class UseCase<Type, Params> {
  Future<Result<Type>> call(Params params);
}

// Base use case without parameters
abstract class UseCaseNoParams<Type> {
  Future<Result<Type>> call();
}

// No parameters class
class NoParams {
  const NoParams();
}
