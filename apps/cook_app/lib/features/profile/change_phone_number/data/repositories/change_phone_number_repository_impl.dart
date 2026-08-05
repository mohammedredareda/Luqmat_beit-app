import 'package:core/core.dart';
import 'package:injectable/injectable.dart';

import '../../domain/repositories/change_phone_number_repository.dart';
import '../datasources/fake_phone_change_remote_data_source.dart';

@LazySingleton(as: ChangePhoneNumberRepository)
class ChangePhoneNumberRepositoryImpl implements ChangePhoneNumberRepository {
  ChangePhoneNumberRepositoryImpl(this._dataSource);

  final FakePhoneChangeRemoteDataSource _dataSource;

  @override
  Future<Result<void>> requestPhoneChange({required String cookId, required String newPhoneNumber}) {
    return guard(() => _dataSource.requestPhoneChange(cookId, newPhoneNumber));
  }

  @override
  Future<Result<void>> resendCode({required String cookId}) {
    return guard(() => _dataSource.resendCode(cookId));
  }

  @override
  Future<Result<CookProfileEntity>> verifyPhoneChange({required String cookId, required String code}) {
    return guard(() async {
      final model = await _dataSource.verifyPhoneChange(cookId, code);
      return model.toEntity();
    });
  }
}
