import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:location_app/injection/injector.dart';
import 'package:location_app/presentation/routes/AppRouter.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Assuming `injector` is previously defined and set up for dependency injection.
    final appRouter = injector<AppRouter>();
    return AnnotatedRegion<SystemUiOverlayStyle>(
      // Customize the status bar here. For example, using dark text for light themes.
      value: SystemUiOverlayStyle.dark.copyWith(
        statusBarColor: Colors.transparent, // You can set this to any color.
        statusBarIconBrightness: Brightness.dark, // Status bar icon color
        statusBarBrightness: Brightness.light, // Status bar background color
      ),
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'User Location',
        routerDelegate: AutoRouterDelegate(
          appRouter,
        ),
        routeInformationParser: appRouter.defaultRouteParser(),
      ),
    );
  }
}
