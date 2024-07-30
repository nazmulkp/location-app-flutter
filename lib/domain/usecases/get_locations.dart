import 'package:injectable/injectable.dart';
import 'package:location_app/domain/entities/location.dart';
import 'package:location_app/domain/repositories/location_repository.dart';

@injectable
class GetLocations {
  final LocationRepository repository;

  GetLocations(this.repository);

  List<Location> call() {
    return repository.getLocations();
  }
}
