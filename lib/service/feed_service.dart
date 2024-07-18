import 'dart:io' as io;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:motd/main.dart';
import 'package:motd/service/model/feed_model.dart';
import 'package:motd/service/model/feed_response.dart';
import 'package:motd/service/feed_query.dart';

class FeedService {
  final FirebaseFirestore db = FirebaseFirestore.instance;
  final FirebaseStorage storage = FirebaseStorage.instance;

  void postFeed(FeedModel feed) async {
    final String dateTime = DateTime.now().millisecondsSinceEpoch.toString();
    final String imageUrl = await _uploadImage(dateTime, feed.image);

    CollectionReference feedsRef = db.collection('feeds');
    try {
      // 정보를 추가할 때, 자동으로 생성된 ID를 사용
      await feedsRef
          .add(FeedResponse(
            content: feed.content,
            imageUrl: imageUrl,
            dateTime: Timestamp.now(),
          ).toJson())
          .then(
            (docSnapshot) => logger.d('Added data with ID: ${docSnapshot.id}'),
          );
    } catch (e) {
      logger.e('Error adding document: $e');
    }
  }

  Future<String> _uploadImage(String dateTime, XFile imageFile) async {
    final imageRef = storage.ref("feed_image/motd_$dateTime");
    final metadata = SettableMetadata(contentType: "image/jpeg");

    UploadTask uploadTask;
    if (kIsWeb) {
      uploadTask = imageRef.putData(await imageFile.readAsBytes(), metadata);
    } else {
      uploadTask = imageRef.putFile(io.File(imageFile.path), metadata);
    }

    final snapshot = await uploadTask.whenComplete(() => null);
    return snapshot.ref.getDownloadURL();
  }

  /// A reference to the list of feeds.
  /// We are using `withConverter` to ensure that interactions with the collection
  /// are type-safe.
  Stream<QuerySnapshot<FeedResponse>> getFeedStream(FeedQuery query) {
    return FirebaseFirestore.instance
        .collection('feeds')
        .withConverter<FeedResponse>(
      fromFirestore: (snapshots, _) {
        return FeedResponse.fromJson(snapshots.data()!);
      },
      toFirestore: (feed, _) {
        logger.d(feed);
        return feed.toJson();
      },
    ).snapshots();
  }
}

extension on Query<FeedResponse> {
  /// Create a firebase query from a [FeedQuery]
  Query<FeedResponse> queryBy(FeedQuery query) {
    switch (query) {
      case FeedQuery.w4m:
        return where('likes', arrayContainsAny: ['w4m']);

      case FeedQuery.childrenCenter:
        return where('likes', arrayContainsAny: ['childrenCenter']);

      case FeedQuery.senior:
        return where('likes', arrayContainsAny: ['senior']);

      case FeedQuery.recent:
        return orderBy('dateTime', descending: true);
    }
  }
}
