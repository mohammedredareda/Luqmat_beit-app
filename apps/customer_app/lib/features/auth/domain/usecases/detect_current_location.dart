import 'package:core/core.dart';

import '../entities/detected_location_entity.dart';
import '../repositories/location_repository.dart';

class DetectCurrentLocation {
  const DetectCurrentLocation(this._repository);

  final LocationRepository _repository;

  Future<Result<DetectedLocationEntity>> call() => _repository.detectCurrentLocation();
}
