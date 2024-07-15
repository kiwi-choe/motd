import 'package:flutter/foundation.dart';

@immutable
class FeedResponse {
  final String imageUrl;
  final String content;

  const FeedResponse({
    required this.imageUrl,
    required this.content,
  });

// named constructor
  FeedResponse.fromJson(Map<String, dynamic> json)
      : this(
          imageUrl: json['imageUrl'] as String,
          content: json['content'] as String,
        );

  Map<String, Object?> toJson() {
    return {
      'imageUrl': imageUrl,
      'content': content,
    };
  }
}
