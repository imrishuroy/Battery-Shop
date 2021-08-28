import 'package:admin_battery/screens/amaron/bloc/amaron_bloc.dart';

import 'package:admin_battery/screens/battery/battery_table.dart';
import 'package:admin_battery/screens/battery/select_battery_tabel.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RemoteAmaronTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton:
          FloatingActionButton(onPressed: () {}, child: Icon(Icons.check)),
      // floatingActionButton: UploadToDatabaseButton(
      //   batteries: context.read<AmaronBloc>().state.batteries,
      //   collectionName: Paths.amaron,
      // ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 10.0, top: 10.0),
                child: IconButton(
                  onPressed: () {
                    BlocProvider.of<AmaronBloc>(context)
                        .add(RefreshAmaronBatteries());
                  },
                  icon: Icon(
                    Icons.refresh,
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: BlocConsumer<AmaronBloc, AmaronState>(
              listener: (context, state) {
                print('State of Amaron tab ${state.status}');
              },
              builder: (context, state) {
                switch (state.status) {
                  case AmaronStatus.error:
                    return Center(
                      child: Text('Something went wrong'),
                    );
                  case AmaronStatus.loaded:
                    return BatteryTable(batteries: state.batteries);
                  //  return SelectBatteryTable(batteries: state.batteries, vehicleBrandId: vehicleBrandId, fuelType: fuelType, vehicleId: vehicleId)

                  //  return AmaronTable(amaronBatteries: state.batteries);

                  default:
                    return Center(child: CircularProgressIndicator());
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
