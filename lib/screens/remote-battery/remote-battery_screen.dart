import '/screens/alfa/bloc/alfa_bloc.dart';
import '/screens/livfast/bloc/livfast_bloc.dart';
import '/screens/luminous/bloc/luminous_bloc.dart';
import '/screens/remote-battery/remote_livfast_tab.dart';

import '/config/paths.dart';
import '/enums/enums.dart';
import '/repositories/battery/battery_repository.dart';

import '/screens/amaron/bloc/amaron_bloc.dart';
import '/screens/set-priority/set_battery_priority.dart';
import '/screens/exide/bloc/exide_bloc.dart';
import '/screens/remote-battery/remote_amaron_tab.dart';
import 'remote_alfa_tab.dart';
import 'remote_exide_tab.dart';
import '/screens/remote-battery/remote_sky_tab.dart';
import '/screens/sky/bloc/sky_bloc.dart';
import '/widgets/tab_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'remote_luminous_tab.dart';

class RemoteBatteryArguments {
  final String? vehicleBrandId;
  final FuelType fuelType;
  final String? vehicleId;
  final String vehicleType;

  const RemoteBatteryArguments({
    required this.vehicleBrandId,
    required this.fuelType,
    required this.vehicleId,
    required this.vehicleType,
  });
}

class RemoteBatteryScreen extends StatelessWidget {
  final String? vehicleBrandId;
  final FuelType? fuelType;
  final String? vehicleId;
  final String vehicleType;

  static const String routeName = '/remote-battery';

  const RemoteBatteryScreen({
    Key? key,
    required this.vehicleBrandId,
    required this.fuelType,
    required this.vehicleId,
    required this.vehicleType,
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
                repository: context.read<BatteryRepository>(),
              ),
            ),
            BlocProvider<ExideBloc>(
              create: (context) => ExideBloc(
                path: Paths.exide,
                repository: context.read<BatteryRepository>(),
              ),
            ),
            BlocProvider<AlfaBloc>(
              create: (context) => AlfaBloc(
                path: Paths.alfa,
                repository: context.read<BatteryRepository>(),
              ),
            ),
            BlocProvider<LuminousBloc>(
              create: (context) => LuminousBloc(
                path: Paths.luminous,
                repository: context.read<BatteryRepository>(),
              ),
            ),
            BlocProvider<LivFastBloc>(
              create: (context) => LivFastBloc(
                path: Paths.livFast,
                repository: context.read<BatteryRepository>(),
              ),
            ),
          ],
          child: RemoteBatteryScreen(
            vehicleBrandId: args?.vehicleBrandId,
            vehicleId: args?.vehicleId,
            fuelType: args?.fuelType,
            vehicleType: args!.vehicleType,
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 6,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Batteries'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pushNamed(
                  SetBatteryPriority.routeName,
                  arguments: BatteryPriorityArgs(
                    vehicleBrandId: vehicleBrandId,
                    fuelType: fuelType,
                    vehicleId: vehicleId,
                    vehicleType: vehicleType,
                  ),
                );
              },
              child: Text(
                'Set Priority',
                style: TextStyle(color: Colors.white, fontSize: 17.0),
              ),
            ),
            const SizedBox(width: 10.0),
          ],
          bottom: TabBar(
            indicatorColor: Colors.white,
            tabs: [
              TabItem(label: 'Amaron', icon: Icons.today_sharp),
              TabItem(label: 'Exide', icon: Icons.today_sharp),
              TabItem(label: 'Sky', icon: Icons.today_sharp),
              TabItem(label: 'Luminous', icon: Icons.today_sharp),
              TabItem(label: 'Alfa', icon: Icons.today_sharp),
              TabItem(label: 'LivFast', icon: Icons.today_sharp),
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
              vehilceType: vehicleType,
            ),
            RemoteExideTab(
              vehicleBrandId: vehicleBrandId,
              fuelType: fuelType ?? FuelType.petrol,
              vehicleId: vehicleId,
              vehicleType: vehicleType,
            ),
            RemoteSkyTab(
              vehicleBrandId: vehicleBrandId,
              fuelType: FuelType.petrol,
              vehicleId: vehicleId,
              vehicleType: vehicleType,
            ),

            RemoteLuminousTab(
              vehicleBrandId: vehicleBrandId,
              fuelType: FuelType.petrol,
              vehicleId: vehicleId,
              vehicleType: vehicleType,
            ),

            RemoteAlfaTab(
              vehicleBrandId: vehicleBrandId,
              fuelType: FuelType.petrol,
              vehicleId: vehicleId,
              vehilceType: vehicleType,
            ),
            RemoteLivFastTab(
              vehicleBrandId: vehicleBrandId,
              fuelType: FuelType.petrol,
              vehicleId: vehicleId,
              vehicleType: vehicleType,
            ),
          ],
        ),
      ),
    );
  }
}
