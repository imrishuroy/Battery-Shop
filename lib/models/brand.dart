import 'dart:convert';

import 'package:equatable/equatable.dart';

class Brand extends Equatable {
  final String? name;
  final String? logoUrl;
  final String? id;

  Brand({
    required this.name,
    required this.logoUrl,
    required this.id,
  });

  @override
  List<Object?> get props => [name, logoUrl, id];

  Brand copyWith({
    String? name,
    String? logo,
    String? id,
  }) {
    return Brand(
      name: name ?? this.name,
      logoUrl: logo ?? this.logoUrl,
      id: id ?? this.id,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'logo': logoUrl,
      'id': id,
    };
  }

  factory Brand.fromMap(Map<String, dynamic>? map) {
    return Brand(
      name: map?['name'],
      logoUrl: map?['logoUrl'],
      id: map?['id'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Brand.fromJson(String source) => Brand.fromMap(json.decode(source));

  @override
  bool get stringify => true;
}
