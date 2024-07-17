import 'package:image_picker/image_picker.dart';

class FeedModel {
  final XFile image;
  final String imagePath;
  final String content;

  const FeedModel(
    this.image,
    this.imagePath,
    this.content,
  );

  // Map<String, dynamic> toJson() {
  //   return {
  //     'image': image,
  //     'content': content,
  //   };
  // }
}
