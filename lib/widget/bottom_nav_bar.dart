import 'package:flutter/material.dart';
import 'package:motd/widget/category_menu.dart';
import 'package:motd/widget/menu_type.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _selectedIndex = 0;
  // static const TextStyle optionStyle =
  //     TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
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

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;

      if (index == BottomMenu.category.index) {
        showModalBottomSheet<void>(
          context: context,
          builder: (BuildContext conetxt) {
            return const SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                child: CategoryMenu(),
              ),
            );
          },
        );
      } else if (index == BottomMenu.add.index) {
        const snackBar = SnackBar(content: Text("인증 올리기~~"));
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      } else if (index == BottomMenu.qna.index) {
        const snackBar = SnackBar(content: Text("궁금한 거 물어보세요~~"));
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.menu_rounded),
          label: "categories",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.add_circle_outline_outlined),
          label: "add",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.question_answer_rounded),
          label: '문의사항',
        ),
      ],
      showSelectedLabels: false,
      showUnselectedLabels: false,
      currentIndex: _selectedIndex,
      selectedItemColor: Colors.amber[800],
      onTap: _onItemTapped,
    );
  }
}
