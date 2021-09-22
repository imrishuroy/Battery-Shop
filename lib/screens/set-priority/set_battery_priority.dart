import '/enums/enums.dart';

import '/repositories/battery/battery_repository.dart';

import '/screens/set-priority/battery_priority_tile.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/set_priority_bloc.dart';

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
        return BlocProvider<SetPriorityBloc>(
          create: (context) => SetPriorityBloc(
              vehicleBrandId: args?.vehicleBrandId,
              fuelType: args!.fuelType!,
              vehicleId: args.vehicleId,
              batteryRepository: context.read<BatteryRepository>()),
          child: SetBatteryPriority(
            vehicleBrandId: args?.vehicleBrandId,
            fuelType: args?.fuelType,
            vehicleId: args?.vehicleId,
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    //final _batteryRepo = context.read<BatteryRepository>();
    print('VehicleBrand Id $vehicleBrandId');
    print('FuelType ${fuelType?.index}');
    print('Vehicle Id $vehicleId');
    return Scaffold(
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () async {
      //     await _batteryRepo.editBatteryPriority(
      //       vehicleBrandId: vehicleBrandId,
      //       fuelType: fuelType,
      //       vehicleId: vehicleId,
      //       //  battery: event.oldIndex,
      //       type: '12BOSS2.5L-C',
      //       priority: 1,
      //     );
      //   },
      //   child: Icon(Icons.ad_units),
      // ),
      appBar: AppBar(
        centerTitle: true,
        title: Text('Set Priorities'),
      ),
      body: Column(
        children: [
          Expanded(
            child: BlocConsumer<SetPriorityBloc, SetPriorityState>(
              listener: (context, state) {},
              builder: (context, state) {
                switch (state.status) {
                  case PriortyStatus.error:
                    return Center(child: Text('Something went wrong'));

                  case PriortyStatus.succuss:
                    if (state.batteries.isEmpty)
                      return Center(
                        child: Text('No Battery Added'),
                      );
                    return ListView.builder(
                      itemCount: state.batteries.length,
                      itemBuilder: (context, index) {
                        final vehicleBattery = state.batteries[index];
                        // return BatteryTile(battery: battery);
                        // return PriorityTile(
                        //   battery: battery,
                        //   fuelType: fuelType,
                        //   vehicleBrandId: vehicleBrandId,
                        //   vehicleId: vehicleId,
                        // );
                        return BatteryPriorityTile(
                          vehicleBattery: vehicleBattery,
                          vehicleBrandId: vehicleBrandId,
                          vehicleId: vehicleId,
                          fuelType: fuelType,
                        );
                      },
                    );

                  // return ReorderableListView.builder(
                  //   itemCount: state.batteries.length,
                  //   onReorder: (int oldIndex, int newIndex) async {
                  //     print('List length ${state.batteries.length}');
                  //     print('Old Index $oldIndex');
                  //     print('New Index $newIndex');
                  //     int priority = newIndex + 1;
                  //     final oldBattery = state.batteries[oldIndex];
                  //     final newBattery = state.batteries[newIndex];

                  //     print('Battery 1 Type ${oldBattery?.type}');
                  //     print('Battery 2 Type ${newBattery?.type}');
                  // await _batteryRepo.editBatteryPriority(
                  //   vehicleBrandId: vehicleBrandId,
                  //   fuelType: fuelType,
                  //   vehicleId: vehicleId,
                  //   //  battery: event.oldIndex,
                  //   type: oldBattery?.type,
                  //   priority: priority,
                  // );
                  // await _batteryRepo.editBatteryPriority(
                  //   vehicleBrandId: vehicleBrandId,
                  //   fuelType: fuelType,
                  //   vehicleId: vehicleId,
                  //   //  battery: event.oldIndex,
                  //   type: newBattery?.type,
                  //   priority: oldIndex,
                  // );

                  // context.read<SetPriorityBloc>().add(
                  //       UpdateBatteryPriority(
                  //         oldIndex: oldIndex,
                  //         newIndex: newIndex,
                  //         type2: oldBattery?.type,
                  //         type1: newBattery?.type,
                  //       ),
                  //     );

                  // context.read<SetPriorityBloc>().add(
                  //       UpdateBatteryPriority(
                  //         oldIndex:
                  //             oldBattery?.copyWith(priority: oldIndex),
                  //         newIndex:
                  //             newBattery?.copyWith(priority: newIndex),
                  //       ),
                  //     );
                  //   },
                  //   itemBuilder: (context, index) {
                  //     final battery = state.batteries[index];
                  //     return BatteryTile(
                  //         key: Key(battery!.type!), battery: battery);
                  //   },
                  // );

                  default:
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
