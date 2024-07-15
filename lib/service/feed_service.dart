import 'dart:convert';
import 'dart:io' as io;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:motd/service/model/feed_model.dart';
import 'package:motd/service/model/feed_response.dart';
import 'package:motd/service/feed_query.dart';

class FeedService {
  // todo change to firebase service
  // final String baseUrl = "https://picsum.photos/"
  final String baseUrl = "https://official-joke-api.appspot.com/random_joke";
  final String photo = "200";

  final FirebaseFirestore db = FirebaseFirestore.instance;
  // final FirebaseStorage storage = FirebaseStorage.instance;

  // image upload
  final storageRef = FirebaseStorage.instance.ref();

  // void getPhotos({FeedQuery? type = FeedQuery.recent}) async {
  //   // final url = Uri.parse('$baseUrl/$photo');
  //   final url = Uri.parse(baseUrl);
  //   final response = await http.get(url);
  //   if (response.statusCode == 200) {
  //     final result = jsonDecode(response.body);
  //     final json = FeedResponse.fromJson(result);
  //     print(json);
  //     return;
  //   }
  //   throw Error();
  // }

  void getFeeds() {
    db.collection("feeds").get().then(
      (querySnapshot) {
        print("Successfully completed");
        for (var docSnapshot in querySnapshot.docs) {
          print('${docSnapshot.id} => ${docSnapshot.data()}');
        }
      },
      onError: (e) => print("Error completing: $e"),
    );
  }

  /// A reference to the list of movies.
  /// We are using `withConverter` to ensure that interactions with the collection
  /// are type-safe.
  final getFeedsRef = FirebaseFirestore.instance
      .collection('feeds')
      .withConverter<FeedResponse>(
        fromFirestore: (snapshots, _) =>
            FeedResponse.fromJson(snapshots.data()!),
        toFirestore: (feed, _) => feed.toJson(),
      );

  void postFeed(FeedModel feed) async {
    CollectionReference feedsRef = db.collection('feeds');

    // 이미지 업로드
    final String imageUrl = await uploadImage(feed.image);

    try {
      // 정보를 추가할 때, 자동으로 생성된 ID를 사용
      await feedsRef
          .add(FeedResponse(
            content: feed.content,
            imageUrl: imageUrl,
          ).toJson())
          .then(
            (docSnapshot) =>
                debugPrint('Added data with ID: ${docSnapshot.id}'),
          );
    } catch (e) {
      debugPrint('Error adding document: $e');
    }
  }

  Future<String> uploadImage(io.File imageFile) async {
    final String dateTime = DateTime.now().millisecondsSinceEpoch.toString();
    final imageRef = storageRef.child("feed_image/motd_$dateTime");

    final metadata = SettableMetadata(contentType: 'image/jpeg');

    UploadTask uploadTask;
    if (kIsWeb) {
      uploadTask = imageRef.putData(await imageFile.readAsBytes(), metadata);
    } else {
      uploadTask = imageRef.putFile(io.File(imageFile.path));
    }

    // return await uploadTask.whenComplete(() => null);
    final snapshot = await uploadTask.whenComplete(() => null);
    return snapshot.ref.getDownloadURL();
  }
}

extension on Query<FeedResponse> {
  /// Create a firebase query from a [MovieQuery]
  Query<FeedResponse> queryBy(FeedQuery query) {
    switch (query) {
      case FeedQuery.w4m:
        return where('likes', arrayContainsAny: ['w4m']);

      case FeedQuery.childrenCenter:
        return where('likes', arrayContainsAny: ['childrenCenter']);

      case FeedQuery.senior:
        return where('likes', arrayContainsAny: ['senior']);

      case FeedQuery.recent:
        return orderBy('recent', descending: true);
    }
  }
}
