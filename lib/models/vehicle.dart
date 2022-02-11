import 'dart:convert';

import 'package:equatable/equatable.dart';

class Vehicle extends Equatable {
  final String? vehicleId;
  final String? name;
  final String? imageUrl;

  const Vehicle({
    required this.vehicleId,
    required this.name,
    required this.imageUrl,
  });

  @override
  List<Object?> get props => [name, imageUrl, vehicleId];

  Vehicle copyWith({
    String? name,
    String? imageUrl,
    String? vehicleId,
  }) {
    return Vehicle(
      vehicleId: vehicleId ?? this.vehicleId,
      name: name ?? this.name,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'vehicleId': vehicleId,
      'name': name,
      'imageUrl': imageUrl,
    };
  }

  factory Vehicle.fromMap(Map<String, dynamic> map) {
    return Vehicle(
      vehicleId: map['vehicleId'],
      name: map['name'],
      imageUrl: map['imageUrl'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Vehicle.fromJson(String source) =>
      Vehicle.fromMap(json.decode(source));

  @override
  bool get stringify => true;
}
