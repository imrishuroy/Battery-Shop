import 'package:battery_shop/models/vehicle_type.dart';
import 'package:battery_shop/repository/services/firebase_service.dart';
import 'package:battery_shop/screens/battery/battery_req_screen.dart';
import 'package:battery_shop/screens/vehicles/bloc/vehicles_bloc_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class VehiclesScreenArgs {
  final String? vehilceBrandId;
  final FuelType fuelType;

  const VehiclesScreenArgs({
    required this.vehilceBrandId,
    required this.fuelType,
  });
}

class VehiclesScreen extends StatelessWidget {
  static const String routeName = 'vehicle-screen';

  final String? vehicleBrandId;
  final FuelType? fuelType;

  static Route route({required VehiclesScreenArgs? args}) {
    return MaterialPageRoute(
      settings: RouteSettings(name: routeName),
      builder: (context) => BlocProvider(
        create: (context) => VehiclesBlocBloc(
          firebaseServices: context.read<FirebaseServices>(),
          vehicleBrandId: args?.vehilceBrandId,
          fuelType: args!.fuelType,
        ),
        child: VehiclesScreen(
          vehicleBrandId: args?.vehilceBrandId,
          fuelType: args?.fuelType,
        ),
      ),
    );
  }

  const VehiclesScreen({
    Key? key,
    required this.vehicleBrandId,
    required this.fuelType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Vahicles Catelog',
          style: TextStyle(
            letterSpacing: 1.2,
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: BlocConsumer<VehiclesBlocBloc, VehiclesBlocState>(
              listener: (context, state) {},
              builder: (context, state) {
                switch (state.status) {
                  case VehiclesBlocStatus.error:
                    return const Center(
                      child: Text('Something went wrong'),
                    );

                  case VehiclesBlocStatus.succuss:
                    final vehicles = state.vehicles;

                    if (vehicles.isEmpty) {
                      return Center(child: const Text('No Data Found :('));
                    }

                    return AnimationLimiter(
                      child: ListView.builder(
                        itemCount: vehicles.length,
                        itemBuilder: (context, index) {
                          final vehicle = vehicles[index];
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
                                        BatteryRequiredScreen.routeName,
                                        arguments: BatteryRequiredArgs(
                                          vehicleBrandId: vehicleBrandId,
                                          fuelType: fuelType!,
                                          vehicleId: vehicle?.vehicleId,
                                        ),
                                      );
                                      // Navigator.of(context).push(
                                      //   MaterialPageRoute(
                                      //     builder: (context) =>
                                      //         BatteryRequiredScreen(),
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
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            width: 190.0,
                                            //height: 50.0,
                                            child: Text(
                                              '${vehicle?.name}',
                                              style: TextStyle(
                                                fontSize: 17.0,
                                                letterSpacing: 1.0,
                                                // fontWeight: FontWeight.w500,
                                              ),
                                              maxLines: 3,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                          Container(
                                            height: 65.0,
                                            width: 100.0,
                                            child: CachedNetworkImage(
                                              imageUrl: vehicle?.imageUrl ?? '',
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
                    );

                  default:
                    return Center(child: CircularProgressIndicator());
                }
              },
            ),
          ),

          // Expanded(
          //     child: FutureBuilder<List<Vehicle?>>(
          //   future: _services.getVehiclesAssociatedWithBrands(
          //       vehicleBrandId: vehicleBrandId, fuelType: fuelType!),
          //   builder: (context, snapshot) {
          //     return AnimationLimiter(
          //       child: ListView.builder(
          //         itemCount: snapshot.data?.length,
          //         itemBuilder: (context, index) {
          //           final vehicle = snapshot.data?[index];
          //           return AnimationConfiguration.staggeredList(
          //             position: index,
          //             duration: const Duration(milliseconds: 375),
          //             child: SlideAnimation(
          //               verticalOffset: 50.0,
          //               child: FadeInAnimation(
          //                 child: Padding(
          //                   padding:
          //                       const EdgeInsets.fromLTRB(12.0, 6, 12.0, 0.0),
          //                   child: InkWell(
          //                     onTap: () {
          //                       Navigator.of(context).push(
          //                         MaterialPageRoute(
          //                           builder: (context) =>
          //                               BatteryRequiredScreen(),
          //                         ),
          //                       );
          //                     },
          //                     child: Card(
          //                         child: Container(
          //                       padding: const EdgeInsets.symmetric(
          //                         horizontal: 10.0,
          //                         vertical: 10.0,
          //                       ),
          //                       child: Row(
          //                         mainAxisAlignment:
          //                             MainAxisAlignment.spaceBetween,
          //                         children: [
          //                           Container(
          //                             width: 190.0,
          //                             //height: 50.0,
          //                             child: Text(
          //                               '${vehicle?.name}',
          //                               style: TextStyle(
          //                                 fontSize: 17.0,
          //                                 letterSpacing: 1.0,
          //                                 // fontWeight: FontWeight.w500,
          //                               ),
          //                               maxLines: 3,
          //                               overflow: TextOverflow.ellipsis,
          //                             ),
          //                           ),
          //                           Container(
          //                             height: 65.0,
          //                             width: 100.0,
          //                             child: CachedNetworkImage(
          //                               imageUrl: vehicle?.imageUrl ?? '',
          //                               fit: BoxFit.contain,
          //                             ),
          //                           ),
          //                         ],
          //                       ),
          //                     )),
          //                   ),
          //                 ),
          //               ),
          //             ),
          //           );
          //         },
          //       ),
          //     );
          //   },
          // )),

          // Expanded(
          //   child: AnimationLimiter(
          //     child: ListView.builder(
          //       itemCount: vehicles.length,
          //       itemBuilder: (context, index) {
          //         final vehicle = vehicles[index];
          //         return AnimationConfiguration.staggeredList(
          //           position: index,
          //           duration: const Duration(milliseconds: 375),
          //           child: SlideAnimation(
          //             verticalOffset: 50.0,
          //             child: FadeInAnimation(
          //               child: Padding(
          //                 padding:
          //                     const EdgeInsets.fromLTRB(12.0, 6, 12.0, 0.0),
          //                 child: InkWell(
          //                   onTap: () {
          //                     Navigator.of(context).push(
          //                       MaterialPageRoute(
          //                         builder: (context) => BatteryRequiredScreen(),
          //                       ),
          //                     );
          //                   },
          //                   child: Card(
          //                       child: Container(
          //                     padding: const EdgeInsets.symmetric(
          //                       horizontal: 10.0,
          //                       vertical: 10.0,
          //                     ),
          //                     child: Row(
          //                       mainAxisAlignment:
          //                           MainAxisAlignment.spaceBetween,
          //                       children: [
          //                         Container(
          //                           width: 190.0,
          //                           //height: 50.0,
          //                           child: Text(
          //                             '${vehicle.name}',
          //                             style: TextStyle(
          //                               fontSize: 17.0,
          //                               letterSpacing: 1.0,
          //                               // fontWeight: FontWeight.w500,
          //                             ),
          //                             maxLines: 3,
          //                             overflow: TextOverflow.ellipsis,
          //                           ),
          //                         ),
          //                         Container(
          //                           height: 65.0,
          //                           width: 100.0,
          //                           child: CachedNetworkImage(
          //                             imageUrl: vehicle.imageUrl ?? '',
          //                             fit: BoxFit.contain,
          //                           ),
          //                         ),
          //                       ],
          //                     ),
          //                   )),
          //                 ),
          //               ),
          //             ),
          //           ),
          //         );
          //       },
          //     ),
          //   ),
          // )
        ],
      ),
    );
  }
}
