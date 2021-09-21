import 'dart:convert';

import 'package:equatable/equatable.dart';

class InverterWave extends Equatable {
  final String model;
  final int dealerPrice;
  final int mrp;

  const InverterWave({
    required this.model,
    required this.dealerPrice,
    required this.mrp,
  });

  InverterWave copyWith({
    String? model,
    int? dealerPrice,
    int? mrp,
  }) {
    return InverterWave(
      model: model ?? this.model,
      dealerPrice: dealerPrice ?? this.dealerPrice,
      mrp: mrp ?? this.mrp,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'model': model,
      'dealerPrice': dealerPrice,
      'mrp': mrp,
    };
  }

  factory InverterWave.fromMap(Map<String, dynamic> map) {
    return InverterWave(
      model: map['model'],
      dealerPrice: map['dealer_price'],
      mrp: map['mrp'],
    );
  }

  String toJson() => json.encode(toMap());

  factory InverterWave.fromJson(String source) =>
      InverterWave.fromMap(json.decode(source));

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [model, dealerPrice, mrp];
}
