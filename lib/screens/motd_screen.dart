import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
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

class _MotdScreenState extends State<MotdScreen> {
  final FeedService _feedService = FeedService();
  FeedQuery query = FeedQuery.recent;

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
      body: StreamBuilder<QuerySnapshot<FeedResponse>>(
        stream: _feedService.getFeedStream(FeedQuery.recent),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          }

          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final data = snapshot.requireData;

          if (data.size == 0) {
            return Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: Container(
                alignment: Alignment.center,
                child: Image.asset('assets/images/m.png'),
              ),
            );
          }

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: GridView.builder(
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // number of items in each row
                mainAxisSpacing: 8.0, // spacing between rows
                crossAxisSpacing: 8.0, // spacing between columns
              ),
              scrollDirection: Axis.vertical,
              itemCount: data.size,
              itemBuilder: (context, index) {
                debugPrint('index: $index');
                return GridTile(
                  child: PhotoCard(photoModel: data.docs[index].data()),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
