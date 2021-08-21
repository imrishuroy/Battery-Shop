import 'package:admin_battery/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

class BrandCard extends StatelessWidget {
  final String? imageUrl;
  final String name;

  const BrandCard({Key? key, required this.imageUrl, required this.name})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, size) {
        return Padding(
          padding: EdgeInsets.symmetric(
            horizontal: size.screenSize.width * 0.001,
            vertical: size.screenSize.height * 0.001,
          ),
          child: InkWell(
            hoverColor: Colors.greenAccent.shade100.withOpacity(0.2),
            onTap: () {
              // Navigator.of(context).push(
              //   MaterialPageRoute(
              //     builder: (context) => VehicleTypeScreen(),
              //   ),
              // );
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
                      imageUrl ?? errorImage,
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
                      '$name',
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
      },
    );
  }
}
