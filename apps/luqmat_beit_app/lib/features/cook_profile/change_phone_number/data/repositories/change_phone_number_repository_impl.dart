import 'package:core/core.dart';

import '../../domain/repositories/change_phone_number_repository.dart';
import '../datasources/phone_change_remote_data_source.dart';

class ChangePhoneNumberRepositoryImpl implements ChangePhoneNumberRepository {
  ChangePhoneNumberRepositoryImpl(this._dataSource);

  final PhoneChangeRemoteDataSource _dataSource;

  @override
  Future<Result<void>> requestPhoneChange({required String cookId, required String newPhoneNumber}) {
    return guard(() => _dataSource.requestPhoneChange(newPhoneNumber));
  }

  @override
  Future<Result<void>> resendCode({required String cookId, required String newPhoneNumber}) {
    return guard(() => _dataSource.requestPhoneChange(newPhoneNumber));
  }

  @override
  Future<Result<String>> verifyPhoneChange({
    required String cookId,
    required String newPhoneNumber,
    required String code,
  }) {
    return guard(
      () => _dataSource.verifyPhoneChange(newPhoneNumber: newPhoneNumber, code: code),
    );
  }
}
