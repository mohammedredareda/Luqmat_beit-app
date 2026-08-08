import '../network/result.dart';
import 'detected_location_entity.dart';

/// Registration location auto-detection, for both apps. Kept as its own
/// repository (rather than folded into auth) since it wraps a device
/// capability (GPS/geocoding), not a backend call.
abstract class LocationRepository {
  Future<Result<DetectedLocationEntity>> detectCurrentLocation();
}
