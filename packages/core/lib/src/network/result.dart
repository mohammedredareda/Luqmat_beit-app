import 'exceptions/app_exception.dart';

/// The return type for every repository method that can fail. A
/// repository either produces data or a typed reason — callers can't
/// forget to check which.
sealed class Result<T> {
  const Result();

  const factory Result.success(T data) = Success<T>;
  const factory Result.failure(AppException exception) = Failure<T>;

  bool get isSuccess => this is Success<T>;
  bool get isFailure => this is Failure<T>;

  R fold<R>(
    R Function(T data) onSuccess,
    R Function(AppException exception) onFailure,
  ) {
    return switch (this) {
      Success<T>(data: final data) => onSuccess(data),
      Failure<T>(exception: final exception) => onFailure(exception),
    };
  }

  Result<R> map<R>(R Function(T data) transform) {
    return switch (this) {
      Success<T>(data: final data) => Result.success(transform(data)),
      Failure<T>(exception: final exception) => Result.failure(exception),
    };
  }
}

final class Success<T> extends Result<T> {
  final T data;
  const Success(this.data);
}

final class Failure<T> extends Result<T> {
  final AppException exception;
  const Failure(this.exception);
}

/// Runs [action] and converts any thrown [AppException] — or any other
/// exception, wrapped as [UnknownException] — into a [Result]. Repository
/// methods call their ApiClient inside this instead of hand-writing
/// try/catch.
Future<Result<T>> guard<T>(Future<T> Function() action) async {
  try {
    return Result.success(await action());
  } on AppException catch (e) {
    return Result.failure(e);
  } catch (e) {
    return Result.failure(
      UnknownException('حدث خطأ ما. حاول مرة أخرى.', cause: e),
    );
  }
}
