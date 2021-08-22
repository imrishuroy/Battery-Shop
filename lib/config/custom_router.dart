import 'package:admin_battery/config/auth_wrapper.dart';
import 'package:admin_battery/screens/battery/battery_dashboard.dart';
import 'package:admin_battery/screens/home/home_screen.dart';
import 'package:admin_battery/screens/login/login_screen.dart';
import 'package:admin_battery/succus_screen.dart';
import 'package:flutter/material.dart';

class CustomRouter {
  static Route onGenerateRoute(RouteSettings settings) {
    print('Route: ${settings.name}');
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
            settings: const RouteSettings(name: '/'),
            builder: (_) => Scaffold());

      case AuthWrapper.routeName:
        return AuthWrapper.route();

      case LoginScreen.routeName:
        return LoginScreen.route();

      case HomeScreen.routeName:
        return HomeScreen.route();

      case BatteryDashBoard.routeName:
        return BatteryDashBoard.route();

      case SuccussScreen.routeName:
        return SuccussScreen.route();

      default:
        return ErrorRoute.route();
    }
  }

  // static Route onGenerateNestedRouter(RouteSettings settings) {
  //   print('NestedRoute: ${settings.name}');
  //   switch (settings.name) {
  //     case ProfileScreen.routeName:
  //       return ProfileScreen.route();
  //     // args: settings.arguments as ProfileScreenArgs);
  //     case GalleryScreen.routeName:
  //       return GalleryScreen.route();
  //     case DashBoard.routeName:
  //       return DashBoard.route();
  //     default:
  //       return _errorRoute();
  //   }
  // }

  // static Route _errorRoute() {
  //   return MaterialPageRoute(
  //     settings: const RouteSettings(name: '/error'),
  //     builder: (_) => Scaffold(
  //       appBar: AppBar(
  //         title: const Text(
  //           'Error',
  //         ),
  //       ),
  //       body: Center(
  //         child: Column(
  //           children: [
  //             Text(
  //               'Something went wrong',
  //               style: TextStyle(
  //                 color: Colors.black,
  //               ),
  //             ),
  //             const SizedBox(height: 6.0),
  //             TextButton(
  //                 onPressed: () {
  //                   Navigator.of(context).pushNamed('/');
  //                 },
  //                 child: Text('Re Try'))
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }
}

class ErrorRoute extends StatelessWidget {
  const ErrorRoute({Key? key}) : super(key: key);

  static const String routeNmae = '/error';

  static Route route() {
    return MaterialPageRoute(
      settings: RouteSettings(name: routeNmae),
      builder: (_) => ErrorRoute(),
    );
  }

  @override
  Widget build(BuildContext context) {
    Navigator.of(context)
        .pushNamedAndRemoveUntil(AuthWrapper.routeName, (route) => false);
    return Center(
      child: Column(
        children: [
          Text(
            'Something went wrong',
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 6.0),
          TextButton(
              onPressed: () {
                Navigator.of(context).pushNamedAndRemoveUntil(
                    AuthWrapper.routeName, (route) => false);
              },
              child: Text('Re Try'))
        ],
      ),
    );
  }
}
