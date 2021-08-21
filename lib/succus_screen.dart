import 'package:admin_battery/repositories/auth/auth_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SuccussScreen extends StatelessWidget {
  static const String routeName = '/succuss';

  static Route route() {
    return MaterialPageRoute(
      settings: RouteSettings(name: routeName),
      builder: (context) => SuccussScreen(),
    );
  }

  const SuccussScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          context.read<AuthRepository>().logOut();
        },
        child: Icon(Icons.logout),
      ),
      body: Center(
        child: Text('Succusssfulll'),
      ),
    );
  }
}
