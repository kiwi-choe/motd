import 'package:flutter/material.dart';
import 'package:motd/screens/guide_screen.dart';
import 'package:motd/screens/motd_screen.dart';
import 'package:motd/screens/notice_screen.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Widget> _tabs = const [
    MotdScreen(),
    GuideScreen(),
    NoticeScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _tabs.length,
      child: Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              icon: const Icon(
                Icons.question_mark_rounded,
              ),
              onPressed: _onQuestionPressed,
            )
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

  void _onQuestionPressed() async {
    final kakaotalkChannelUrl = Uri.parse("https://pf.kakao.com/_nUIBxb");

    if (await canLaunchUrl(kakaotalkChannelUrl)) {
      launchUrl(kakaotalkChannelUrl);
    } else {
      throw Exception('Could not launch $kakaotalkChannelUrl');
    }
  }

  TabBar _getTabBar() {
    return const TabBar(
      labelStyle: TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: 20,
      ),
      tabs: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8),
          child: Tab(text: 'M'),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8),
          child: Tab(text: 'MOTD'),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8),
          child: Tab(text: '공지'),
        ),
      ],
      tabAlignment: TabAlignment.center,
      dividerHeight: 0,
    );
  }
}
