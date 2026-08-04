import 'exceptions/app_exception.dart';

/// The return type for every repository method that can fail. Replaces
/// the common but ambiguous pattern of throwing for some failures and
/// returning null/false for others — a repository either produces data
/// or a typed reason, and callers can't forget to check which.
sealed class Result<T> {
  const Result();

  const factory Result.success(T data) = Success<T>;
  const factory Result.failure(AppException exception) = Failure<T>;

  bool get isSuccess => this is Success<T>;
  bool get isFailure => this is Failure<T>;

  /// Collapse both branches into one value — typically a UI state.
  R fold<R>(
    R Function(T data) onSuccess,
    R Function(AppException exception) onFailure,
  ) {
    return switch (this) {
      Success<T>(data: final data) => onSuccess(data),
      Failure<T>(exception: final exception) => onFailure(exception),
    };
  }

  /// Transform the success value without unwrapping the Result.
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
/// try/catch, which is what keeps every failure path returning a typed
/// Result instead of throwing past the repository boundary.
Future<Result<T>> guard<T>(Future<T> Function() action) async {
  try {
    return Result.success(await action());
  } on AppException catch (e) {
    return Result.failure(e);
  } catch (e) {
    // Anything that reaches here is a bug or an unmapped edge case
    // (e.g. a JSON-decoding error on a malformed 200 response) rather
    // than an expected API failure — still surfaced as a Result, not a
    // crash, but worth logging loudly via the project's logger.
    return Result.failure(
      UnknownException('Something went wrong. Please try again.', cause: e),
    );
  }
}
