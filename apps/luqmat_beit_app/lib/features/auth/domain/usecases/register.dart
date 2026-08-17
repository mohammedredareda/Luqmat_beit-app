import 'package:core/core.dart';

import '../repositories/auth_repository.dart';

class Register {
  const Register(this._repository);

  final AuthRepository _repository;

  Future<Result<void>> call({
    required UserRole role,
    required String name,
    required String phone,
    required String password,
    required String address,
    String? description,
    DateTime? startAvailabilityTime,
    DateTime? endAvailabilityTime,
    List<int>? availabilityDays,
    double? latitude,
    double? longitude,
  }) {
    return _repository.register(
      role: role,
      name: name,
      phone: phone,
      password: password,
      address: address,
      description: description,
      startAvailabilityTime: startAvailabilityTime,
      endAvailabilityTime: endAvailabilityTime,
      availabilityDays: availabilityDays,
      latitude: latitude,
      longitude: longitude,
    );
  }
}
