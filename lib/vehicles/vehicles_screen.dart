import 'package:admin_battery/enums/enums.dart';
import 'package:admin_battery/screens/battery/battery_dashboard.dart';
import 'package:admin_battery/screens/remote-battery/remote-battery_screen.dart';
import 'package:admin_battery/vehicles/add_vehicle_to_brand.dart';
import 'package:admin_battery/vehicles/bloc/vehicles_bloc.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class VehiclesScreen extends StatelessWidget {
  final String? vehicleBrandId;
  final FuelType fuelType;

  const VehiclesScreen({
    Key? key,
    required this.vehicleBrandId,
    required this.fuelType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('Fule Type $fuelType');
    print('Vehicle Brand Id $vehicleBrandId');
    return BlocConsumer<VehiclesBloc, VehiclesState>(
      listener: (context, state) {},
      builder: (context, state) {
        switch (state.status) {
          case VehicleStatus.error:
            return Scaffold(
              body: Center(
                child: Text('Something went wrong :('),
              ),
            );

          case VehicleStatus.succuss:
            return Scaffold(
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  Navigator.of(context).push(
                    PageRouteBuilder(
                        pageBuilder: (context, _, __) => AddVehicleToBrand(
                            vehicleBrandId: vehicleBrandId,
                            fuelType: fuelType)),
                  );
                },
                child: Icon(Icons.add),
              ),
              appBar: AppBar(
                centerTitle: true,
                title: const Text(
                  'Vehicles Catelog',
                  style: TextStyle(
                    letterSpacing: 1.2,
                  ),
                ),
              ),
              body: Column(
                children: [
                  state.vehicles.length == 0
                      ? Center(
                          child: Text(
                            'No Vehicles Added :(',
                            style: TextStyle(
                              fontSize: 17.0,
                              letterSpacing: 1.2,
                            ),
                          ),
                        )
                      : Expanded(
                          child: AnimationLimiter(
                            child: ListView.builder(
                              itemCount: state.vehicles.length,
                              itemBuilder: (context, index) {
                                final vehicle = state.vehicles[index];
                                return AnimationConfiguration.staggeredList(
                                  position: index,
                                  duration: const Duration(milliseconds: 375),
                                  child: SlideAnimation(
                                    verticalOffset: 50.0,
                                    child: FadeInAnimation(
                                      child: Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            12.0, 6, 12.0, 0.0),
                                        child: InkWell(
                                          onTap: () {
                                            Navigator.of(context).pushNamed(
                                              RemoteBatteryScreen.routeName,
                                              arguments: RemoteBatteryArguments(
                                                vehicleBrandId: vehicleBrandId,
                                                fuelType: fuelType,
                                                vehicleId: vehicle?.vehicleId,
                                              ),
                                            );
                                            // Navigator.of(context).pushNamed(
                                            //     BatteryDashBoard.routeName);

                                            // Navigator.of(context).push(
                                            //   MaterialPageRoute(
                                            //     builder: (context) =>
                                            //         BatteryRequiredScreen(
                                            //       vehicleBrandId:
                                            //           vehicleBrandId,
                                            //       fuelType: fuelType,
                                            //       vehicleId: vehicle?.vehicleId,
                                            //     ),
                                            //   ),
                                            // );
                                          },
                                          child: Card(
                                              child: Container(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 10.0,
                                              vertical: 10.0,
                                            ),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Container(
                                                  width: 190.0,
                                                  //height: 50.0,
                                                  child: Text(
                                                    '${vehicle?.name ?? 'N/A'}',
                                                    style: TextStyle(
                                                      fontSize: 17.0,
                                                      letterSpacing: 1.0,
                                                      // fontWeight: FontWeight.w500,
                                                    ),
                                                    maxLines: 3,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ),
                                                Container(
                                                  height: 65.0,
                                                  width: 100.0,
                                                  child: Image.network(
                                                    vehicle?.imageUrl ?? '',
                                                    fit: BoxFit.contain,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                ],
              ),
            );

          default:
            return Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
        }
      },
    );
  }
}
