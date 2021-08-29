import 'dart:convert';
import 'package:equatable/equatable.dart';

class VehicleBattery extends Equatable {
  final String? id;
  final String? type;
  final int? ratting;
  final double? price;
  final double? mrp;
  final int? scrap;
  final String? warranty;

  VehicleBattery({
    this.id,
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
      id,
      type,
      ratting,
      price,
      mrp,
      scrap,
      warranty,
    ];
  }

  VehicleBattery copyWith({
    String? id,
    String? type,
    int? ratting,
    double? price,
    double? mrp,
    int? scrap,
    String? warranty,
  }) {
    return VehicleBattery(
      id: id ?? this.id,
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
      'id': id,
      'type': type,
      'ratting': ratting,
      'price': price,
      'mrp': mrp,
      'scrap': scrap,
      'warranty': warranty,
    };
  }

  factory VehicleBattery.fromMap(Map<String, dynamic> map) {
    return VehicleBattery(
      id: map['id'],
      type: map['type'],
      ratting: map['ratting'],
      price: map['price'],
      mrp: map['mrp'],
      scrap: map['scrap'],
      warranty: map['warranty'],
    );
  }

  String toJson() => json.encode(toMap());

  factory VehicleBattery.fromJson(String source) =>
      VehicleBattery.fromMap(json.decode(source));

  @override
  bool get stringify => true;
}
