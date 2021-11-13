import '/screens/alfa/bloc/alfa_bloc.dart';

import '/widgets/loading_indicator.dart';

import '/blocs/vehicle-blocs/vehicle_batteries_bloc.dart';
import '/config/paths.dart';
import '/enums/enums.dart';
import '/repositories/battery/battery_repository.dart';
import '/screens/battery/select_battery_tabel.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RemoteAlfaTab extends StatelessWidget {
  final String? vehicleBrandId;
  final FuelType fuelType;
  final String? vehicleId;
  final String vehilceType;

  const RemoteAlfaTab({
    Key? key,
    required this.vehicleBrandId,
    required this.fuelType,
    required this.vehicleId,
    required this.vehilceType,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AlfaBloc, AlfaState>(
      listener: (context, state) {},
      builder: (context, state) {
        switch (state.status) {
          case AlfaStatus.error:
            return Center(
              child: Text('Something went wrong'),
            );

          case AlfaStatus.loaded:
            return BlocProvider(
              create: (context) => VehicleBatteriesBloc(
                batteryRepository: context.read<BatteryRepository>(),
                vehicleBrandId: vehicleBrandId,
                fuelType: fuelType,
                vehicleId: vehicleId,
                batteryBrand: Paths.alfa,
                vehicleType: vehilceType,
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
                            BlocProvider.of<AlfaBloc>(context)
                                .add(RefreshAlfaBatteries());
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
            return LoadingIndicator();
        }
      },
    );
  }
}
