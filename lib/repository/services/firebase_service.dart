import 'package:battery_shop/config/paths.dart';
import 'package:battery_shop/models/battery.dart';
import 'package:battery_shop/models/vehicle.dart';
import 'package:battery_shop/models/vehicle_type.dart';
import 'package:battery_shop/models/vehilce_brands.dart';
import 'package:battery_shop/repository/services/base_firebase_repo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:enum_to_string/enum_to_string.dart';

class FirebaseServices extends BaseFirebaseRepository {
  final _firestore = FirebaseFirestore.instance;

  Future<List<VehicleBrand?>> getVehicleBrands() async {
    try {
      final querySnapshot = await _firestore
          .collection(Paths.vehicle_brands)
          .withConverter<VehicleBrand>(
              fromFirestore: (snapshot, _) =>
                  VehicleBrand.fromMap(snapshot.data()),
              toFirestore: (brands, _) => brands.toMap())
          .get();
      return querySnapshot.docs.map((doc) => doc.data()).toList();
    } catch (error) {
      print('Errort getting vehilce brands ${error.toString()}');
      throw error;
    }
  }

  Future<List<Vehicle?>> getVehiclesAssociatedWithBrands({
    required String? vehicleBrandId,
    required FuelType fuelType,
  }) async {
    final fuelTypeString = EnumToString.convertToString(fuelType);
    try {
      final querySnapshot = await _firestore
          .collection(Paths.vehicle_brands)
          .doc(vehicleBrandId)
          .collection(fuelTypeString)
          .withConverter<Vehicle>(
              fromFirestore: (snapshot, _) => Vehicle.fromMap(snapshot.data()!),
              toFirestore: (vehicle, _) => vehicle.toMap())
          .get();
      return querySnapshot.docs.map((doc) => doc.data()).toList();
    } catch (error) {
      print('Error getting vehilces ${error.toString()}');
      throw error;
    }
  }

  Stream<List<Future<Battery?>>> streamVehiclesBatteries({
    required String? vehicleBrandId,
    required FuelType fuelType,
    required String? vehicleId,
  }) {
    final fuelPath = EnumToString.convertToString(fuelType);
    print('VehicleBrand Id $vehicleBrandId');
    print('Fuel Path $fuelPath');
    print('Vehicle Id $vehicleId');
    try {
      return _firestore
          .collection(Paths.vehicle_brands)
          .doc(vehicleBrandId)
          .collection(fuelPath)
          .doc(vehicleId)
          .collection(Paths.batteries)
          .orderBy('priority', descending: false)
          .snapshots()
          .map((snaps) => snaps.docs
              .map((doc) => Battery.fromDocument(doc.data()))
              .toList());
    } catch (error) {
      print('Error getting batteries ${error.toString()}');
      throw error;
    }
  }
}
