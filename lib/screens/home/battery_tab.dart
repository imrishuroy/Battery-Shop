import 'package:battery_shop/models/brand.dart';
import 'package:battery_shop/repository/services/firebase_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'widgets/brand_card.dart';

List<Brand> brands = [
  Brand(
    name: 'Audi',
    logoUrl: 'https://www.carlogos.org/logo/Audi-logo.png',
    id: Uuid().v4(),
  ),
  Brand(
    name: 'BMW',
    logoUrl: 'https://www.carlogos.org/car-logos/bmw-logo.png',
    id: Uuid().v4(),
  ),
  Brand(
    name: 'Chevrolet',
    logoUrl:
        'https://logos-world.net/wp-content/uploads/2021/03/Chevrolet-Logo.png',
    id: Uuid().v4(),
  ),
  Brand(
    name: 'Tata Motors',
    logoUrl: 'https://www.carlogos.org/logo/Tata-logo-2000-640x550.jpg',
    id: Uuid().v4(),
  )
];

class BatteryTab extends StatelessWidget {
  const BatteryTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _service = context.read<FirebaseService>();
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 10.0,
        horizontal: 10.0,
      ),
      child: Column(
        children: [
          Expanded(
            child: FutureBuilder<QuerySnapshot<Brand?>>(
              future: _service.getCarBrands(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
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
                            child: BrandCard(
                              imageUrl: brands[index].logoUrl!,
                              name: brands[index].name!,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
