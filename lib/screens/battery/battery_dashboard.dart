import '/screens/livfast/bloc/livfast_bloc.dart';
import '/screens/livfast/livfast_tab.dart';
import '/screens/luminous/bloc/luminous_bloc.dart';
import '/screens/luminous/luminous_tab.dart';

import '/screens/alfa/alfa_tab.dart';
import '/screens/alfa/bloc/alfa_bloc.dart';

import '/constants/urls.dart';
import '/repositories/rest-apis/rest_apis_repo.dart';
import '/screens/amaron/amaron_tab.dart';
import '/screens/amaron/bloc/amaron_bloc.dart';
import '/screens/exide/bloc/exide_bloc.dart';
import '/screens/exide/exide_tab.dart';
import '/screens/sky/bloc/sky_bloc.dart';
import '/screens/sky/sky_tab.dart';
import '/widgets/tab_item.dart';
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
                repository: context.read<RestApisRepository>(),
              ),
            ),
            BlocProvider<AlfaBloc>(
              create: (context) => AlfaBloc(
                repository: context.read<RestApisRepository>(),
                path: Urls.alfaUrl,
              ),
            ),
            BlocProvider<ExideBloc>(
              create: (context) => ExideBloc(
                path: Urls.exideUrl,
                repository: context.read<RestApisRepository>(),
              ),
            ),
            BlocProvider<LuminousBloc>(
              create: (context) => LuminousBloc(
                repository: context.read<RestApisRepository>(),
                path: Urls.luminousUrl,
              ),
            ),
            BlocProvider<LivFastBloc>(
              create: (context) => LivFastBloc(
                repository: context.read<RestApisRepository>(),
                path: Urls.livFastUrl,
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
      length: 6,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Battery DashBoard'),
          actions: [
            // TextButton(
            //   onPressed: () {},
            //   child: Text(
            //     'Set Priority',
            //     style: TextStyle(
            //       color: Colors.white,
            //       fontSize: 16.0,
            //     ),
            //   ),
            // ),
            const SizedBox(width: 15.0)
          ],
          bottom: TabBar(
            indicatorColor: Colors.white,
            tabs: [
              TabItem(label: 'Amaron', icon: Icons.today_sharp),
              TabItem(label: 'Exide', icon: Icons.today_sharp),
              TabItem(label: 'Sky', icon: Icons.today_sharp),
              TabItem(label: 'Alfa', icon: Icons.today_sharp),
              TabItem(label: 'Luminous', icon: Icons.today_sharp),
              TabItem(label: 'LivFast', icon: Icons.today_sharp)
            ],
          ),
        ),
        body: TabBarView(
          children: [
            AmaronTab(),
            ExideTab(),
            SkyTab(),
            AlfaTab(),
            LuminousTab(),
            LivFastTab(),
          ],
        ),
      ),
    );
  }
}
