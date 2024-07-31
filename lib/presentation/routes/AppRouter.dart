// ignore: file_names
import 'package:auto_route/auto_route.dart';
import 'package:location_app/presentation/routes/AppRouter.gr.dart';

@AutoRouterConfig()
class AppRouter extends $AppRouter {
  @override
  RouteType get defaultRouteType => const RouteType.material();

  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          page: SplashRoute.page,
          path: '/',
        ),
        AutoRoute(
          path: '/home',
          page: HomeRoute.page,
          initial: true,
        ),
      ];
}
