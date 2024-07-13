import 'package:flutter/material.dart';
import 'package:motd/screens/motd_screen.dart';
import 'package:motd/screens/notice_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  final List<Widget> _tabs = const [
    NoticeScreen(),
    MotdScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _tabs.length,
      child: Scaffold(
        appBar: AppBar(
          actions: const [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Icon(Icons.question_mark_rounded),
            ),
          ],
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          flexibleSpace: SafeArea(
            child: Container(
              alignment: Alignment.center,
              child: _getTabBar(),
            ),
          ),
          elevation: 0,
        ),
        body: TabBarView(
          children: _tabs,
        ),
      ),
    );
  }

  TabBar _getTabBar() {
    return const TabBar(
      tabs: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8),
          child: Tab(text: '공지'),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8),
          child: Tab(text: 'MOTD'),
        ),
      ],
      tabAlignment: TabAlignment.center,
      dividerHeight: 0,
    );
  }
}
