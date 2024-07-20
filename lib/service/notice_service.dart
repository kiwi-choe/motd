import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:motd/main.dart';
import 'package:motd/service/model/notice_response.dart';

class NoticeService {
  final FirebaseFirestore db = FirebaseFirestore.instance;

  /// A reference to the list of feeds.
  /// We are using `withConverter` to ensure that interactions with the collection
  /// are type-safe.
  Stream<QuerySnapshot<NoticeResponse>> getNoticeStream() {
    return FirebaseFirestore.instance
        .collection('notices')
        .withConverter<NoticeResponse>(
          fromFirestore: (snapshots, _) {
            return NoticeResponse.fromJson(snapshots.data()!);
          },
          toFirestore: (notice, _) {
            logger.d(notice);
            return notice.toJson();
          },
        )
        .where("active", isEqualTo: true)
        .snapshots();
  }
}
