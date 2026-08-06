import 'package:core/core.dart';

import '../repositories/auth_repository.dart';

class RegisterCustomer {
  const RegisterCustomer(this._repository);

  final AuthRepository _repository;

  Future<Result<void>> call({
    required String fullName,
    required String phone,
    required String password,
    required String address,
    double? latitude,
    double? longitude,
  }) {
    return _repository.registerCustomer(
      fullName: fullName,
      phone: phone,
      password: password,
      address: address,
      latitude: latitude,
      longitude: longitude,
    );
  }
}
