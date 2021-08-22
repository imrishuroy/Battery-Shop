import 'package:admin_battery/screens/amaron/amaron_tab.dart';
import 'package:admin_battery/screens/exide/exide_tab.dart';
import 'package:admin_battery/screens/sky/sky_tab.dart';
import 'package:admin_battery/widgets/tab_item.dart';
import 'package:flutter/material.dart';

class BatteryDashBoard extends StatelessWidget {
  static const String routeName = '/battery-dashboard';

  static Route route() {
    return PageRouteBuilder(
      settings: RouteSettings(name: routeName),
      transitionDuration: const Duration(seconds: 0),
      pageBuilder: (context, _, __) {
        return BatteryDashBoard();
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
            AmaronTab(),
            ExideTab(),
            SkyTab(),
          ],
        ),
      ),
    );
  }
}
