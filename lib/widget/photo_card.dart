import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:motd/service/model/feed_response.dart';
import 'package:motd/widget/image_placeholder.dart';

class PhotoCard extends StatelessWidget {
  final FeedResponse photoModel;

  const PhotoCard({
    super.key,
    required this.photoModel,
  });

  @override
  Widget build(BuildContext context) {
    return photoModel.content.isNotEmpty
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _renderPhotoCard(photoModel.imageUrl),
              // _renderContent(photoModel.content),
            ],
          ) // image and content
        : Card(
            elevation: 0,
            clipBehavior: Clip.hardEdge,
            child: CachedNetworkImage(
              fit: BoxFit.cover,
              placeholder: (context, url) => const ImagePlaceholder(),
              imageUrl: photoModel.imageUrl,
            ), // image only
          );
  }

  Container _renderContent(String content) {
    return Container(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 6),
        child: Text(
          textAlign: TextAlign.start,
          content,
          maxLines: 3,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w300,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    );
  }

  Card _renderPhotoCard(String imageUrl) {
    return Card(
      elevation: 0,
      clipBehavior: Clip.hardEdge,
      child: Align(
        alignment: Alignment.topCenter,
        child: CachedNetworkImage(
          fit: BoxFit.contain,
          placeholder: (context, url) => const ImagePlaceholder(),
          imageUrl: imageUrl,
        ),
      ),
    );
  }
}
