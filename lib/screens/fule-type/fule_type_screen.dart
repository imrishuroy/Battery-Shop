import 'package:admin_battery/enums/enums.dart';
import 'package:admin_battery/repositories/firebase_services.dart';
import 'package:admin_battery/vehicles/bloc/vehicles_bloc.dart';
import 'package:admin_battery/vehicles/vehicles_screen.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FuleTypeScreen extends StatelessWidget {
  final String? vehicleBrandId;

  const FuleTypeScreen({Key? key, required this.vehicleBrandId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Choose Your Vehicle'),
      ),
      body: Column(
        //crossAxisAlignment: CrossAxisAlignment.,
        children: [
          Spacer(),
          VehicleTypeCard(
            imageUrl: 'assets/petrol.png',
            label: 'PETROL',
            vehicleBrandId: vehicleBrandId,
            fuelType: FuelType.petrol,
          ),
          Spacer(),
          VehicleTypeCard(
            imageUrl: 'assets/diesel.png',
            label: 'DIESEL',
            vehicleBrandId: vehicleBrandId,
            fuelType: FuelType.diesel,
          ),
          Spacer(),
        ],
      ),
    );
  }
}

class VehicleTypeCard extends StatelessWidget {
  final String imageUrl;
  final String label;
  final FuelType fuelType;
  final String? vehicleBrandId;

  const VehicleTypeCard({
    Key? key,
    required this.imageUrl,
    required this.label,
    required this.fuelType,
    required this.vehicleBrandId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: InkWell(
            onTap: () {
              Navigator.of(context).push(
                PageRouteBuilder(
                  pageBuilder: (context, _, __) => BlocProvider<VehiclesBloc>(
                    create: (context) => VehiclesBloc(
                        firebaseServices: context.read<FirebaseServices>(),
                        fuelType: fuelType,
                        vehicleBrandId: vehicleBrandId),
                    child: VehiclesScreen(
                      vehicleBrandId: vehicleBrandId,
                      fuelType: fuelType,
                    ),
                  ),
                ),
              );
            },
            child: Container(
              height: 200.0,
              width: 200.0,
              child: Image.asset(
                imageUrl,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        const SizedBox(height: 12.0),
        Text(
          label,
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.w600,
            letterSpacing: 1.2,
          ),
        )
      ],
    );
  }
}
