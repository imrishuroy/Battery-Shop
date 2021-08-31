import 'package:admin_battery/blocs/vehicle-blocs/vehicle_batteries_bloc.dart';
import 'package:admin_battery/config/paths.dart';
import 'package:admin_battery/enums/enums.dart';
import 'package:admin_battery/repositories/battery/battery_repository.dart';

import 'package:admin_battery/screens/battery/select_battery_tabel.dart';
import 'package:admin_battery/screens/sky/bloc/sky_bloc.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RemoteSkyTab extends StatelessWidget {
  final String? vehicleBrandId;
  final FuelType fuelType;
  final String? vehicleId;

  const RemoteSkyTab(
      {Key? key,
      required this.vehicleBrandId,
      required this.fuelType,
      required this.vehicleId})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SkyBloc, SkyState>(
      listener: (context, state) {},
      builder: (context, state) {
        switch (state.status) {
          case SkyStatus.error:
            return Center(
              child: Text('Something went wrong'),
            );

          case SkyStatus.loaded:
            return BlocProvider(
              create: (context) => VehicleBatteriesBloc(
                batteryRepository: context.read<BatteryRepository>(),
                vehicleBrandId: vehicleBrandId,
                fuelType: fuelType,
                vehicleId: vehicleId,
                batteryBrand: Paths.sky,
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
                            BlocProvider.of<SkyBloc>(context)
                                .add(RefreshSkyBatteries());
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
