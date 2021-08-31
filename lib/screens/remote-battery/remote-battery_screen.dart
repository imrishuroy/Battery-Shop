import 'package:admin_battery/config/paths.dart';
import 'package:admin_battery/enums/enums.dart';
import 'package:admin_battery/repositories/battery/battery_repository.dart';
import 'package:admin_battery/repositories/rest-apis/rest_apis_repo.dart';
import 'package:admin_battery/screens/amaron/bloc/amaron_bloc.dart';
import 'package:admin_battery/screens/exide/bloc/exide_bloc.dart';

import 'package:admin_battery/screens/remote-battery/remote_amaron_tab.dart';
import 'package:admin_battery/screens/remote-battery/remote_exide_batteries.dart';
import 'package:admin_battery/screens/remote-battery/remote_sky_tab.dart';
import 'package:admin_battery/screens/sky/bloc/sky_bloc.dart';
import 'package:admin_battery/widgets/tab_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RemoteBatteryArguments {
  final String? vehicleBrandId;
  final FuelType fuelType;
  final String? vehicleId;

  const RemoteBatteryArguments({
    required this.vehicleBrandId,
    required this.fuelType,
    required this.vehicleId,
  });
}

class RemoteBatteryScreen extends StatelessWidget {
  final String? vehicleBrandId;
  final FuelType? fuelType;
  final String? vehicleId;

  static const String routeName = '/remote-battery';

  const RemoteBatteryScreen({
    Key? key,
    required this.vehicleBrandId,
    required this.fuelType,
    required this.vehicleId,
  }) : super(key: key);

  static Route route({required RemoteBatteryArguments? args}) {
    return PageRouteBuilder(
      settings: RouteSettings(name: routeName),
      transitionDuration: const Duration(seconds: 0),
      pageBuilder: (context, _, __) {
        return MultiBlocProvider(
          providers: [
            BlocProvider<AmaronBloc>(
              create: (context) => AmaronBloc(
                path: Paths.amaron,
                repository: context.read<BatteryRepository>(),
              ),
            ),
            BlocProvider<SkyBloc>(
              create: (context) => SkyBloc(
                path: Paths.sky,
                restApisRepository: context.read<BatteryRepository>(),
              ),
            ),
            BlocProvider<ExideBloc>(
              create: (context) => ExideBloc(
                restApisRepository: context.read<RestApisRepository>(),
              ),
            ),
          ],
          child: RemoteBatteryScreen(
            vehicleBrandId: args?.vehicleBrandId,
            vehicleId: args?.vehicleId,
            fuelType: args?.fuelType,
          ),
        );
      },
    );
  }

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
            RemoteAmaronTab(
              vehicleBrandId: vehicleBrandId,
              fuelType: fuelType ?? FuelType.petrol,
              vehicleId: vehicleId,
            ),
            RemoteExideTab(
              vehicleBrandId: vehicleBrandId,
              fuelType: fuelType ?? FuelType.petrol,
              vehicleId: vehicleId,
            ),
            RemoteSkyTab(
                vehicleBrandId: vehicleBrandId,
                fuelType: FuelType.petrol,
                vehicleId: vehicleId),
            // ExideTab(),
            //  SkyTab(),
          ],
        ),
      ),
    );
  }
}
