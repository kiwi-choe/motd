import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:motd/main.dart';
import 'package:motd/screens/detail/children_center_detail_screen.dart';
import 'package:motd/screens/detail/senior_detail_screen.dart';
import 'package:motd/screens/detail/w4m_detail_screen.dart';
import 'package:motd/service/model/notice_response.dart';
import 'package:motd/service/notice_service.dart';
import 'package:motd/widget/image_placeholder.dart';

class NoticeScreen extends StatefulWidget {
  const NoticeScreen({super.key});

  @override
  State<NoticeScreen> createState() => _NoticeScreenState();
}

class _NoticeScreenState extends State<NoticeScreen> {
  final NoticeService _service = NoticeService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot<NoticeResponse>>(
        stream: _service.getNoticeStream(),
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
          logger.d("notice data: ${data.docs.first.data().toString()}");

          return ListView.separated(
              separatorBuilder: (BuildContext context, int index) {
                return const SizedBox(height: 16);
              },
              padding: const EdgeInsets.all(16),
              itemCount: data.size,
              itemBuilder: (context, index) {
                logger.d("notice: $index");
                return data.size > 0
                    ? NoticeCard(
                        notice: data.docs[index].data(),
                      )
                    : const Center(
                        child: Text("there is no notice"),
                      );
              });
        },
      ),
    );
  }
}

class NoticeCard extends StatelessWidget {
  final NoticeResponse notice;

  const NoticeCard({
    super.key,
    required this.notice,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      color: Colors.grey.shade200,
      clipBehavior: Clip.hardEdge,
      child: SizedBox(
        height: 150,
        child: Stack(
          children: [
            notice.imageUrl?.isNotEmpty == true
                ? SizedBox.expand(
                    child: CachedNetworkImage(
                      fit: BoxFit.cover,
                      placeholder: (context, url) => const ImagePlaceholder(),
                      imageUrl: notice.imageUrl!,
                    ),
                  )
                : notice.name?.isNotEmpty == true
                    ? Center(
                        child: Text(
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                          notice.name != null ? notice.name! : "",
                        ),
                      )
                    : const Text(""),
            GestureDetector(
              onTap: () => navigateToDetailScreen(context),
            )
          ],
        ),
      ),
    );
  }

  Future<Widget?>? navigateToDetailScreen(BuildContext context) {
    if (notice.name == "w4m") {
      return Navigator.push(context,
          MaterialPageRoute(builder: (context) => const W4mDetailScreen()));
    } else {
      return null;
    }
    // todo detail page 만들기
    // return Navigator.push(
    //   context,
    //   MaterialPageRoute<Widget>(
    //     builder: (BuildContext context) {
    //       switch (notice.name) {
    //         case "w4m":
    //           return const W4mDetailScreen();

    //         case "senior":
    //           return const SeniorDetailScreen();

    //         case "childrenCenter":
    //           return const ChildrenCenterDetailScreen();

    //         default:
    //           return const Text("default detail screen");
    //       }
    //     },
    //   ),
    // );
  }
}
