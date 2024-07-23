import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

@immutable
class W4mResponse {
  final String? name;
  final int? phoneNumber;
  final String? place;
  final int? walkCount;
  final int? totalWalkCount;
  final Timestamp? dateTime;

  const W4mResponse({
    required this.name,
    required this.phoneNumber,
    this.place,
    required this.walkCount,
    required this.totalWalkCount,
    required this.dateTime,
  });

  W4mResponse.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        phoneNumber = json['phoneNumber'] as int,
        place = json['place'],
        walkCount = json['walkCount'] as int,
        totalWalkCount = json['totalWalkCount'] as int,
        dateTime = json['dateTime'] as Timestamp;

  Map<String, dynamic> toJson() => {
        'name': name,
        'phoneNumber': phoneNumber,
        'place': place,
        'walkCount': walkCount,
        'totalWalkCount': totalWalkCount,
        'dateTime': dateTime,
      };
}
