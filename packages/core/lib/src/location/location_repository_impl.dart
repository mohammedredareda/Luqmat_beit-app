import '../network/result.dart';
import 'detected_location_entity.dart';
import 'device_location_data_source.dart';
import 'location_repository.dart';

class LocationRepositoryImpl implements LocationRepository {
  LocationRepositoryImpl({DeviceLocationDataSource? dataSource})
      : _dataSource = dataSource ?? DeviceLocationDataSource();

  final DeviceLocationDataSource _dataSource;

  @override
  Future<Result<DetectedLocationEntity>> detectCurrentLocation() {
    return guard(() => _dataSource.getCurrentLocation());
  }
}
