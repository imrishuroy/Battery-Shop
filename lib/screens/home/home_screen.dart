import 'package:admin_battery/screens/battery/battery_tab.dart';
import 'package:admin_battery/widgets/tab_item.dart';
import 'package:flutter/material.dart';

import 'add_brand_screen.dart';

class HomeScreen extends StatelessWidget {
  static const String routeName = '/home';

  static Route route() {
    return PageRouteBuilder(
        settings: RouteSettings(name: routeName),
        transitionDuration: const Duration(seconds: 0),
        pageBuilder: (context, _, __) {
          return HomeScreen();
        });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => AddBrandScreen(),
              ),
            );
          },
          child: Icon(Icons.add),
        ),
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Color.fromRGBO(0, 141, 82, 1),
          title: Text('Admin Panel'),
          bottom: TabBar(
            tabs: [
              TabItem(label: 'Battery', icon: Icons.battery_full),
              TabItem(label: 'Inverter', icon: Icons.today_sharp),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            const BatteryTab(),
            const Center(child: Text('N/A')),
            //InveterTab(),
          ],
        ),
      ),
    );
  }
}
