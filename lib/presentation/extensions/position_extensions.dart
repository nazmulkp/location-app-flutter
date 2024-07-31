import 'package:geolocator/geolocator.dart';
import 'package:location_app/domain/entities/location.dart';

extension PositionX on Position {
  Location toLocation() {
    return Location(
      latitude: latitude,
      longitude: longitude,
      timestamp: DateTime.now(),
    );
  }
}
