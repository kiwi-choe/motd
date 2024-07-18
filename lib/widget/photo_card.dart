
import 'package:flutter/material.dart';
import 'package:motd/service/model/feed_response.dart';

class PhotoCard extends StatelessWidget {
  final FeedResponse photoModel;

  const PhotoCard({
    super.key,
    required this.photoModel,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(12.0),
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        gradient: const RadialGradient(
          colors: <Color>[Color(0x0F88EEFF), Color(0x2F0099BB)],
        ),
      ),
      child: Column(
        children: [
          Image.network(
            photoModel.imageUrl,
          ),
          // Image.network(
          //   photoModel.imageUrl,
          //   fit: BoxFit.fill,
          // ),
          Text(
            photoModel.content,
            style: const TextStyle(overflow: TextOverflow.ellipsis),
          ),
        ],
      ),
    );
  }
}
