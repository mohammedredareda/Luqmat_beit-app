import 'package:core/core.dart';

import '../../domain/repositories/change_password_repository.dart';
import '../datasources/password_remote_data_source.dart';

class ChangePasswordRepositoryImpl implements ChangePasswordRepository {
  ChangePasswordRepositoryImpl(this._dataSource);

  final PasswordRemoteDataSource _dataSource;

  @override
  Future<Result<void>> changePassword({
    required String cookId,
    required String currentPassword,
    required String newPassword,
  }) {
    return guard(() => _dataSource.changePassword(
          currentPassword: currentPassword,
          newPassword: newPassword,
        ));
  }
}
