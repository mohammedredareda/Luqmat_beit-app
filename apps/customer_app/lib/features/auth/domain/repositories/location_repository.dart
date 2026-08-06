import 'package:core/core.dart';

import '../entities/detected_location_entity.dart';

/// CU — location auto-detection during registration. Kept as its own
/// repository (rather than folded into [AuthRepository]) since it wraps a
/// device capability (GPS/geocoding), not a backend call.
abstract class LocationRepository {
  Future<Result<DetectedLocationEntity>> detectCurrentLocation();
}
