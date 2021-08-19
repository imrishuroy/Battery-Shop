import 'package:battery_shop/config/paths.dart';
import 'package:battery_shop/models/brand.dart';
import 'package:battery_shop/models/failure.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class FirebaseService extends Equatable {
  final _firestore = FirebaseFirestore.instance;

  Future<QuerySnapshot<Brand?>> getCarBrands() async {
    try {
      return _firestore
          .collection(Paths.carBrands)
          .withConverter<Brand>(
              fromFirestore: (snapshot, _) => Brand.fromMap(snapshot.data()),
              toFirestore: (brand, _) => brand.toMap())
          .get();
    } catch (error) {
      print('Error getting car brands ${error.toString()}');
      throw Failure(message: error.toString());
    }
  }

  @override
  List<Object?> get props => [];
}
