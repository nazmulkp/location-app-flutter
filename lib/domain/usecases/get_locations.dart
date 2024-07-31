import 'package:injectable/injectable.dart';
import 'package:location_app/domain/entities/location.dart';
import 'package:location_app/domain/repositories/location_repository.dart';

@injectable
class GetLocations {
  GetLocations(this.repository);
  final LocationRepository repository;

  List<Location> call() {
    return repository.getLocations();
  }
}
