import 'package:core/core.dart';

abstract class ViewProfileRepository {
  Future<Result<CookProfileEntity>> getProfile(String cookId);
}
