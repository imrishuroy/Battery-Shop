import '/config/paths.dart';
import '/models/battery.dart';
import '/models/vehicle_brands.dart';
import '/models/failure.dart';
import '/models/vehicle.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '/enums/enums.dart';
import 'package:enum_to_string/enum_to_string.dart';

class FirebaseServices {
  final _fireStore = FirebaseFirestore.instance;

  Stream<List<VehicleBrand?>> carBrandsStream() {
    try {
      return _fireStore
          .collection(Paths.vehicle_brands)
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

  Future<void> addNewVehicle({required VehicleBrand brand}) async {
    try {
      await _fireStore
          .collection(Paths.vehicle_brands)
          .doc(brand.id)
          .set(brand.toMap());
    } catch (error) {
      print('Error added new vehilce ${error.toString()}');
      throw Failure(message: error.toString());
    }
  }

  Future<bool> addVehicleToBrand({
    required String? vehicleBrandId,
    required Vehicle? vehicle,
    required FuelType? fuelType,
    required String vehicleType,
  }) async {
    final vehiclepath = EnumToString.convertToString(fuelType);
    try {
      if (vehicle != null) {
        await _fireStore
            .collection(Paths.vehicle_brands)
            .doc(vehicleBrandId)
            .collection('$vehiclepath-$vehicleType')
            .doc(vehicle.vehicleId)
            .set(vehicle.toMap());
        return true;
      }
      return false;
    } catch (error) {
      print('Error adding vehicle to brand ${error.toString()}');
      throw error;
    }
  }

  Stream<List<Vehicle?>> vehiclesAssociatedWithBransStream({
    required String? vehicleBrandId,
    required FuelType fuelType,
    required String vehicleType,
  }) {
    final vehiclepath = EnumToString.convertToString(fuelType);
    try {
      return _fireStore
          .collection(Paths.vehicle_brands)
          .doc(vehicleBrandId)
          .collection('$vehiclepath-$vehicleType')
          .withConverter<Vehicle>(
              fromFirestore: (snapshot, _) => Vehicle.fromMap(snapshot.data()!),
              toFirestore: (vehicle, _) => vehicle.toMap())
          .snapshots()
          .map((snaps) => snaps.docs.map((doc) => doc.data()).toList());
    } catch (error) {
      print(
          'Error getting vehicles associated with brands ${error.toString()}');
      throw Failure(message: 'Error getting vehicles');
    }
  }

  Future<void> addBatteryToVehicle({
    required String? vehicleBrandId,
    required FuelType fuelType,
    required String? vehicleId,
    required Battery? battery,
    required String batteryBrand,
  }) async {
    try {
      final fuelPath = EnumToString.convertToString(fuelType);

      await _fireStore
          .collection(Paths.vehicle_brands)
          .doc(vehicleBrandId)
          .collection(fuelPath)
          .doc(vehicleId)
          .collection(Paths.batteries)
          .doc(battery?.type)
          .set({
        'battery': _fireStore.collection(batteryBrand).doc(battery?.type)
      });
    } catch (error) {
      throw error;
    }
  }

  Future<void> delteVehicleBrand({required String vehicleBrandId}) async {
    try {
      await _fireStore
          .collection(Paths.vehicle_brands)
          .doc(vehicleBrandId)
          .delete();
    } catch (error) {
      print('Error deleting vehicle brand ${error.toString()}');
    }
  }
}
