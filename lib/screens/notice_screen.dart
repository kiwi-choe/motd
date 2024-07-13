import 'package:flutter/material.dart';

class NoticeScreen extends StatelessWidget {
  const NoticeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        children: [
          NoticeCard(
            title: "Miracle On Thursday in summer이 뭐징",
            color: Colors.purple,
          ),
          SizedBox(
            height: 8,
          ),
          NoticeCard(title: "7월 25일 워킹포미라클"),
          SizedBox(
            height: 8,
          ),
          NoticeCard(title: "8월 15일 장애아동센터 방문"),
          SizedBox(
            height: 8,
          ),
          NoticeCard(title: "8월 25일 ~~~~~~~~~"),
        ],
      ),
    );
  }
}

class NoticeCard extends StatelessWidget {
  final String title;
  final Color? color;

  const NoticeCard({
    super.key,
    required this.title,
    this.color = Colors.blue,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: color?.withOpacity(0.5),
      child: InkWell(
        splashColor: color?.withAlpha(30),
        onTap: () {
          debugPrint('Card tapped.');
        },
        child: Container(
          alignment: Alignment.center,
          width: double.infinity,
          height: 100,
          child: Text(title),
        ),
      ),
    );
  }
}
