import 'package:flutter/material.dart';

class RecentScreen extends StatelessWidget {
  const RecentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) {
          print('index: $index');
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              color: Colors.amber,
              height: 50,
              child: const Column(
                children: [
                  Icon(
                    Icons.ac_unit_sharp,
                  ),
                  Text("#MOTD #워킹포미라클"),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
