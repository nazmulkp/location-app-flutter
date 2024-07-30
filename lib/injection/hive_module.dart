import 'package:hive_flutter/hive_flutter.dart';
import 'package:injectable/injectable.dart';
import 'package:location_app/data/models/location_model.dart';

@module
abstract class HiveModule {
  @preResolve
  Future<Box<LocationModel>> get locationBox async {
    await Hive.initFlutter();
    Hive.registerAdapter(LocationModelAdapter());
    return Hive.openBox<LocationModel>('locations');
  }
}
