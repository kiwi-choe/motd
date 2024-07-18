import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:motd/main.dart';
import 'package:motd/service/model/notice_response.dart';
import 'package:motd/service/notice_service.dart';

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

          return ListView.builder(
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
      color: Colors.blue.withOpacity(0.5),
      child: ListTile(
        title: Text(notice.toString()),
      ),
    );
  }
}
