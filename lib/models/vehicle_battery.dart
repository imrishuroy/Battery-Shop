import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

import 'package:admin_battery/models/battery.dart';

class VehicleBattery extends Equatable {
  final Battery? battery;
  final int? priority;
  VehicleBattery({
    this.battery,
    this.priority,
  });

  VehicleBattery copyWith({
    Battery? battery,
    int? priority,
  }) {
    return VehicleBattery(
      battery: battery ?? this.battery,
      priority: priority ?? this.priority,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'battery': battery?.toMap(),
      'priority': priority ?? 0,
    };
  }

  // factory VehicleBattery.fromMap(Map<String, dynamic> map) {
  //   return VehicleBattery(
  //     battery: Battery.fromMap(map['battery']),
  //     priority: map['priority'],
  //   );
  // }

  static Future<VehicleBattery?> fromDocument(Map<String, dynamic> map) async {
    print('Map $map');

    final DocumentReference? doc = map['battery'];
    //  print('Runtime ${doc.runtimeType}');
    // print('Doc $doc');
    final response = await doc?.get();
    final data = response?.data() as Map<String, dynamic>?;
    // print('Data $data');

    // if (data != null) {
    //   return Battery.fromMap(data);
    // }
    if (data != null) {
      return VehicleBattery(
        //battery: await Battery.fromDocument(map['battery']),
        battery: Battery.fromMap(data),
        priority: map['priority'],
      );
    }
  }

  String toJson() => json.encode(toMap());

  // factory VehicleBattery.fromJson(String source) =>
  //     VehicleBattery.fromMap(json.decode(source));

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [battery, priority];
}
