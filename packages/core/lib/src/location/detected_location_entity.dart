import 'package:equatable/equatable.dart';

/// Result of a device GPS lookup + reverse geocode — the "تحديد" (Detect)
/// button on registration fills the location field and suggests this into
/// the address textarea (still editable, per the mockup).
class DetectedLocationEntity extends Equatable {
  const DetectedLocationEntity({
    required this.latitude,
    required this.longitude,
    required this.formattedAddress,
  });

  final double latitude;
  final double longitude;
  final String formattedAddress;

  @override
  List<Object?> get props => [latitude, longitude, formattedAddress];
}
