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
              padding:
                  const EdgeInsets.symmetric(vertical: 32.0, horizontal: 24.0),
              child: Container(
                alignment: Alignment.topCenter,
                child: const Text(
                  "작은 섬김이 큰 기적을,\n삶의 자리에서 함께 하는 기적의 릴레이입니다.\n\n"
                  "매일 매일 선한 일을 하면서 살아가면 좋겠지만\n뜻대로 되지 않는다면\n목요일 하루만이라도 함께 선한 것을 꿈꾸고 시도해 봅시다.\n\n"
                  "작고 사소해 보이는 섬김이\n하나님의 손에 들리면\n크고 아름다운 기적으로 열매 맺게 될 거에요.\n\n"
                  "마치 소년의 도시락이\n오병이어의 기적이 된 것 처럼 말이에요.\n\n"
                  "오늘은 일주일의 하루,\n‘목요일의 기적’을 꿈꾸지만\n나중에는 날마다 기적의 씨앗을 심는 삶으로,\n그렇게 살아가기를 바랍니다.\n\n"
                  "2024년 여름 ‘miracles on thursday’에 초대합니다.\n\n",
                  style: TextStyle(fontSize: 18),
                ),
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
