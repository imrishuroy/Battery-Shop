import '/config/paths.dart';
import '/enums/enums.dart';
import '/repositories/vehicles/base_vehilce_repo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:enum_to_string/enum_to_string.dart';
import 'package:firebase_storage/firebase_storage.dart';

class VehicleRepository extends BaseVehicleRepository {
  final FirebaseFirestore _firestore;

  final FirebaseStorage _firebaseStorage;

  VehicleRepository({
    FirebaseFirestore? firebaseFirestore,
    FirebaseStorage? firebaseStorage,
  })  : _firestore = firebaseFirestore ?? FirebaseFirestore.instance,
        _firebaseStorage = firebaseStorage ?? FirebaseStorage.instance;

  Future<void> deleteVehicle({
    required String? vehicleBrandId,
    required FuelType fuelType,
    required String? vehicleId,
    required String vehicleType,
  }) async {
    try {
      final fuelPath = EnumToString.convertToString(fuelType);

      await _firestore
          .collection(Paths.vehicle_brands)
          .doc(vehicleBrandId)
          .collection('$fuelPath-$vehicleType')
          .doc(vehicleId)
          .delete();

      await _firebaseStorage.ref().child('images/$vehicleId').delete();
    } catch (error) {
      print('Error deleting vehicle ${error.toString()}');
      throw error;
    }
  }
}
