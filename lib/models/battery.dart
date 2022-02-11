import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class Battery extends Equatable {
  // final String? id;
  final String? brand;
  final String? type;
  final int? ratting;
  final int? price;
  final int? mrp;
  final int? scrap;
  final String? warranty;

  const Battery({
    this.brand,
    required this.type,
    required this.ratting,
    required this.price,
    required this.mrp,
    required this.scrap,
    required this.warranty,
  });

  @override
  List<Object?> get props {
    return [
      brand,
      type,
      ratting,
      price,
      mrp,
      scrap,
      warranty,
    ];
  }

  Battery copyWith({
    String? brand,
    String? id,
    String? type,
    int? ratting,
    int? price,
    int? mrp,
    int? scrap,
    String? warranty,
  }) {
    return Battery(
      brand: this.brand,
      //   id: id ?? this.id,
      type: type ?? this.type,
      ratting: ratting ?? this.ratting,
      price: price ?? this.price,
      mrp: mrp ?? this.mrp,
      scrap: scrap ?? this.scrap,
      warranty: warranty ?? this.warranty,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      //   'id': id,
      'brand': brand,
      'type': type,
      'ratting': ratting,
      'price': price,
      'mrp': mrp,
      'scrap': scrap,
      'warranty': warranty,
    };
  }

  static const emptyBattery = Battery(
      type: null,
      ratting: 0,
      price: 0,
      mrp: 0,
      scrap: 0,
      warranty: '',
      brand: '');

  factory Battery.fromMap(Map<String, dynamic> map) {
    return Battery(
        //  id: map['id'],
        type: map['type'],
        ratting: map['ratting'],
        price: map['price'],
        mrp: map['mrp'],
        scrap: map['scrap'],
        warranty: map['warranty'],
        brand: map['brand']);
  }

  static Future<Battery?> fromDocument(Map<String, dynamic> map) async {
    // print('Map $map');

    final DocumentReference? doc = map['battery'];
    final String? brand = doc?.path.split('/')[0];
    print('Battery brand $brand');

    //  print('Runtime ${doc.runtimeType}');
    // print('Doc $doc');
    final response = await doc?.get();
    final data = response?.data() as Map<String, dynamic>?;

    // print('Data $data');

    if (data != null) {
      data['brand'] = brand?.toUpperCase();
      print('Data $data');
      return Battery.fromMap(data);
    }
  }

  String toJson() => json.encode(toMap());

  factory Battery.fromJson(String source) =>
      Battery.fromMap(json.decode(source));

  @override
  bool get stringify => true;
}
