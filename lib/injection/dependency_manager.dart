import 'package:location_app/injection/injector.dart';
import 'package:location_app/presentation/routes/AppRouter.dart';

class DependencyManager {
  static Future<void> inject() async {
    injector.registerLazySingleton<AppRouter>(AppRouter.new);
    configureDependencies();
  }
}
