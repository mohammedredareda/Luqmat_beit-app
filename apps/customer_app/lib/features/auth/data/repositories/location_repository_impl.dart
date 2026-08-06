import 'package:core/core.dart';

import '../../domain/entities/detected_location_entity.dart';
import '../../domain/repositories/location_repository.dart';
import '../datasources/device_location_data_source.dart';

class LocationRepositoryImpl implements LocationRepository {
  LocationRepositoryImpl({DeviceLocationDataSource? dataSource})
      : _dataSource = dataSource ?? DeviceLocationDataSource();

  final DeviceLocationDataSource _dataSource;

  @override
  Future<Result<DetectedLocationEntity>> detectCurrentLocation() {
    return guard(() => _dataSource.getCurrentLocation());
  }
}
