import 'package:battery_shop/screens/battery/battery_screen.dart';
import 'package:battery_shop/screens/vehicles/vehicles_tab.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class VehiclesScreen extends StatelessWidget {
  const VehiclesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Catelog',
          style: TextStyle(
            letterSpacing: 1.2,
          ),
        ),
      ),
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
