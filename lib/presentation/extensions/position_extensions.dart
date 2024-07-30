import 'package:geolocator/geolocator.dart';
import '../../domain/entities/location.dart';

extension PositionX on Position {
  Location toLocation() {
    return Location(
      latitude: this.latitude,
      longitude: this.longitude,
      timestamp: DateTime.now(),
    );
  }
}
