import '/vehicles-catelog/bloc/vehicles_bloc.dart';
import '/config/paths.dart';
import '/enums/enums.dart';
import '/repositories/firebase_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'widgets/four_wheeler.dart';
import 'widgets/heavy_vehicle.dart';
import 'widgets/two_wheeler.dart';

class VehiclesCatelog extends StatelessWidget {
  final String? vehicleBrandId;
  final FuelType fuelType;

  const VehiclesCatelog({
    Key? key,
    required this.vehicleBrandId,
    required this.fuelType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('Fule Type $fuelType');
    print('Vehicle Brand Id $vehicleBrandId');
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            'Vehicles Catelog',
            style: TextStyle(
              letterSpacing: 1.2,
            ),
          ),
          bottom: const TabBar(
            labelStyle: TextStyle(fontSize: 17.0),
            indicatorColor: Colors.white,
            indicatorWeight: 1.8,
            // controller: _tabController,
            isScrollable: true,
            tabs: [
              Text('4 Wheeler'),
              Text('Heavy Vehicles'),
              Text('2 Wheeler'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            BlocProvider<VehiclesBloc>(
              create: (context) => VehiclesBloc(
                firebaseServices: context.read<FirebaseServices>(),
                vehicleBrandId: vehicleBrandId,
                fuelType: fuelType,
                vehicleType: Paths.fourWheeler,
              ),
              child: FourWheeler(
                  vehicleBrandId: vehicleBrandId, fuelType: fuelType),
            ),
            BlocProvider<VehiclesBloc>(
              create: (context) => VehiclesBloc(
                firebaseServices: context.read<FirebaseServices>(),
                vehicleBrandId: vehicleBrandId,
                fuelType: fuelType,
                vehicleType: Paths.heavyVehicles,
              ),
              child: HeavyVehicles(
                  vehicleBrandId: vehicleBrandId, fuelType: fuelType),
            ),
            BlocProvider<VehiclesBloc>(
              create: (context) => VehiclesBloc(
                firebaseServices: context.read<FirebaseServices>(),
                vehicleBrandId: vehicleBrandId,
                fuelType: fuelType,
                vehicleType: Paths.twoWheeler,
              ),
              child: TwoWheeler(
                  vehicleBrandId: vehicleBrandId, fuelType: fuelType),
            ),
          ],
        ),
      ),
    );

    // BlocConsumer<VehiclesBloc, VehiclesState>(
    //   listener: (context, state) {},
    //   builder: (context, state) {
    //     switch (state.status) {
    //       case VehicleStatus.error:
    //         return Scaffold(
    //           body: Center(
    //             child: Text('Something went wrong :('),
    //           ),
    //         );

    //       case VehicleStatus.succuss:
    //         return Scaffold(
    //           floatingActionButton: FloatingActionButton(
    //             onPressed: () {
    //               Navigator.of(context).push(
    //                 PageRouteBuilder(
    //                   pageBuilder: (context, _, __) => AddVehicleToBrand(
    //                     vehicleBrandId: vehicleBrandId,
    //                     fuelType: fuelType,
    //                   ),
    //                 ),
    //               );
    //             },
    //             child: Icon(Icons.add),
    //           ),
    //           appBar: AppBar(
    //             centerTitle: true,
    //             title: const Text(
    //               'Vehicles Catelog',
    //               style: TextStyle(
    //                 letterSpacing: 1.2,
    //               ),
    //             ),
    //           ),
    //           body: Column(
    //             children: [
    //               state.vehicles.length == 0
    //                   ? Expanded(
    //                       child: Center(
    //                         child: Text(
    //                           'No Vehicles Added :(',
    //                           style: TextStyle(
    //                             fontSize: 17.0,
    //                             letterSpacing: 1.2,
    //                           ),
    //                         ),
    //                       ),
    //                     )
    //                   : Expanded(
    //                       child: AnimationLimiter(
    //                         child: ListView.builder(
    //                           itemCount: state.vehicles.length,
    //                           itemBuilder: (context, index) {
    //                             final vehicle = state.vehicles[index];
    //                             return AnimationConfiguration.staggeredList(
    //                               position: index,
    //                               duration: const Duration(milliseconds: 375),
    //                               child: SlideAnimation(
    //                                 verticalOffset: 50.0,
    //                                 child: FadeInAnimation(
    //                                   child: Padding(
    //                                     padding: const EdgeInsets.fromLTRB(
    //                                         12.0, 6, 12.0, 0.0),
    //                                     child: Row(
    //                                       children: [
    //                                         Expanded(
    //                                           child: InkWell(
    //                                             onTap: () {
    //                                               Navigator.of(context)
    //                                                   .pushNamed(
    //                                                 RemoteBatteryScreen
    //                                                     .routeName,
    //                                                 arguments:
    //                                                     RemoteBatteryArguments(
    //                                                   vehicleBrandId:
    //                                                       vehicleBrandId,
    //                                                   fuelType: fuelType,
    //                                                   vehicleId:
    //                                                       vehicle?.vehicleId,
    //                                                 ),
    //                                               );
    //                                             },
    //                                             child: Card(
    //                                               child: Container(
    //                                                 padding: const EdgeInsets
    //                                                     .symmetric(
    //                                                   horizontal: 10.0,
    //                                                   vertical: 10.0,
    //                                                 ),
    //                                                 child: Row(
    //                                                   mainAxisAlignment:
    //                                                       MainAxisAlignment
    //                                                           .spaceBetween,
    //                                                   children: [
    //                                                     Container(
    //                                                       width: 190.0,
    //                                                       //height: 50.0,
    //                                                       child: Text(
    //                                                         '${vehicle?.name ?? 'N/A'}',
    //                                                         style: TextStyle(
    //                                                           fontSize: 17.0,
    //                                                           letterSpacing:
    //                                                               1.0,
    //                                                           // fontWeight: FontWeight.w500,
    //                                                         ),
    //                                                         maxLines: 3,
    //                                                         overflow:
    //                                                             TextOverflow
    //                                                                 .ellipsis,
    //                                                       ),
    //                                                     ),
    //                                                     Container(
    //                                                       height: 65.0,
    //                                                       width: 100.0,
    //                                                       child: Image.network(
    //                                                         vehicle?.imageUrl ??
    //                                                             '',
    //                                                         fit: BoxFit.contain,
    //                                                       ),
    //                                                     ),
    //                                                   ],
    //                                                 ),
    //                                               ),
    //                                             ),
    //                                           ),
    //                                         ),
    //                                         IconButton(
    //                                           onPressed: () => _deleteVehicle(
    //                                             context,
    //                                             vehicleId: vehicle?.vehicleId,
    //                                           ),
    //                                           icon: Icon(
    //                                             Icons.delete,
    //                                             color: Colors.red,
    //                                           ),
    //                                         )
    //                                       ],
    //                                     ),
    //                                   ),
    //                                 ),
    //                               ),
    //                             );
    //                           },
    //                         ),
    //                       ),
    //                     ),
    //             ],
    //           ),
    //         );

    //       default:
    //         return Scaffold(
    //           body: Center(
    //             child: CircularProgressIndicator(),
    //           ),
    //         );
    //     }
    //   },
    // );
  }
}
