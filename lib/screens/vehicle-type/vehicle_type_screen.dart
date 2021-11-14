import '/screens/vehicles-catelog/vehicles_catelog.dart';

import '/models/vehicle_type.dart';

import 'package:flutter/material.dart';

List<VehicleType> vehiclesType = [
  const VehicleType(
    type: FuelType.petrol,
    imageUrl: 'assets/petrol.png',
  ),
  const VehicleType(
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
        title: const Text('Choose Your Vehicle'),
      ),
      body: Column(
        //crossAxisAlignment: CrossAxisAlignment.,
        children: [
          const Spacer(),
          VehicleTypeCard(
            imageUrl: 'assets/petrol.png',
            label: 'PETROL',
            fuelType: FuelType.petrol,
            vehicleBrandId: vehicleBrandId,
          ),
          const Spacer(),
          VehicleTypeCard(
            imageUrl: 'assets/diesel.png',
            label: 'DIESEL',
            fuelType: FuelType.diesel,
            vehicleBrandId: vehicleBrandId,
          ),
          const Spacer(),
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
        Navigator.of(context).pushNamed(VehiclesCatelog.routeName,
            arguments: VehiclesCatelogArgs(
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
            child: SizedBox(
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
            style: const TextStyle(
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
