import '../network/result.dart';
import 'detected_location_entity.dart';
import 'location_repository.dart';

class DetectCurrentLocation {
  const DetectCurrentLocation(this._repository);

  final LocationRepository _repository;

  Future<Result<DetectedLocationEntity>> call() => _repository.detectCurrentLocation();
}
