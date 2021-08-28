import 'package:admin_battery/config/paths.dart';
import 'package:admin_battery/models/brands.dart';
import 'package:admin_battery/models/failure.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseServices {
  final _fireStore = FirebaseFirestore.instance;

  Stream<List<VehicleBrand?>> carBrandsStream() {
    try {
      return _fireStore
          .collection(Paths.car_brands)
          .withConverter<VehicleBrand>(
              fromFirestore: (snapshot, _) =>
                  VehicleBrand.fromMap(snapshot.data()),
              toFirestore: (brand, _) => brand.toMap())
          .snapshots()
          .map((snap) => snap.docs.map((doc) => doc.data()).toList());
    } catch (error) {
      print('Error getting car brands');
      throw error;
    }
  }

  Future addNewVehicle({required VehicleBrand brand}) async {
    try {
      final result =
          await _fireStore.collection(Paths.car_brands).add(brand.toMap());

      print('Add new vehicle Result $result');
    } catch (error) {
      print('Error added new vehilce ${error.toString()}');
      throw Failure(message: error.toString());
    }
  }
}
