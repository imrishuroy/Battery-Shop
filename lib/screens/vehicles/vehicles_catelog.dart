import '/config/paths.dart';
import '/screens/vehicles/widgets/four_wheeler.dart';
import '/screens/vehicles/widgets/heavy_vehicles.dart';

import '/screens/vehicles/widgets/two_wheeler.dart';
import '/models/vehicle_type.dart';
import '/repository/services/firebase_service.dart';
import '/screens/vehicles/bloc/vehicles_bloc_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VehiclesCatelogArgs {
  const VehiclesCatelogArgs({
    required this.vehilceBrandId,
    required this.fuelType,
  });

  final String? vehilceBrandId;
  final FuelType fuelType;
}

class VehiclesCatelog extends StatelessWidget {
  const VehiclesCatelog({
    Key? key,
    required this.vehicleBrandId,
    required this.fuelType,
  }) : super(key: key);

  static const String routeName = 'vehicle-screen';

  final String? vehicleBrandId;
  final FuelType? fuelType;

  // static Route<dynamic> route({required VehiclesCatelogArgs? args}) {
  //   return MaterialPageRoute<dynamic>(
  //     settings: const RouteSettings(name: routeName),
  //     builder: (BuildContext context) => BlocProvider<VehiclesBloc>(
  //       create: (BuildContext context) => VehiclesBloc(
  //         firebaseServices: context.read<FirebaseServices>(),
  //         vehicleBrandId: args?.vehilceBrandId,
  //         fuelType: args!.fuelType,
  //       ),
  //       child: VehiclesCatelog(
  //         vehicleBrandId: args?.vehilceBrandId,
  //         fuelType: args?.fuelType,
  //       ),
  //     ),
  //   );
  // }

  static Route<dynamic> route({required VehiclesCatelogArgs? args}) {
    return MaterialPageRoute<dynamic>(
      settings: const RouteSettings(name: routeName),
      builder: (BuildContext context) => VehiclesCatelog(
        vehicleBrandId: args?.vehilceBrandId,
        fuelType: args?.fuelType,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            'Vahicles Catelog',
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
              Text('2 Wheeler'),
              Text('4 Wheeler'),
              Text('Heavy Vehicles'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            BlocProvider<VehiclesBloc>(
              create: (context) => VehiclesBloc(
                firebaseServices: context.read<FirebaseServices>(),
                vehicleBrandId: vehicleBrandId,
                fuelType: fuelType!,
                vehicleType: Paths.twoWheeler,
              ),
              child: TwoWheeler(
                  vehicleBrandId: vehicleBrandId, fuelType: fuelType),
            ),
            BlocProvider<VehiclesBloc>(
              create: (context) => VehiclesBloc(
                firebaseServices: context.read<FirebaseServices>(),
                vehicleBrandId: vehicleBrandId,
                fuelType: fuelType!,
                vehicleType: Paths.foutWheeler,
              ),
              child: FourWheeler(
                  vehicleBrandId: vehicleBrandId, fuelType: fuelType),
            ),
            BlocProvider<VehiclesBloc>(
              create: (context) => VehiclesBloc(
                firebaseServices: context.read<FirebaseServices>(),
                vehicleBrandId: vehicleBrandId,
                fuelType: fuelType!,
                vehicleType: Paths.heavyVehicles,
              ),
              child: HeavyVehicles(
                  vehicleBrandId: vehicleBrandId, fuelType: fuelType),
            )
          ],
        ),
      ),
    );
  }
}
