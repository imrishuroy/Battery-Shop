import '/screens/about/about_screen.dart';
import '/screens/battery/battery_req_screen.dart';
import '/screens/home/home_screen.dart';
import '/screens/vehicles/vehicles_catelog.dart';
import 'package:flutter/material.dart';

class CustomRouter {
  static Route onGenerateRoute(RouteSettings settings) {
    print('Route: ${settings.name}');
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
          settings: const RouteSettings(name: '/'),
          builder: (_) => const Scaffold(),
        );

      case HomeScreen.routeName:
        return HomeScreen.route();

      case VehiclesCatelog.routeName:
        return VehiclesCatelog.route(
          args: settings.arguments as VehiclesCatelogArgs?,
        );

      case BatteryRequiredScreen.routeName:
        return BatteryRequiredScreen.route(
          args: settings.arguments as BatteryRequiredArgs?,
        );

      case AboutScreen.routeName:
        return AboutScreen.route();

      default:
        return _errorRoute();
    }
  }

  static Route _errorRoute() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: '/error'),
      builder: (_) => Scaffold(
        appBar: AppBar(
          title: const Text(
            'Error',
          ),
        ),
        body: const Center(
          child: Text(
            'Something went wrong',
            style: TextStyle(
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
