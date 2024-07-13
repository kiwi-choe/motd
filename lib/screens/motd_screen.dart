import 'package:flutter/material.dart';
import 'package:motd/screens/photo_editor/photo_editor_screen.dart';
import 'package:motd/service/model/photo_model.dart';
import 'package:motd/widget/photo_card.dart';

class MotdScreen extends StatefulWidget {
  const MotdScreen({super.key});

  @override
  State<MotdScreen> createState() => _MotdScreenState();
}

class _MotdScreenState extends State<MotdScreen> {
  List<PhotoModel> photoCards = [];

  Future<void> _navigateAndDisplaySelection(BuildContext context) async {
    // Navigator.push returns a Future that completes after calling
    // Navigator.pop on the Selection Screen.
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const PhotoEditorScreen()),
    );
    setState(() {
      debugPrint("navigate pop result: $result");
      photoCards.add(result as PhotoModel);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          const SizedBox(width: 16),
          FloatingActionButton(
            onPressed: () {
              _navigateAndDisplaySelection(context);
            },
            child: const Icon(Icons.add),
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
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
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              scrollDirection: Axis.vertical,
              itemCount: photoCards.length,
              itemBuilder: (context, index) {
                debugPrint('index: $index');
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: PhotoCard(photoModel: photoCards[index]),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
