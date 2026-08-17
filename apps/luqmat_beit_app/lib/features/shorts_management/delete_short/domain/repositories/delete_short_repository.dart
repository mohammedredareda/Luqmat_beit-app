import 'package:core/core.dart';

abstract class DeleteShortRepository {
  Future<Result<void>> deleteShort(String shortId);
}
