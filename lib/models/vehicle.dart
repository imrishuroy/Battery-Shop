import 'dart:convert';

import 'package:equatable/equatable.dart';

class Vehicle extends Equatable {
  final String? name;
  final String? imageUrl;

  Vehicle({
    required this.name,
    required this.imageUrl,
  });

  @override
  List<Object?> get props => [name, imageUrl];

  Vehicle copyWith({
    String? name,
    String? imageUrl,
  }) {
    return Vehicle(
      name: name ?? this.name,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'imageUrl': imageUrl,
    };
  }

  factory Vehicle.fromMap(Map<String, dynamic> map) {
    return Vehicle(
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
