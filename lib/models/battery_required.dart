import 'dart:convert';

import 'package:equatable/equatable.dart';

class BatteryRequired extends Equatable {
  final String? name;
  final String? imageUrl;

  BatteryRequired({
    required this.name,
    required this.imageUrl,
  });

  @override
  List<Object?> get props => [name, imageUrl];

  BatteryRequired copyWith({
    String? name,
    String? imageUrl,
  }) {
    return BatteryRequired(
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

  factory BatteryRequired.fromMap(Map<String, dynamic> map) {
    return BatteryRequired(
      name: map['name'],
      imageUrl: map['imageUrl'],
    );
  }

  String toJson() => json.encode(toMap());

  factory BatteryRequired.fromJson(String source) =>
      BatteryRequired.fromMap(json.decode(source));

  @override
  bool get stringify => true;
}
