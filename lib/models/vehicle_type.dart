import 'dart:convert';

import 'package:enum_to_string/enum_to_string.dart';
import 'package:equatable/equatable.dart';

enum FuelType { petrol, diesel }

class VehicleType extends Equatable {
  final FuelType? type;
  final String? imageUrl;
  VehicleType({
    required this.type,
    required this.imageUrl,
  });
  @override
  List<Object?> get props => [type, imageUrl];

  VehicleType copyWith({
    FuelType? type,
    String? imageUrl,
  }) {
    return VehicleType(
      type: type ?? this.type,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }

  Map<String, dynamic> toMap() {
    final fuleType = EnumToString.convertToString(type);
    return {
      'type': fuleType,
      'imageUrl': imageUrl,
    };
  }

  factory VehicleType.fromMap(Map<String, dynamic> map) {
    final fuleType = EnumToString.fromString(FuelType.values, map['type']);
    return VehicleType(
      type: fuleType,
      imageUrl: map['imageUrl'],
    );
  }

  String toJson() => json.encode(toMap());

  factory VehicleType.fromJson(String source) =>
      VehicleType.fromMap(json.decode(source));

  @override
  bool get stringify => true;
}
