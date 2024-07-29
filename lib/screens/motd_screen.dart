import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:motd/screens/photo_editor/photo_editor_screen.dart';
import 'package:motd/service/feed_query.dart';
import 'package:motd/service/feed_service.dart';
import 'package:motd/service/model/feed_response.dart';
import 'package:motd/widget/photo_card.dart';

class MotdScreen extends StatefulWidget {
  const MotdScreen({super.key});

  @override
  State<MotdScreen> createState() => _MotdScreenState();
}

class _MotdScreenState extends State<MotdScreen>
    with AutomaticKeepAliveClientMixin {
  final FeedService _feedService = FeedService();
  // FeedQuery query = FeedQuery.recent;

  @override
  bool get wantKeepAlive => true;

  Future<void> _navigateAndDisplaySelection(BuildContext context) async {
    // Navigator.push returns a Future that completes after calling
    // Navigator.pop on the Selection Screen.
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const PhotoEditorScreen()),
    );
    setState(() {
      debugPrint("navigate pop result: $result");
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.yellow,
        foregroundColor: const Color(0xFF2f72ba),
        onPressed: () {
          _navigateAndDisplaySelection(context);
        },
        child: const Icon(
          Icons.add,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      body: FirestoreQueryBuilder<FeedResponse>(
        query: _feedService.getFeeds,
        builder: (context, snapshot, _) {
          return AlignedGridView.count(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 32,
            ),
            crossAxisCount: 2,
            mainAxisSpacing: 4,
            scrollDirection: Axis.vertical,
            crossAxisSpacing: 4,
            itemCount: snapshot.docs.length,
            itemBuilder: (context, index) {
              // if we reached the end of the currently obtained items, we try to
              // obtain more items
              if (snapshot.hasMore && index + 1 == snapshot.docs.length) {
                // Tell FirestoreQueryBuilder to try to obtain more items.
                // It is safe to call this function from within the build method.
                snapshot.fetchMore();
              }

              final feed = snapshot.docs[index].data();

              return PhotoCard(photoModel: feed);
            },
          );
        },
      ),
    );
  }

  Padding _errorView() {
    return Padding(
      padding: const EdgeInsets.only(right: 16.0),
      child: Container(
        alignment: Alignment.center,
        child: Image.asset('assets/images/m.png'),
      ),
    );
  }
}
