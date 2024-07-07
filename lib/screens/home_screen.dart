import 'package:flutter/material.dart';
import 'package:motd/screens/recent_screen.dart';
import 'package:motd/widget/bottom_nav_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen(BuildContext context, {super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final int _currentIndex = 0;

  final List<Widget> _tabs = [
    const MotdScreen(),
    const RecentScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _tabs.length,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          bottom: const TabBar(
            tabs: [
              Tab(icon: Icon(Icons.home), text: 'MOTD'),
              Tab(icon: Icon(Icons.favorite), text: '최신'),
            ],
          ),
          elevation: 0,
        ),
        body: TabBarView(
          children: _tabs,
        ),
        bottomNavigationBar: const BottomNavBar(),
      ),
    );
  }
}

class MotdScreen extends StatelessWidget {
  const MotdScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Motd Screen'),
    );
  }
}
