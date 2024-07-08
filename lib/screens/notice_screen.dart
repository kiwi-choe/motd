import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class NoticeScreen extends StatelessWidget {
  const NoticeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        children: [
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

  const NoticeCard({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.blue[100],
      child: InkWell(
        splashColor: Colors.blue.withAlpha(30),
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

  // static const List<Widget> _widgetOptions = <Widget>[
  //   Text(
  //     'Index 0: Home',
  //     style: optionStyle,
  //   ),
  //   Text(
  //     'Index 1: Business',
  //     style: optionStyle,
  //   ),
  //   Text(
  //     'Index 2: School',
  //     style: optionStyle,
  //   ),
  // ];
