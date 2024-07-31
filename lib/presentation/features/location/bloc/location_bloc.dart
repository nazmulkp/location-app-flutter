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
  NewLocationReceived(this.location);
  final Location location;

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
  LocationLoaded(this.locations);
  final List<Location> locations;

  @override
  List<Object> get props => [locations];
}

class LocationError extends LocationState {
  LocationError(this.message);
  final String message;

  @override
  List<Object> get props => [message];
}

// BLoC
class LocationBloc extends Bloc<LocationEvent, LocationState> {
  LocationBloc() : super(LocationInitial()) {
    on<StartLocationTracking>(_onStartLocationTracking);
    on<StopLocationTracking>(_onStopLocationTracking);
    on<NewLocationReceived>(_onNewLocationReceived);
  }
  final getIt = GetIt.instance;
  StreamSubscription<Position>? positionStream;
  final LocationSettings locationSettings = const LocationSettings(
    accuracy: LocationAccuracy.high,
    distanceFilter: 1,
  );

  Future<void> _onStartLocationTracking(
    StartLocationTracking event,
    Emitter<LocationState> emit,
  ) async {
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
      emit(LocationError(e.toString()));
    }
  }

  Future<void> _onStopLocationTracking(
    StopLocationTracking event,
    Emitter<LocationState> emit,
  ) async {
    await positionStream?.cancel();
    emit(LocationInitial());
  }

  Future<void> _onNewLocationReceived(
    NewLocationReceived event,
    Emitter<LocationState> emit,
  ) async {
    final saveLocation = getIt.get<LocationRepository>().saveLocation;
    await saveLocation(event.location);
    final locations = getIt.get<GetLocations>().call();
    emit(LocationLoaded(locations));
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
        'Location permissions denied, We cannot request permissions.',
      );
    }

    return Geolocator.getCurrentPosition();
  }
}
