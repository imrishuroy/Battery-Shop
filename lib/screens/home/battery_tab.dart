import 'package:battery_shop/constants/constants.dart';
import 'package:battery_shop/screens/vehicle-brands/vehilce_brands.dart';
import 'package:flutter/material.dart';

class BatteryTab extends StatelessWidget {
  const BatteryTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 10.0,
          horizontal: 10.0,
        ),
        child: Column(
          children: [
            Container(
              height: 140.0,
              width: double.infinity,
              child: Image.network(
                adBanner,
                fit: BoxFit.cover,
              ),
            ),
            //  Search(),
            VehicleBrands(),
          ],
        ),
      ),
    );
  }
}
