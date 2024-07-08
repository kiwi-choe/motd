import 'package:flutter/material.dart';
import 'package:motd/widget/photo_card.dart';

class MotdScreen extends StatelessWidget {
  const MotdScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          const SizedBox(width: 16),
          FloatingActionButton(
            onPressed: () {
              // Add your onPressed code here!
            },
            child: const Icon(Icons.add),
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) {
                debugPrint('index: $index');
                return const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: PhotoCard(),
                );
              },
            ),
          ),
          Card.filled(
            color: Colors.purple[100],
            child: Container(
              alignment: Alignment.center,
              width: double.infinity,
              child: const Padding(
                padding: EdgeInsets.symmetric(vertical: 24.0),
                child: Text(
                  'Miracle On Thursday in summer',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
