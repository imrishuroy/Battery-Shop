import '/screens/vehicle-brands/bloc/vehicle_brands_bloc.dart';
import '/services/services.dart';
import '/widgets/show_message.dart';

import '/constants/constants.dart';
import '/models/vehicle_brands.dart';
import '/screens/fule-type/fule_type_screen.dart';

import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BrandCard extends StatelessWidget {
  final VehicleBrand? vehicleBrand;

  const BrandCard({Key? key, required this.vehicleBrand}) : super(key: key);

  Future<void> _deleteBrand(BuildContext context) async {
    try {
      final result = await Services.askToAction(context,
          title: 'Delete Brand',
          content: 'Do you want to delete this vehicle brand ?');

      if (result) {
        if (vehicleBrand?.id != null) {
          context
              .read<VehicleBrandsBloc>()
              .add(DeleteVehicleBrand(vehicleBrandId: vehicleBrand!.id!));
          ShowMessage.showSuccussMessage(context, message: 'Brand deleted');
        }
      }
    } catch (error) {
      print('Error delting brand ${error.toString()}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, size) {
        return GestureDetector(
          onLongPress: () => _deleteBrand(context),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: size.screenSize.width * 0.001,
              vertical: size.screenSize.height * 0.001,
            ),
            child: InkWell(
              hoverColor: Colors.greenAccent.shade100.withOpacity(0.2),
              onTap: () {
                Navigator.of(context).push(
                  PageRouteBuilder(
                    pageBuilder: (context, _, __) => FuleTypeScreen(
                      vehicleBrandId: vehicleBrand?.id,
                    ),
                  ),
                );
              },
              child: Card(
                //   elevation: 5,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6.0)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Spacer(),
                    Container(
                      height: size.localWidgetSize.height - 40.0,
                      width: size.localWidgetSize.width,
                      child: Image.network(
                        vehicleBrand?.logoUrl ?? errorImage,
                        fit: BoxFit.contain,
                      ),
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
                        '${vehicleBrand?.name ?? 'N/A'}',
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
          ),
        );
      },
    );
  }
}
