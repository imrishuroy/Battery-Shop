import 'package:admin_battery/constants/urls.dart';
import 'package:admin_battery/repositories/battery/battery_repository.dart';
import 'package:admin_battery/repositories/rest-apis/rest_apis_repo.dart';
import 'package:admin_battery/screens/amaron/bloc/amaron_bloc.dart';
import 'package:admin_battery/screens/exide/bloc/exide_bloc.dart';
import 'package:admin_battery/screens/exide/exide_tab.dart';
import 'package:admin_battery/screens/remote-battery/remote_amaron_tab.dart';
import 'package:admin_battery/screens/sky/bloc/sky_bloc.dart';
import 'package:admin_battery/screens/sky/sky_tab.dart';
import 'package:admin_battery/widgets/tab_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RemoteBatteryArguments {}

class RemoteBatteryScreen extends StatelessWidget {
  static const String routeName = '/remote-battery';

  static Route route() {
    return PageRouteBuilder(
      settings:
          RouteSettings(name: routeName, arguments: RemoteBatteryArguments),
      transitionDuration: const Duration(seconds: 0),
      pageBuilder: (context, _, __) {
        return MultiBlocProvider(providers: [
          BlocProvider<AmaronBloc>(
            create: (context) => AmaronBloc(
              path: Urls.amaronUrl,
              repository: context.read<BatteryRepository>(),
            ),
          ),
          BlocProvider<SkyBloc>(
            create: (context) => SkyBloc(
              restApisRepository: context.read<RestApisRepository>(),
            ),
          ),
          BlocProvider<ExideBloc>(
            create: (context) => ExideBloc(
              restApisRepository: context.read<RestApisRepository>(),
            ),
          ),
        ], child: RemoteBatteryScreen());
      },
    );
  }

  const RemoteBatteryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: Text('Admin Panel'),
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
            //AmaronTab(),()
            RemoteAmaronTab(),
            ExideTab(),
            SkyTab(),
          ],
        ),
      ),
    );
  }
}
