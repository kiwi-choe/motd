import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:motd/service/model/feed_model.dart';

class PhotoCard extends StatelessWidget {
  final FeedModel photoModel;

  const PhotoCard({
    super.key,
    required this.photoModel,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.lightBlue[50],
      child: Column(
        children: [
          kIsWeb
              ? Image.network(
                  photoModel.image.path,
                  fit: BoxFit.fill,
                  height: 200,
                )
              : Image.file(
                  File(photoModel.image.path),
                  fit: BoxFit.fill,
                  height: 200,
                ),
          Text(
            photoModel.content,
            style: const TextStyle(overflow: TextOverflow.ellipsis),
          ),
        ],
      ),
    );
  }
}
