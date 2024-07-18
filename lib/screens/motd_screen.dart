import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:motd/screens/photo_editor/photo_editor_screen.dart';
import 'package:motd/service/feed_query.dart';
import 'package:motd/service/feed_service.dart';
import 'package:motd/service/model/feed_model.dart';
import 'package:motd/service/model/feed_response.dart';

class MotdScreen extends StatefulWidget {
  const MotdScreen({super.key});

  @override
  State<MotdScreen> createState() => _MotdScreenState();
}

class _MotdScreenState extends State<MotdScreen> {
  // late final AppLifecycleListener _listener;
  // late AppLifecycleState? _state;

  final FeedService _feedService = FeedService();
  var scroll = ScrollController();
  @override
  void initState() {
    super.initState();

    // _state = SchedulerBinding.instance.lifecycleState;
    // _listener = AppLifecycleListener(
    //   onResume: () {
    //     FeedService().getFeedStream(FeedQuery.recent);
    //   },
    // );
  }

  @override
  void dispose() {
    // _listener.dispose();
    super.dispose();
  }

  List<FeedModel> photoCards = [];
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
      // photoCards.add(result as FeedModel);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            const SizedBox(width: 16),
            FloatingActionButton(
              onPressed: () {
                _navigateAndDisplaySelection(context);
              },
              child: const Icon(Icons.add),
            ),
          ],
        ),
        backgroundColor: Colors.white,
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
            return GridView.builder(
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
                  child: Image.network(data.docs[index].data().imageUrl),
                );

                // return Padding(
                //   padding: const EdgeInsets.all(8.0),
                //   child: PhotoCard(photoModel: data.docs[index].data()),
                // );
              },
            );
            // return Column(
            //   children: [PhotoCard(photoModel: data.docs.first.data())],
            // );
          },
        )

        // Expanded(
        //   child: GridView.builder(
        //     gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        //       crossAxisCount: 2,
        //     ),
        //     scrollDirection: Axis.vertical,
        //     itemCount: 8,
        //     itemBuilder: (context, index) {
        //       debugPrint('index: $index');
        //       return Padding(
        //         padding: const EdgeInsets.all(8.0),
        //         // child: PhotoCard(photoModel: photoCards[index]),
        //         child: SizedBox(
        //           height: 50,
        //           child: Container(
        //               color: Colors.lightBlue[50],
        //               child: const Text("test!!")),
        //         ),
        //       );
        //     },
        //   ),
        // ),

        );
  }
}
