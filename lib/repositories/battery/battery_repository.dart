import 'package:admin_battery/config/paths.dart';
import 'package:admin_battery/enums/enums.dart';
import 'package:admin_battery/models/battery.dart';
import 'package:admin_battery/models/vehicle_battery.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:enum_to_string/enum_to_string.dart';

class BatteryRepository {
  final FirebaseFirestore _fireStore;

  BatteryRepository({FirebaseFirestore? firebaseFirestore})
      : _fireStore = firebaseFirestore ?? FirebaseFirestore.instance;

  Stream<List<Battery?>> batteryStream({required String path}) {
    try {
      return _fireStore
          .collection(path)
          .withConverter<Battery>(
              fromFirestore: (snapshot, _) => Battery.fromMap(snapshot.data()!),
              toFirestore: (battery, _) => battery.toMap())
          .snapshots()
          .map((snaps) => snaps.docs.map((doc) => doc.data()).toList());
    } catch (error) {
      throw error;
    }
  }

  Future<List<Battery?>> getBatteries(String path) async {
    try {
      final result = await _fireStore
          .collection(path)
          .withConverter<Battery>(
              fromFirestore: (snapshot, _) => Battery.fromMap(snapshot.data()!),
              toFirestore: (battery, _) => battery.toMap())
          .get();

      return result.docs.map((doc) => doc.data()).toList();
    } catch (error) {
      print('Error getting batteries ${error.toString()}');
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
      return _fireStore
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

  // this is used for priority batteries
  Stream<List<Future<VehicleBattery?>>> streamBatteries({
    required String? vehicleBrandId,
    required FuelType fuelType,
    required String? vehicleId,
  }) {
    final fuelPath = EnumToString.convertToString(fuelType);
    print('VehicleBrand Id $vehicleBrandId');
    print('Fuel Path $fuelPath');
    print('Vehicle Id $vehicleId');
    try {
      return _fireStore
          .collection(Paths.vehicle_brands)
          .doc(vehicleBrandId)
          .collection(fuelPath)
          .doc(vehicleId)
          .collection(Paths.batteries)
          .orderBy('priority', descending: false)
          .snapshots()
          .map((snaps) => snaps.docs
              .map((doc) => VehicleBattery.fromDocument(doc.data()))
              .toList());
    } catch (error) {
      throw error;
    }
  }

  Stream<List<Battery?>> streamRemoteBatteries({
    required String? vehicleBrandId,
    required FuelType fuelType,
    required String? vehicleId,
  }) {
    final fuelPath = EnumToString.convertToString(fuelType);
    print('VehicleBrand Id $vehicleBrandId');
    print('Fuel Path $fuelPath');
    print('Vehicle Id $vehicleId');

    try {
      return _fireStore
          .collection(Paths.vehicle_brands)
          .doc(vehicleBrandId)
          .collection(fuelPath)
          .doc(vehicleId)
          .collection(Paths.batteries)
          .withConverter<Battery>(
              fromFirestore: (snapshot, _) => Battery.fromMap(snapshot.data()!),
              toFirestore: (battery, _) => battery.toMap())
          .snapshots()
          .map((snaps) => snaps.docs.map((doc) => doc.data()).toList());
    } catch (error) {
      print('Error getting remote batteries ${error.toString()}');
      throw error;
    }
  }

  Future<void> addBatteryToVehicle({
    required String? vehicleBrandId,
    required FuelType fuelType,
    required String? vehicleId,
    required String? batteryType,
    required String batteryBrand,
  }) async {
    try {
      final fuelPath = EnumToString.convertToString(fuelType);
      print('VehicleBrand Id $vehicleBrandId');
      print('FuelType $fuelPath');
      print('Vehicle Id $vehicleId');
      print('Battery Type $batteryType');
      // print('Battery Brand $batteryBrand');

      await _fireStore
          .collection(Paths.vehicle_brands)
          .doc(vehicleBrandId)
          .collection(fuelPath)
          .doc(vehicleId)
          .collection(Paths.batteries)
          .doc(batteryType)
          .set({
        'battery': _fireStore.collection(batteryBrand).doc(batteryType)
      });
    } catch (error) {
      throw error;
    }
  }

  Future<void> removeBatteryFromVehicle({
    required String? vehicleBrandId,
    required FuelType fuelType,
    required String? vehicleId,
    required String? batteryType,
  }) async {
    try {
      final fuelPath = EnumToString.convertToString(fuelType);
      print('VehicleBrand Id $vehicleBrandId');
      print('FuelType $fuelPath');
      print('Vehicle Id $vehicleId');
      print('Battery Type $batteryType');

      await _fireStore
          .collection(Paths.vehicle_brands)
          .doc(vehicleBrandId)
          .collection(fuelPath)
          .doc(vehicleId)
          .collection(Paths.batteries)
          .doc(batteryType)
          .delete();
    } catch (error) {
      throw error;
    }
  }

  getVehicleBatteries({
    required String? vehicleBrandId,
    required FuelType? fuelType,
    required String? vehicleId,
  }) async {
    try {
      final fuelPath = EnumToString.convertToString(fuelType);
      print('VehicleBrand Id $vehicleBrandId');
      print('Fuel Path $fuelPath');
      print('Vehicle Id $vehicleId');

      final querySnapshot = await _fireStore
          .collection(Paths.vehicle_brands)
          .doc(vehicleBrandId)
          .collection(fuelPath)
          .doc(vehicleId)
          .collection(Paths.batteries)
          .get();

      return querySnapshot.docs
          .map((doc) async => await Battery.fromDocument(doc.data()))
          .toList();
    } catch (error) {
      print('Error getting vehilce batteries ');
      throw error;
    }
  }

  Future<void> editBatteryPriority({
    required String? vehicleBrandId,
    required FuelType? fuelType,
    required String? vehicleId,
    // required Battery? battery,
    required String? type,
    required int? priority,
  }) async {
    print('VehicleBrand Id $vehicleBrandId');

    print('Vehicle Id $vehicleId');
    print('Battery Type $type');
    try {
      final fuelPath = EnumToString.convertToString(fuelType);
      print('Fuel Path $fuelPath');
      await _fireStore
          .collection(Paths.vehicle_brands)
          .doc(vehicleBrandId)
          .collection(fuelPath)
          .doc(vehicleId)
          .collection(Paths.batteries)
          .doc(type)
          .update({'priority': priority});
    } catch (error) {
      print(error.toString());
      throw error;
    }
  }

  Future<int> getBatteryPriority({
    required String? vehicleBrandId,
    required FuelType? fuelType,
    required String? vehicleId,
    // required Battery? battery,
    required String? type,
  }) async {
    try {
      final fuelPath = EnumToString.convertToString(fuelType);
      print('Fuel Path $fuelPath');
      final doc = await _fireStore
          .collection(Paths.vehicle_brands)
          .doc(vehicleBrandId)
          .collection(fuelPath)
          .doc(vehicleId)
          .collection(Paths.batteries)
          .doc(type)
          .get();
      return doc.data()?['priority'] ?? 0;
    } catch (error) {
      print('Error getting priorities ${error.toString()}');
      throw error;
    }
  }

  // Future<Battery?> getBattery({required String batteryPath}) async {
  //   try {
  //     _fireStore.
  //   } catch (error) {
  //     print('Error getting battery ${error.toString()}');
  //   }
  // }
}
