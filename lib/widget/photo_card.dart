import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:motd/service/model/feed_model.dart';
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
      color: Colors.lightBlue[50],
      child: Column(
        children: [
          Container(
            color: const Color.fromRGBO(115, 115, 115, 1),
            child: Image.network(
              photoModel.imageUrl,
              fit: BoxFit.cover,
            ),
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
