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
            child: Icon(Icons.add),
          ),
          appBar: AppBar(
            automaticallyImplyLeading: false,
            centerTitle: true,
            // backgroundColor: Color.fromRGBO(0, 141, 82, 1),
            title: Text('Admin Panel'),
            bottom: TabBar(
              indicatorColor: Colors.white,
              tabs: [
                TabItem(label: 'Battery', icon: Icons.battery_full),
                TabItem(label: 'Inverter', icon: Icons.today_sharp),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              const VehicleBrandsTab(),
              //    const BatteryTab(),
              const Center(child: Text('N/A')),
              //InveterTab(),
            ],
          ),
        ),
      ),
    );
  }
}
