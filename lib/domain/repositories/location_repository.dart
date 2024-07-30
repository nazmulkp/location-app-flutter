import 'package:location_app/domain/entities/location.dart';

abstract class LocationRepository {
  Future<void> saveLocation(Location location);
  List<Location> getLocations();
}
