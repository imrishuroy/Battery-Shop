import 'package:admin_battery/enums/enums.dart';
import 'package:admin_battery/models/battery.dart';
import 'package:admin_battery/repositories/battery/battery_repository.dart';
import 'package:admin_battery/screens/battery/battery_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BatteryPriorityArgs {
  final String? vehicleBrandId;
  final FuelType? fuelType;
  final String? vehicleId;

  BatteryPriorityArgs(
      {required this.vehicleBrandId,
      required this.fuelType,
      required this.vehicleId});
}

class SetBatteryPriority extends StatelessWidget {
  static const String routeName = 'set-priority';

  final String? vehicleBrandId;
  final FuelType? fuelType;
  final String? vehicleId;

  const SetBatteryPriority({
    Key? key,
    required this.vehicleBrandId,
    required this.fuelType,
    required this.vehicleId,
  }) : super(key: key);

  static Route route({required BatteryPriorityArgs? args}) {
    return PageRouteBuilder(
      settings: RouteSettings(name: routeName),
      pageBuilder: (context, _, __) {
        return SetBatteryPriority(
          vehicleBrandId: args?.vehicleBrandId,
          fuelType: args?.fuelType,
          vehicleId: args?.vehicleId,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final _batteryRepo = context.read<BatteryRepository>();
    print('VehicleBrand Id $vehicleBrandId');
    print('FuelType ${fuelType?.index}');
    print('Vehicle Id $vehicleId');
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Set Priorities'),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<List<Future<Battery?>>>(
              stream: _batteryRepo.streamVehiclesBatteries(
                  vehicleBrandId: vehicleBrandId,
                  fuelType: fuelType!,
                  vehicleId: vehicleId),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }

                return ListView.builder(
                  itemCount: snapshot.data?.length,
                  itemBuilder: (context, index) {
                    final battery = snapshot.data?[index];
                    return FutureBuilder<Battery?>(
                        future: battery,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          final battery = snapshot.data;
                          return BatteryTile(battery: battery);
                        });
                  },
                );
              },
            ),
          ),
          // Expanded(
          //   child: FutureBuilder<List<Battery?>>(
          //     future: _batteryRepo.getVehicleBatteries(
          //       vehicleBrandId: vehicleBrandId,
          //       fuelType: fuelType,
          //       vehicleId: vehicleId,
          //     ),
          //     builder: (context, snapshot) {
          //       if (snapshot.connectionState == ConnectionState.waiting) {
          //         return Center(
          //           child: CircularProgressIndicator(),
          //         );
          //       }
          //       print('Snapshot data ${snapshot.data}');
          //       return ListView.builder(
          //         itemCount: snapshot.data?.length,
          //         itemBuilder: (context, index) {
          //           final battery = snapshot.data?[index];
          //           return Text('${battery?.mrp}');
          //         },
          //       );
          //     },
          //   ),
          // )
        ],
      ),
    );
  }
}
