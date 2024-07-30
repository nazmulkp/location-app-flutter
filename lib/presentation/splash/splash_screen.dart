import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:location_app/presentation/routes/AppRouter.gr.dart';

@RoutePage()
class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Trigger the navigation after a delay
    Future.delayed(const Duration(seconds: 2), () {
      // Use AutoRoute to replace the current route with the MainRoute
      context.router.replace(const HomeRoute());
    });

    // Your current splash screen UI
    return const Scaffold(
      body: Center(
        child: Text('Processing...'),
      ),
    );
  }
}
