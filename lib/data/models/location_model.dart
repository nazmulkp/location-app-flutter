import 'package:hive/hive.dart';
part 'location_model.g.dart';

@HiveType(typeId: 1)
class LocationModel extends HiveObject {
  LocationModel({
    required this.latitude,
    required this.longitude,
    required this.timestamp,
  });
  @HiveField(0)
  final double latitude;

  @HiveField(1)
  final double longitude;

  @HiveField(2)
  final DateTime timestamp;
}
