import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';
import 'package:location_app/data/models/location_model.dart';
import 'package:location_app/domain/entities/location.dart';
import 'package:location_app/domain/repositories/location_repository.dart';

@Injectable(as: LocationRepository)
class LocationRepositoryImpl implements LocationRepository {
  LocationRepositoryImpl(this.locationBox);
  final Box<LocationModel> locationBox;

  @override
  Future<void> saveLocation(Location location) async {
    final locationModel = LocationModel(
      latitude: location.latitude,
      longitude: location.longitude,
      timestamp: location.timestamp,
    );
    await locationBox.add(locationModel);
  }

  @override
  List<Location> getLocations() {
    final locations = locationBox.values.cast<LocationModel>();
    return locations
        .map((locationModel) => Location(
              latitude: locationModel.latitude,
              longitude: locationModel.longitude,
              timestamp: locationModel.timestamp,
            ))
        .toList();
  }
}
