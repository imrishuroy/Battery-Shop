import '/widgets/display_image.dart';

import '/config/paths.dart';

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import '/models/vehicle.dart';
import '/models/vehicle_type.dart';

import '/screens/battery/battery_req_screen.dart';
import '/screens/vehicles/bloc/vehicles_bloc_bloc.dart';

class HeavyVehicles extends StatelessWidget {
  const HeavyVehicles({
    Key? key,
    required this.vehicleBrandId,
    required this.fuelType,
  }) : super(key: key);

  final String? vehicleBrandId;
  final FuelType? fuelType;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: BlocConsumer<VehiclesBloc, VehiclesBlocState>(
            listener: (BuildContext context, VehiclesBlocState state) {},
            builder: (BuildContext context, VehiclesBlocState state) {
              switch (state.status) {
                case VehiclesBlocStatus.error:
                  return const Center(
                    child: Text('Something went wrong'),
                  );

                case VehiclesBlocStatus.succuss:
                  final List<Vehicle?> vehicles = state.vehicles;

                  if (vehicles.isEmpty) {
                    return const Center(child: Text('No Data Found :('));
                  }

                  return AnimationLimiter(
                    child: ListView.builder(
                      itemCount: vehicles.length,
                      itemBuilder: (BuildContext context, int index) {
                        final Vehicle? vehicle = vehicles[index];
                        return AnimationConfiguration.staggeredList(
                          position: index,
                          duration: const Duration(milliseconds: 375),
                          child: SlideAnimation(
                            verticalOffset: 50.0,
                            child: FadeInAnimation(
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(
                                  12.0,
                                  6,
                                  12.0,
                                  0.0,
                                ),
                                child: InkWell(
                                  onTap: () {
                                    Navigator.of(context).pushNamed(
                                      BatteryRequiredScreen.routeName,
                                      arguments: BatteryRequiredArgs(
                                        vehicleBrandId: vehicleBrandId,
                                        fuelType: fuelType!,
                                        vehicleId: vehicle?.vehicleId,
                                        vehicleType: Paths.heavyVehicles,
                                      ),
                                    );
                                  },
                                  child: Card(
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 10.0,
                                        vertical: 10.0,
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          SizedBox(
                                            width: 190.0,
                                            //height: 50.0,
                                            child: Text(
                                              '${vehicle?.name}',
                                              style: const TextStyle(
                                                fontSize: 17.0,
                                                letterSpacing: 1.0,
                                                // fontWeight: FontWeight.w500,
                                              ),
                                              maxLines: 3,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 65.0,
                                            width: 100.0,
                                            child: DisplayImage(
                                              imageUrl: vehicle?.imageUrl,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  );

                default:
                  return const Center(child: CircularProgressIndicator());
              }
            },
          ),
        ),
      ],
    );
  }
}
