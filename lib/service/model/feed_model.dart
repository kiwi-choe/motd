import 'dart:io';

class FeedModel {
  final File image;
  final String content;

  const FeedModel(
    this.image,
    this.content,
  );

  Map<String, dynamic> toJson() {
    return {
      'image': image,
      'content': content,
    };
  }
}
