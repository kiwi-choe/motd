import 'package:cached_network_image/cached_network_image.dart';
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
    return Card(
      elevation: 0,
      clipBehavior: Clip.hardEdge,
      child: photoModel.content.isNotEmpty
          ? Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: ClipRect(
                    child: Align(
                        alignment: Alignment.topCenter,
                        child: SizedBox.expand(
                          child: CachedNetworkImage(
                            fit: BoxFit.cover,
                            placeholder: (context, url) =>
                                const ImagePlaceholder(),
                            imageUrl: photoModel.imageUrl,
                          ),
                        )),
                  ),
                ),
                Text(
                  photoModel.content,
                  style: const TextStyle(
                    fontSize: 16,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ) // image and content
          : CachedNetworkImage(
              fit: BoxFit.cover,
              placeholder: (context, url) => const ImagePlaceholder(),
              imageUrl: photoModel.imageUrl,
            ), // image only
    );
  }
}
