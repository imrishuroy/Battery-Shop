import 'package:admin_battery/models/brands.dart';
import 'package:admin_battery/repositories/firebase_services.dart';
import 'package:admin_battery/screens/home/brand_cards.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_builder/responsive_builder.dart';

class BatteryTab extends StatelessWidget {
  const BatteryTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _service = context.read<FirebaseServices>();

    return ResponsiveBuilder(
      builder: (context, size) {
        return Padding(
          padding: EdgeInsets.symmetric(
            // vertical: 10.0,
            // horizontal: 10.0,
            vertical: size.screenSize.height * 0.02,
            horizontal: size.screenSize.width * 0.02,
          ),
          child: Column(
            children: [
              Expanded(
                  child: StreamBuilder<List<VehicleBrand?>>(
                stream: _service.carBrandsStream(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  print(snapshot.data);
                  return AnimationLimiter(
                    child: GridView.builder(
                      itemCount: snapshot.data?.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: size.isDesktop
                            ? 4
                            : size.isMobile
                                ? 2
                                : 3,
                        // crossAxisCount: size.isMobile ? 2 : 3,
                        //childAspectRatio: 2.5,
                      ),
                      itemBuilder: (context, index) {
                        final brand = snapshot.data?[index];
                        return AnimationConfiguration.staggeredGrid(
                          duration: const Duration(milliseconds: 375),
                          position: index,
                          columnCount: snapshot.data!.length,
                          child: ScaleAnimation(
                            child: FadeInAnimation(
                              child: BrandCard(
                                imageUrl: brand?.logoUrl,
                                name: brand!.name!,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
              )),
              // Expanded(
              //   child: FutureBuilder<QuerySnapshot<Brand?>>(
              //     future: _service.getCarBrands(),
              //     builder: (context, snapshot) {
              //       if (snapshot.connectionState == ConnectionState.waiting) {
              //         return Center(
              //           child: CircularProgressIndicator(),
              //         );
              //       }
              //       return AnimationLimiter(
              //         child: GridView.builder(
              //           itemCount: brands.length,
              //           gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              //             crossAxisCount: 2,
              //           ),
              //           itemBuilder: (context, index) {
              //             return AnimationConfiguration.staggeredGrid(
              //               duration: const Duration(milliseconds: 375),
              //               position: index,
              //               columnCount: brands.length,
              //               child: ScaleAnimation(
              //                 child: FadeInAnimation(
              //                   child: BrandCard(
              //                     imageUrl: brands[index].logoUrl!,
              //                     name: brands[index].name!,
              //                   ),
              //                 ),
              //               ),
              //             );
              //           },
              //         ),
              //       );
              //     },
              //   ),
              // ),
            ],
          ),
        );
      },
    );
  }
}
