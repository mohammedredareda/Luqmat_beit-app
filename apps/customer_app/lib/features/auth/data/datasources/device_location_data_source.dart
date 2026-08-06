import 'package:core/core.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

import '../../domain/entities/detected_location_entity.dart';

/// Real device GPS + reverse geocoding — no mock here, this is the one
/// piece of Registration wired to an actual platform capability instead of
/// an in-memory stub, per explicit request.
class DeviceLocationDataSource {
  Future<DetectedLocationEntity> getCurrentLocation() async {
    final serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw const LocationPermissionDeniedException(
        'خدمة الموقع غير مفعّلة على جهازك. الرجاء تفعيلها من الإعدادات.',
      );
    }

    var permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      throw const LocationPermissionDeniedException();
    }

    final position = await Geolocator.getCurrentPosition(
      locationSettings: const LocationSettings(accuracy: LocationAccuracy.high),
    );

    String formattedAddress = '${position.latitude.toStringAsFixed(5)}, '
        '${position.longitude.toStringAsFixed(5)}';
    try {
      final placemarks = await Geocoding().placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );
      if (placemarks.isNotEmpty) {
        final place = placemarks.first;
        formattedAddress = [place.subLocality, place.locality, place.administrativeArea]
            .where((part) => part != null && part.isNotEmpty)
            .join('، ');
        if (formattedAddress.isEmpty) {
          formattedAddress = '${position.latitude.toStringAsFixed(5)}, '
              '${position.longitude.toStringAsFixed(5)}';
        }
      }
    } catch (_) {
      // Reverse geocoding can fail independently of the GPS fix itself
      // (e.g. no geocoding service on this device) — fall back to raw
      // coordinates rather than failing the whole detection.
    }

    return DetectedLocationEntity(
      latitude: position.latitude,
      longitude: position.longitude,
      formattedAddress: formattedAddress,
    );
  }
}
