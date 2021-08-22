import 'package:admin_battery/models/battery.dart';
import 'package:admin_battery/models/failure.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseRepository {
  final _firestore = FirebaseFirestore.instance;

  Future<void> uploadBattery({
    required List<Battery?> batteries,
    required String collectionName,
  }) async {
    try {
      for (var battery in batteries) {
        if (battery != null) {
          // print('this runs 2 $batteries');
          final data = await _firestore
              .collection(collectionName)
              .doc(battery.type)
              .get();
          if (data.exists) {
            await _firestore
                .collection(collectionName)
                .doc(battery.type)
                .update(battery.toMap());

            print('Data Exist');
          } else {
            //final uid = Uuid().v4();
            // final myBattery = battery.copyWith(id: uid);
            await _firestore
                .collection(collectionName)
                .doc(battery.type)
                .set(battery.toMap());
            print('Data donot exists');
          }

          //   await _firestore.collection(Paths.battery).add(battery.toMap());
        }
      }
    } catch (error) {
      print('Error uploading batteries ${error.toString()}');
      throw Failure(message: 'Error uploading batteries');
    }
  }
}
