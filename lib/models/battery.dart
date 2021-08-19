import 'dart:convert';

import 'package:equatable/equatable.dart';

class Battery extends Equatable {
  final String? name;
  final String? imageUrl;

  Battery({
    required this.name,
    required this.imageUrl,
  });

  @override
  List<Object?> get props => [name, imageUrl];

  Battery copyWith({
    String? name,
    String? imageUrl,
  }) {
    return Battery(
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

  factory Battery.fromMap(Map<String, dynamic> map) {
    return Battery(
      name: map['name'],
      imageUrl: map['imageUrl'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Battery.fromJson(String source) =>
      Battery.fromMap(json.decode(source));

  @override
  bool get stringify => true;
}
