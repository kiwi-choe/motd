import 'package:flutter/material.dart';

@immutable
class NoticeResponse {
  final String? name;
  final String? description;
  final String? imageUrl;
  final String? redirectUrl;

  const NoticeResponse({
    required this.name,
    this.description,
    this.imageUrl,
    this.redirectUrl,
  });

  @override
  String toString() {
    return "name: $name\n description: $description\n imageUrl: $imageUrl\n redirectUrl: $redirectUrl";
  }

  NoticeResponse.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        description = json['description'],
        imageUrl = json['imageUrl'],
        redirectUrl = json['redirectUrl'];

  Map<String, dynamic> toJson() => {
        'name': name,
        'description': description,
        'imageUrl': imageUrl,
        'redirectUrl': redirectUrl,
      };
}
