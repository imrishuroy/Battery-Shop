import 'package:admin_battery/models/vehicle_type.dart';
import 'package:admin_battery/vehicles/vehicles_screen.dart';

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
  const VehicleTypeScreen({Key? key}) : super(key: key);

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
          ),
          Spacer(),
          VehicleTypeCard(
            imageUrl: 'assets/diesel.png',
            label: 'DIESEL',
          ),
          Spacer(),
        ],
      ),
    );
  }
}

class VehicleTypeWidget extends StatelessWidget {
  const VehicleTypeWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      //crossAxisAlignment: CrossAxisAlignment.,
      children: [
        Spacer(),
        VehicleTypeCard(
          imageUrl: 'assets/petrol.png',
          label: 'PETROL',
        ),
        Spacer(),
        VehicleTypeCard(
          imageUrl: 'assets/diesel.png',
          label: 'DIESEL',
        ),
        Spacer(),
      ],
    );
  }
}

class VehicleTypeCard extends StatelessWidget {
  final String imageUrl;
  final String label;

  const VehicleTypeCard({
    Key? key,
    required this.imageUrl,
    required this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => VehiclesScreen(),
          ),
        );
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
