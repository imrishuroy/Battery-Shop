import 'dart:convert';

import 'package:equatable/equatable.dart';

class Battery extends Equatable {
  final String? type;
  final int? ratting;
  final double? price;
  final double? mrp;
  final int? scrap;
  final String? warranty;
  Battery({
    this.type,
    this.ratting,
    this.price,
    this.mrp,
    this.scrap,
    this.warranty,
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

  Battery copyWith(
      {String? type,
      int? ratting,
      double? price,
      double? mrp,
      int? scrap,
      String? warranty}) {
    return Battery(
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
      'type': type,
      'ratting': ratting,
      'price': price,
      'mrp': mrp,
      'scrap': scrap,
      'warranty': warranty,
    };
  }

  factory Battery.fromMap(Map<String, dynamic> map) {
    return Battery(
        type: map['type'],
        ratting: map['ratting'],
        price: map['price'],
        mrp: map['mrp'],
        scrap: map['scrap'],
        warranty: map['warranty']);
  }

  String toJson() => json.encode(toMap());

  factory Battery.fromJson(String source) =>
      Battery.fromMap(json.decode(source));

  @override
  bool get stringify => true;
}
