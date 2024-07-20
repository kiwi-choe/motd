import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:motd/main.dart';
import 'package:motd/service/model/w4m_model.dart';
import 'package:motd/service/model/w4m_response.dart';

class W4mService {
  final CollectionReference walklogRef =
      FirebaseFirestore.instance.collection('w4m-walklog');

  /// A reference to the list of walklog.
  /// We are using `withConverter` to ensure that interactions with the collection
  /// are type-safe.
  Stream<QuerySnapshot<W4mResponse>> getW4mStream() {
    return walklogRef
        .withConverter<W4mResponse>(
          fromFirestore: (snapshots, _) {
            return W4mResponse.fromJson(snapshots.data()!);
          },
          toFirestore: (w4m, _) {
            logger.d(w4m.toString());
            return w4m.toJson();
          },
        )
        .orderBy("dateTime", descending: true)
        .snapshots();
  }

  void postWalkLog(W4mModel model) async {
    try {
      // get the totalWalkCount of the most recent doc before post walkLog
      final QuerySnapshot querySnapshot =
          await walklogRef.orderBy('dateTime', descending: true).limit(1).get();

      if (querySnapshot.docs.isNotEmpty) {
        var lastDoc = querySnapshot.docs.first;

        FirebaseFirestore.instance.runTransaction((transaction) async {
          final snapshot = await transaction.get(lastDoc.reference);
          int totalWalkCount = snapshot.get("totalWalkCount");

          // post walkLog
          await walklogRef
              .add(
                W4mResponse(
                  name: model.name,
                  phoneNumber: model.phoneNumber,
                  place: model.place,
                  walkCount: model.walkCount,
                  totalWalkCount: totalWalkCount + model.walkCount,
                  dateTime: Timestamp.now(),
                ).toJson(),
              )
              .then(
                (docSnapshot) =>
                    logger.d('Added data with ID: ${docSnapshot.id}'),
              );
        }).then((value) => logger.d("Success to post walklog"),
            onError: (e) => logger.e("error Post walklog $e"));
      } else {
        // rollback the trasaction
        throw "no document found";
      }
    } catch (e) {
      logger.e('Error adding document: $e');
    }
  }
}
