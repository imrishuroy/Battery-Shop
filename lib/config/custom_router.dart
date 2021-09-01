import 'package:battery_shop/screens/battery/battery_req_screen.dart';
import 'package:battery_shop/screens/home/home_screen.dart';
import 'package:battery_shop/screens/vehicles/vehicles_screen.dart';
import 'package:flutter/material.dart';

class CustomRouter {
  static Route onGenerateRoute(RouteSettings settings) {
    print('Route: ${settings.name}');
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
            settings: const RouteSettings(name: '/'),
            builder: (_) => Scaffold());

      case HomeScreen.routeName:
        return HomeScreen.route();

      case VehiclesScreen.routeName:
        return VehiclesScreen.route(
            args: settings.arguments as VehiclesScreenArgs?);

      case BatteryRequiredScreen.routeName:
        return BatteryRequiredScreen.route(
            args: settings.arguments as BatteryRequiredArgs?);

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
