import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class Battery extends Equatable {
  // final String? id;
  final String? type;
  final int? ratting;
  final double? price;
  final double? mrp;
  final int? scrap;
  final String? warranty;
  final int? priority;

  const Battery({
    required this.type,
    required this.ratting,
    required this.price,
    required this.mrp,
    required this.scrap,
    required this.warranty,
    required this.priority,
  });

  @override
  List<Object?> get props {
    return [
      type,
      ratting,
      price,
      mrp,
      scrap,
      warranty,
    ];
  }

  Battery copyWith({
    String? id,
    String? type,
    int? ratting,
    double? price,
    double? mrp,
    int? scrap,
    String? warranty,
    int? priority,
  }) {
    return Battery(
      //   id: id ?? this.id,
      type: type ?? this.type,
      ratting: ratting ?? this.ratting,
      price: price ?? this.price,
      mrp: mrp ?? this.mrp,
      scrap: scrap ?? this.scrap,
      warranty: warranty ?? this.warranty,
      priority: priority ?? this.priority,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      //   'id': id,
      'type': type,
      'ratting': ratting,
      'price': price,
      'mrp': mrp,
      'scrap': scrap,
      'warranty': warranty,
      'priority': priority,
    };
  }

  static const emptyBattery = Battery(
    type: null,
    ratting: 0,
    price: 0.0,
    mrp: 0.0,
    scrap: 0,
    warranty: '',
    priority: 0,
  );

  factory Battery.fromMap(Map<String, dynamic> map) {
    return Battery(
      //  id: map['id'],
      type: map['type'],
      ratting: map['ratting'],
      price: map['price'],
      mrp: map['mrp'],
      scrap: map['scrap'],
      warranty: map['warranty'],
      priority: map['priority'] ?? 0,
    );
  }

  static Future<Battery?> fromDocument(Map<String, dynamic> map) async {
    // print('Map $map');
    final DocumentReference? doc = map['battery'];
    //  print('Runtime ${doc.runtimeType}');
    // print('Doc $doc');
    final response = await doc?.get();
    final data = response?.data() as Map<String, dynamic>?;
    // print('Data $data');

    if (data != null) {
      return Battery.fromMap(data);
    }

    // final data = await doc?.get() as Map<String, dynamic>?;
    // print('Data $data');
    // if (data != null) {
    //   return Battery.fromMap(data);
    // }
    // return Battery.emptyBattery;
  }

  // factory Battery.fromDocument(Map<String, dynamic> map) async{
  //   print('Runtime type ${map['battery']}');
  //   final DocumentReference? doc = map['battery'];

  //   final data =  await doc?.get() as Map<String, dynamic>?;
  //   if (data != null) {
  //     return Battery.fromMap(data);
  //   }
  //   return Battery.emptyBattery;
  // }

  String toJson() => json.encode(toMap());

  factory Battery.fromJson(String source) =>
      Battery.fromMap(json.decode(source));

  @override
  bool get stringify => true;
}
