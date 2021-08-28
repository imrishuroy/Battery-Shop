import 'package:admin_battery/screens/home/brand_cards.dart';
import 'package:admin_battery/screens/vehicle-brands/bloc/vehicle_brands_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_builder/responsive_builder.dart';

class VehicleBrandsTab extends StatelessWidget {
  const VehicleBrandsTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                  child: BlocConsumer<VehicleBrandsBloc, VehicleBrandsState>(
                listener: (context, state) {},
                builder: (context, state) {
                  switch (state.status) {
                    case VehicleBrandsStatus.error:
                      return Center(
                        child: Text('Something went wrong'),
                      );
                    case VehicleBrandsStatus.succuss:
                      return AnimationLimiter(
                        child: GridView.builder(
                          itemCount: state.brands.length,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: size.isDesktop
                                ? 4
                                : size.isMobile
                                    ? 2
                                    : 3,
                            // crossAxisCount: size.isMobile ? 2 : 3,
                            //childAspectRatio: 2.5,
                          ),
                          itemBuilder: (context, index) {
                            final brand = state.brands[index];
                            return AnimationConfiguration.staggeredGrid(
                              duration: const Duration(milliseconds: 375),
                              position: index,
                              columnCount: state.brands.length,
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
                    default:
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                  }
                },
              )),
            ],
          ),
        );
      },
    );
  }
}
