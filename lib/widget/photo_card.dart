import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:motd/service/model/feed_response.dart';
import 'package:motd/widget/image_placeholder.dart';

class PhotoCard extends StatefulWidget {
  final FeedResponse photoModel;

  const PhotoCard({
    super.key,
    required this.photoModel,
  });

  @override
  State<PhotoCard> createState() => _PhotoCardState();
}

class _PhotoCardState extends State<PhotoCard> {
  @override
  Widget build(BuildContext context) {
    // Image path from Firebase Storage
    var imagePath = widget.photoModel.imageUrl;

    return widget.photoModel.content.isNotEmpty
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _renderPhotoCard(imagePath),
              // _renderContent(photoModel.content),
            ],
          ) // image and content
        : _renderPhotoCard(imagePath);
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
          errorWidget: (context, url, error) =>
              const Icon(Icons.error_outline_outlined),
        ),
      ),
    );
  }
}
