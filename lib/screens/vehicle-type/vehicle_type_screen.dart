import 'package:battery_shop/models/vehicle_type.dart';
import 'package:battery_shop/screens/vehicles/vehicles_screen.dart';

import 'package:flutter/material.dart';

List<VehicleType> vehiclesType = [
  VehicleType(
    type: FuelType.petrol,
    imageUrl: 'assets/petrol.png',
  ),
  VehicleType(
    type: FuelType.diesel,
    imageUrl: 'assets/diesel.png',
  )
];

class VehicleTypeScreen extends StatelessWidget {
  final String? vehicleBrandId;

  const VehicleTypeScreen({Key? key, required this.vehicleBrandId})
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
            fuelType: FuelType.petrol,
            vehicleBrandId: vehicleBrandId,
          ),
          Spacer(),
          VehicleTypeCard(
            imageUrl: 'assets/diesel.png',
            label: 'DIESEL',
            fuelType: FuelType.diesel,
            vehicleBrandId: vehicleBrandId,
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
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed(VehiclesScreen.routeName,
            arguments: VehiclesScreenArgs(
                vehilceBrandId: vehicleBrandId, fuelType: fuelType));

        // Navigator.of(context).push(
        //   MaterialPageRoute(
        //     builder: (_) => VehiclesScreen(
        //       vehicleBrandId: vehicleBrandId,
        //       fuelType: fuelType,
        //     ),
        //   ),
        // );
      },
      child: Column(
        children: [
          Center(
            child: Container(
              height: 200.0,
              width: 200.0,
              child: Image.asset(
                imageUrl,
                fit: BoxFit.cover,
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
      ),
    );
  }
}
