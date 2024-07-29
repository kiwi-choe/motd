import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_cached_image/firebase_cached_image.dart';
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

  // Image _renderFirebaseCachedImage(String imageUrl) {
  //   return Image(
  //     image: FirebaseImageProvider(
  //       FirebaseUrl(imageUrl),
  //       // Specify CacheOptions to control file fetching and caching behavior.
  //       options: const CacheOptions(
  //         // Always fetch the latest file from the server and do not cache the file.
  //         // default is Source.cacheServer which will fetch try to fetch the image from the cache and then hit server if the image not found in the cache.
  //         source: Source.server,
  //         // Check if the image is updated on the server or not, if updated then download the latest image otherwise use the cached image.
  //         // Will only be used if the options.source is Source.cacheServer
  //         // checkIfFileUpdatedOnServer: true,
  //       ),
  //       // Use this to save files in desired directory in system's temporary directory
  //       // Optional. default is "flutter_cached_image"
  //       // subDir: "custom_cache_directory",
  //     ),
  //     // errorBuilder: (context, error, stackTrace) {
  //     //   // [ImageNotFoundException] will be thrown if image does not exist on server.
  //     //   if (error is ImageNotFoundException) {
  //     //     return const Text('Image not found on Cloud Storage.');
  //     //   } else {
  //     //     return Text('Error loading image: $error');
  //     //   }
  //     // },
  //     // The loading progress may not be accurate as Firebase Storage API
  //     // does not provide a stream of bytes downloaded. The progress updates only at the start and end of the loading process.
  //     loadingBuilder: (_, Widget child, ImageChunkEvent? loadingProgress) {
  //       if (loadingProgress == null) {
  //         // Show the loaded image if loading is complete.
  //         return child;
  //       } else {
  //         return const CircularProgressIndicator();
  //       }
  //     },
  //   );
  // }
}
