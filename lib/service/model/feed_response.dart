import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

@immutable
class FeedResponse {
  final String imageUrl;
  final String content;
  final Timestamp dateTime;

  const FeedResponse({
    required this.imageUrl,
    required this.content,
    required this.dateTime,
  });

// named constructor
  FeedResponse.fromJson(Map<String, dynamic> json)
      : this(
          imageUrl: json['imageUrl'] as String,
          content: json['content'] as String,
          dateTime: json["dateTime"],
        );

  Map<String, dynamic> toJson() {
    return {
      'imageUrl': imageUrl,
      'content': content,
      "dateTime": dateTime,
    };
  }
}
