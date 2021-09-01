import 'package:battery_shop/screens/vehicle-brands/bloc/vehilce_brands_bloc.dart';
import 'package:battery_shop/screens/vehicle-brands/vehilce_brand_card.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class VehicleBrands extends StatelessWidget {
  const VehicleBrands({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: BlocConsumer<VehilceBrandsBloc, VehilceBrandsState>(
        listener: (context, state) {},
        builder: (context, state) {
          switch (state.status) {
            case VehicleBrandsStatus.errror:
              return const Center(child: Text('Something went wrong'));

            case VehicleBrandsStatus.succuss:
              final brands = state.vehicleBrands;

              return AnimationLimiter(
                child: GridView.builder(
                  itemCount: brands.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                  ),
                  itemBuilder: (context, index) {
                    return AnimationConfiguration.staggeredGrid(
                      duration: const Duration(milliseconds: 375),
                      position: index,
                      columnCount: brands.length,
                      child: ScaleAnimation(
                        child: FadeInAnimation(
                          child: VehicleBrandCard(
                            imageUrl: brands[index]?.logoUrl!,
                            name: brands[index]?.name!,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              );

            default:
              return const Center(
                child: CircularProgressIndicator(),
              );
          }
        },
      ),
    );
  }
}
