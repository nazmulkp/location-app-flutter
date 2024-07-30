import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get_it/get_it.dart';
import 'package:location_app/domain/entities/location.dart';
import 'package:location_app/domain/repositories/location_repository.dart';
import 'package:location_app/domain/usecases/get_locations.dart';
import 'package:location_app/presentation/extensions/position_extensions.dart';

// Events
abstract class LocationEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class StartLocationTracking extends LocationEvent {}

class StopLocationTracking extends LocationEvent {}

class NewLocationReceived extends LocationEvent {
  final Location location;

  NewLocationReceived(this.location);

  @override
  List<Object> get props => [location];
}

// States
abstract class LocationState extends Equatable {
  @override
  List<Object> get props => [];
}

class LocationInitial extends LocationState {}

class LocationLoading extends LocationState {}

class LocationLoaded extends LocationState {
  final List<Location> locations;

  LocationLoaded(this.locations);

  @override
  List<Object> get props => [locations];
}

// BLoC
class LocationBloc extends Bloc<LocationEvent, LocationState> {
  final getIt = GetIt.instance;
  StreamSubscription<Position>? positionStream;
  final LocationSettings locationSettings = const LocationSettings(
    accuracy: LocationAccuracy.high,
    distanceFilter: 100,
  );

  LocationBloc() : super(LocationInitial()) {
    on<StartLocationTracking>(_onStartLocationTracking);
    on<StopLocationTracking>(_onStopLocationTracking);
    on<NewLocationReceived>(_onNewLocationReceived);
  }

  Future<void> _onStartLocationTracking(
      StartLocationTracking event, Emitter<LocationState> emit) async {
    emit(LocationLoading());
    try {
      await _determinePosition();
      positionStream =
          Geolocator.getPositionStream(locationSettings: locationSettings)
              .listen((Position position) {
        final location = position.toLocation();
        add(NewLocationReceived(location));
      });
    } catch (e) {
      emit(LocationInitial());
    }
  }

  Future<void> _onStopLocationTracking(
      StopLocationTracking event, Emitter<LocationState> emit) async {
    await positionStream?.cancel();
    emit(LocationInitial());
  }

  Future<void> _onNewLocationReceived(
      NewLocationReceived event, Emitter<LocationState> emit) async {
    final saveLocation = getIt.get<LocationRepository>().saveLocation;
    await saveLocation(event.location);
    final locations = await getIt.get<GetLocations>().call();
    emit(LocationLoaded(locations));
  }

  /// Determine the current position of the device.
  ///
  /// When the location services are not enabled or permissions
  /// are denied the `Future` will return an error.
  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.',
      );
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return Geolocator.getCurrentPosition();
  }
}
