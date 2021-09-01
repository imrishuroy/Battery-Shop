import 'package:battery_shop/models/vehilce_brands.dart';
import 'package:battery_shop/screens/vehicle-type/vehicle_type_screen.dart';
import 'package:battery_shop/widgets/display_image.dart';
import 'package:flutter/material.dart';

class VehicleBrandCard extends StatelessWidget {
  final VehicleBrand? vehicleBrand;

  const VehicleBrandCard({Key? key, required this.vehicleBrand})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 4.0,
        vertical: 4.0,
      ),
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => VehicleTypeScreen(
                vehicleBrandId: vehicleBrand?.id,
              ),
            ),
          );
        },
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(6.0)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Spacer(),
              Container(
                height: 100.0,
                width: 100.0,
                child: DisplayImage(imageUrl: vehicleBrand?.logoUrl),
              ),
              Spacer(),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black87),
                  // color: Color(0xffDDDDDD),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(6.0),
                    bottomRight: Radius.circular(6.0),
                  ),
                ),
                child: Text(
                  '${vehicleBrand?.name}',
                  style: TextStyle(
                    fontSize: 18.0,
                    // fontWeight: FontWeight.w500,
                    letterSpacing: 1.2,
                  ),
                  textAlign: TextAlign.center,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
