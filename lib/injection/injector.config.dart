// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:hive/hive.dart' as _i979;
import 'package:hive_flutter/hive_flutter.dart' as _i986;
import 'package:injectable/injectable.dart' as _i526;

import '../data/models/location_model.dart' as _i734;
import '../data/repositories/location_repository_impl.dart' as _i417;
import '../domain/repositories/location_repository.dart' as _i583;
import '../domain/usecases/get_locations.dart' as _i443;
import 'hive_module.dart' as _i576;

// initializes the registration of main-scope dependencies inside of GetIt
Future<_i174.GetIt> $initGetIt(
  _i174.GetIt getIt, {
  String? environment,
  _i526.EnvironmentFilter? environmentFilter,
}) async {
  final gh = _i526.GetItHelper(
    getIt,
    environment,
    environmentFilter,
  );
  final hiveModule = _$HiveModule();
  await gh.factoryAsync<_i986.Box<_i734.LocationModel>>(
    () => hiveModule.locationBox,
    preResolve: true,
  );
  gh.factory<_i583.LocationRepository>(
      () => _i417.LocationRepositoryImpl(gh<_i979.Box<_i734.LocationModel>>()));
  gh.factory<_i443.GetLocations>(
      () => _i443.GetLocations(gh<_i583.LocationRepository>()));
  return getIt;
}

class _$HiveModule extends _i576.HiveModule {}
