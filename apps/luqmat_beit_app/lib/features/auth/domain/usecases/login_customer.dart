import 'package:core/core.dart';

import '../repositories/auth_repository.dart';

class LoginCustomer {
  const LoginCustomer(this._repository);

  final AuthRepository _repository;

  Future<Result<UserEntity>> call({required String phone, required String password}) {
    return _repository.login(phone: phone, password: password);
  }
}
