import '/widgets/loading_indicator.dart';

import '/config/paths.dart';
import '/repositories/vehicles/vehicle_repository.dart';
import '/screens/remote-battery/remote-battery_screen.dart';
import '/services/services.dart';
import '/vehicles-catelog/add_vehicle_to_brand.dart';
import '/vehicles-catelog/bloc/vehicles_bloc.dart';
import '/widgets/show_message.dart';
import '/enums/enums.dart';

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import '/models/vehicle.dart';

class FourWheeler extends StatelessWidget {
  const FourWheeler({
    Key? key,
    required this.vehicleBrandId,
    required this.fuelType,
  }) : super(key: key);

  final String? vehicleBrandId;
  final FuelType fuelType;

  Future<void> _deleteVehicle(
    BuildContext context, {
    required String? vehicleId,
  }) async {
    try {
      final result = await Services.askToAction(context,
          title: 'Delete', content: 'Do you want to delete this vehicle ?');
      if (result) {
        final vehicleRepo = context.read<VehicleRepository>();
        await vehicleRepo.deleteVehicle(
          vehicleBrandId: vehicleBrandId,
          vehicleType: Paths.fourWheeler,
          fuelType: fuelType,
          vehicleId: vehicleId,
        );
        ShowMessage.showSuccussMessage(context, message: 'Vehicle Deleted');
      }
    } catch (error) {
      print('Error deleting vehicle ${error.toString()}');
      ShowMessage.showErrorMessage(context, message: error.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            PageRouteBuilder(
              pageBuilder: (context, _, __) => AddVehicleToBrand(
                vehicleBrandId: vehicleBrandId,
                fuelType: fuelType,
                vehilceType: Paths.fourWheeler,
              ),
            ),
          );
        },
        child: Icon(Icons.add),
      ),
      body: Column(
        children: [
          Expanded(
            child: BlocConsumer<VehiclesBloc, VehiclesState>(
              listener: (BuildContext context, VehiclesState state) {},
              builder: (BuildContext context, VehiclesState state) {
                switch (state.status) {
                  case VehicleStatus.error:
                    return const Center(
                      child: Text('Something went wrong'),
                    );

                  case VehicleStatus.succuss:
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
                                      12.0, 6, 12.0, 0.0),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: InkWell(
                                          onTap: () {
                                            Navigator.of(context).pushNamed(
                                              RemoteBatteryScreen.routeName,
                                              arguments: RemoteBatteryArguments(
                                                vehicleBrandId: vehicleBrandId,
                                                fuelType: fuelType,
                                                vehicleId: vehicle?.vehicleId,
                                                vehicleType: Paths.fourWheeler,
                                              ),
                                            );
                                          },
                                          child: Card(
                                            child: Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
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
                                            ),
                                          ),
                                        ),
                                      ),
                                      IconButton(
                                        onPressed: () => _deleteVehicle(
                                          context,
                                          vehicleId: vehicle?.vehicleId,
                                        ),
                                        icon: Icon(
                                          Icons.delete,
                                          color: Colors.red,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    );

                  default:
                    return const LoadingIndicator();
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
