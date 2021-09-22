import '/blocs/vehicle-blocs/vehicle_batteries_bloc.dart';
import '/config/paths.dart';
import '/enums/enums.dart';
import '/repositories/battery/battery_repository.dart';
import '/screens/amaron/bloc/amaron_bloc.dart';
import '/screens/battery/select_battery_tabel.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RemoteAmaronTab extends StatelessWidget {
  final String? vehicleBrandId;
  final FuelType fuelType;
  final String? vehicleId;

  const RemoteAmaronTab(
      {Key? key,
      required this.vehicleBrandId,
      required this.fuelType,
      required this.vehicleId})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AmaronBloc, AmaronState>(
      listener: (context, state) {},
      builder: (context, state) {
        switch (state.status) {
          case AmaronStatus.error:
            return Center(
              child: Text('Something went wrong'),
            );

          case AmaronStatus.loaded:
            return BlocProvider(
              create: (context) => VehicleBatteriesBloc(
                batteryRepository: context.read<BatteryRepository>(),
                vehicleBrandId: vehicleBrandId,
                fuelType: fuelType,
                vehicleId: vehicleId,
                batteryBrand: Paths.amaron,
              ),
              child: Column(
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
                    child: SelectBatteryTable(
                      batteries: state.batteries,
                      vehicleBrandId: vehicleBrandId,
                      fuelType: fuelType,
                      vehicleId: vehicleId,
                    ),
                  ),
                ],
              ),
            );

          default:
            return Center(
              child: CircularProgressIndicator(),
            );
        }
      },
    );
  }
}
