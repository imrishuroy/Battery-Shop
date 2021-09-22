import '/config/paths.dart';
import '/enums/enums.dart';
import '/repositories/battery/battery_repository.dart';
import '/repositories/rest-apis/rest_apis_repo.dart';
import '/screens/amaron/bloc/amaron_bloc.dart';
import '/screens/set-priority/set_battery_priority.dart';
import '/screens/exide/bloc/exide_bloc.dart';
import '/screens/remote-battery/remote_amaron_tab.dart';
import '/screens/remote-battery/remote_exide_batteries.dart';
import '/screens/remote-battery/remote_sky_tab.dart';
import '/screens/sky/bloc/sky_bloc.dart';
import '/widgets/tab_item.dart';
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
