import 'package:admin_battery/config/paths.dart';
import 'package:admin_battery/models/battery.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
}
