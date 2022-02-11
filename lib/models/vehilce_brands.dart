import 'dart:convert';

import 'package:equatable/equatable.dart';

class VehicleBrand extends Equatable {
  final String? name;
  final String? logoUrl;
  final String? id;

  const VehicleBrand({
    required this.name,
    required this.logoUrl,
    required this.id,
  });

  @override
  List<Object?> get props => [name, logoUrl, id];

  VehicleBrand copyWith({
    String? name,
    String? logo,
    String? id,
  }) {
    return VehicleBrand(
      name: name ?? this.name,
      logoUrl: logo ?? logoUrl,
      id: id ?? this.id,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'logoUrl': logoUrl,
      'id': id,
    };
  }

  factory VehicleBrand.fromMap(Map<String, dynamic>? map) {
    return VehicleBrand(
      name: map?['name'],
      logoUrl: map?['logoUrl'],
      id: map?['id'],
    );
  }

  String toJson() => json.encode(toMap());

  factory VehicleBrand.fromJson(String source) =>
      VehicleBrand.fromMap(json.decode(source));

  @override
  bool get stringify => true;
}
