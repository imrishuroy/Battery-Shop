import 'package:admin_battery/blocs/auth/auth_bloc.dart';
import 'package:admin_battery/screens/battery/battery_dashboard.dart';
import 'package:admin_battery/screens/home/home_screen.dart';
import 'package:admin_battery/screens/login/login_screen.dart';
import 'package:admin_battery/widgets/loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthWrapper extends StatelessWidget {
  static const String routeName = '/auth';

  static Route route() {
    return PageRouteBuilder(
      settings: RouteSettings(name: routeName),
      pageBuilder: (context, _, __) => AuthWrapper(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state.status == AuthStatus.unauthenticated) {
          Navigator.of(context).pushNamed(LoginScreen.routeName);
        } else if (state.status == AuthStatus.authenticated) {
          // Navigator.of(context).pushNamed(HomeScreen.routeName);
          Navigator.of(context).pushNamed(BatteryDashBoard.routeName);
        }
      },
      child: Scaffold(
        body: LoadingIndicator(),
      ),
    );
  }
}
