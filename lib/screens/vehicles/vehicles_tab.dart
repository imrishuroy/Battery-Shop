import 'package:battery_shop/models/vehicle.dart';
import 'package:battery_shop/screens/battery/battery_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

List<Vehicle> vehicles = [
  Vehicle(
    name: 'Tata Venture',
    imageUrl:
        'https://imgd.aeplcdn.com/1056x594/ec/f7/5C/10740/img/m/Tata-Venture-Right-Front-Three-Quarter-48863_ol.jpg?v=201711021421&q=85',
  ),
  Vehicle(
    name: 'Tata Tiago',
    imageUrl:
        'https://imgd.aeplcdn.com/1056x594/n/cw/ec/39345/tiago-exterior-right-front-three-quarter-6.jpeg?q=85',
  ),
  Vehicle(
    name: 'Tata Indica',
    imageUrl:
        'https://imgd.aeplcdn.com/1056x594/ec/C9/F0/10743/img/m/Tata-Indica-V2-Right-Front-Three-Quarter-48859_ol.jpg?v=201711021421&q=85',
  ),
];

class VehiclesTab extends StatelessWidget {
  const VehiclesTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: AnimationLimiter(
              child: ListView.builder(
                itemCount: vehicles.length,
                itemBuilder: (context, index) {
                  final vehicle = vehicles[index];
                  return AnimationConfiguration.staggeredList(
                    position: index,
                    duration: const Duration(milliseconds: 375),
                    child: SlideAnimation(
                      verticalOffset: 50.0,
                      child: FadeInAnimation(
                        child: Padding(
                          padding:
                              const EdgeInsets.fromLTRB(12.0, 6, 12.0, 0.0),
                          child: InkWell(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => BatteryRequiredScreen(),
                                ),
                              );
                            },
                            child: Card(
                                child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10.0,
                                vertical: 10.0,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width: 190.0,
                                    //height: 50.0,
                                    child: Text(
                                      '${vehicle.name}',
                                      style: TextStyle(
                                        fontSize: 17.0,
                                        letterSpacing: 1.0,
                                        // fontWeight: FontWeight.w500,
                                      ),
                                      maxLines: 3,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  Container(
                                    height: 65.0,
                                    width: 100.0,
                                    child: CachedNetworkImage(
                                      imageUrl: vehicle.imageUrl ?? '',
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ],
                              ),
                            )),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
