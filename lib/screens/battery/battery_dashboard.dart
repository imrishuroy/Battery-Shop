import 'package:admin_battery/constants/urls.dart';
import 'package:admin_battery/repositories/rest-apis/rest_apis_repo.dart';
import 'package:admin_battery/screens/amaron/amaron_tab.dart';
import 'package:admin_battery/screens/amaron/bloc/amaron_bloc.dart';
import 'package:admin_battery/screens/exide/bloc/exide_bloc.dart';
import 'package:admin_battery/screens/exide/exide_tab.dart';
import 'package:admin_battery/screens/sky/bloc/sky_bloc.dart';
import 'package:admin_battery/screens/sky/sky_tab.dart';
import 'package:admin_battery/widgets/tab_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BatteryDashBoard extends StatelessWidget {
  static const String routeName = '/battery-dashboard';

  static Route route() {
    return PageRouteBuilder(
      settings: RouteSettings(name: routeName),
      transitionDuration: const Duration(seconds: 0),
      pageBuilder: (context, _, __) {
        return MultiBlocProvider(
          providers: [
            BlocProvider<AmaronBloc>(
              create: (context) => AmaronBloc(
                path: Urls.amaronUrl,
                repository: context.read<RestApisRepository>(),
              ),
            ),
            BlocProvider<SkyBloc>(
              create: (context) => SkyBloc(
                path: Urls.skyUrl,
                restApisRepository: context.read<RestApisRepository>(),
              ),
            ),
            BlocProvider<ExideBloc>(
              create: (context) => ExideBloc(
                restApisRepository: context.read<RestApisRepository>(),
              ),
            ),
          ],
          child: BatteryDashBoard(),
        );
      },
    );
  }

  const BatteryDashBoard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Battery DashBoard'),
          actions: [
            TextButton(
              onPressed: () {},
              child: Text(
                'Set Priority',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.0,
                ),
              ),
            ),
            const SizedBox(width: 15.0)
          ],
          bottom: TabBar(
            indicatorColor: Colors.white,
            tabs: [
              TabItem(label: 'Amaron', icon: Icons.battery_full),
              TabItem(label: 'Exide', icon: Icons.today_sharp),
              TabItem(label: 'Sky', icon: Icons.today_sharp),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            AmaronTab(),
            ExideTab(),
            SkyTab(),
          ],
        ),
      ),
    );
  }
}
