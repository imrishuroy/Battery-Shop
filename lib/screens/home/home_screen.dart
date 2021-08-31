import 'package:admin_battery/screens/battery/battery_dashboard.dart';
import 'package:admin_battery/screens/vehicle-brands/vehicle_brands_tab.dart';
import 'package:admin_battery/widgets/tab_item.dart';
import 'package:flutter/material.dart';

import 'add_vehicle_brand_screen.dart';

class HomeScreen extends StatelessWidget {
  static const String routeName = '/home';

  static Route route() {
    return PageRouteBuilder(
      settings: RouteSettings(name: routeName),
      transitionDuration: const Duration(seconds: 0),
      pageBuilder: (context, _, __) {
        return HomeScreen();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => AddVehicleBrandScreen(),
                ),
              );
            },
            child: const Icon(Icons.add),
          ),
          appBar: AppBar(
            automaticallyImplyLeading: false,
            centerTitle: true,
            // backgroundColor: Color.fromRGBO(0, 141, 82, 1),
            title: const Text('Admin Panel'),
            bottom: TabBar(
              indicatorColor: Colors.white,
              tabs: [
                const TabItem(label: 'Battery', icon: Icons.battery_full),
                const TabItem(label: 'Inverter', icon: Icons.today_sharp),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(BatteryDashBoard.routeName);
                },
                child: const Text(
                  'Battery DashBoard',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 17.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(width: 10.0),
            ],
          ),
          body: TabBarView(
            children: [
              const VehicleBrandsTab(),
              const Center(child: Text('N/A')),
            ],
          ),
        ),
      ),
    );
  }
}
