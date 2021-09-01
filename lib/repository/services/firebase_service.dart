import 'package:battery_shop/config/paths.dart';
import 'package:battery_shop/models/brand.dart';
import 'package:battery_shop/models/failure.dart';
import 'package:battery_shop/models/vehilce_brands.dart';
import 'package:battery_shop/repository/services/base_firebase_repo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseService extends BaseFirebaseRepository {
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

  Future<List<VehicleBrand?>> getVehicleBrands() async {
    try {
      final snapshot = await _firestore
          .collection(Paths.vehicle_brands)
          .withConverter<VehicleBrand>(
              fromFirestore: (snapshot, _) =>
                  VehicleBrand.fromMap(snapshot.data()),
              toFirestore: (brands, _) => brands.toMap())
          .get();
      return snapshot.docs.map((doc) => doc.data()).toList();
    } catch (error) {
      print('Errort getting vehilce brands ${error.toString()}');
      throw error;
    }
  }
}
