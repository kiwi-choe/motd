import 'package:flutter/material.dart';
import 'package:motd/screens/photo_upload_screen.dart';

final TextEditingController maxWidthController = TextEditingController();
final TextEditingController maxHeightController = TextEditingController();
final TextEditingController qualityController = TextEditingController();
final TextEditingController limitController = TextEditingController();

Future<void> displayPickImageDialog(
    BuildContext context, bool isMulti, OnPickImageCallback onPick) async {
  return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add optional parameters'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextField(
                controller: maxWidthController,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                decoration: const InputDecoration(
                    hintText: 'Enter maxWidth if desired'),
              ),
              TextField(
                controller: maxHeightController,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                decoration: const InputDecoration(
                    hintText: 'Enter maxHeight if desired'),
              ),
              TextField(
                controller: qualityController,
                keyboardType: TextInputType.number,
                decoration:
                    const InputDecoration(hintText: 'Enter quality if desired'),
              ),
              if (isMulti)
                TextField(
                  controller: limitController,
                  keyboardType: TextInputType.number,
                  decoration:
                      const InputDecoration(hintText: 'Enter limit if desired'),
                ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('CANCEL'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
                child: const Text('PICK'),
                onPressed: () {
                  final double? width = maxWidthController.text.isNotEmpty
                      ? double.parse(maxWidthController.text)
                      : null;
                  final double? height = maxHeightController.text.isNotEmpty
                      ? double.parse(maxHeightController.text)
                      : null;
                  final int? quality = qualityController.text.isNotEmpty
                      ? int.parse(qualityController.text)
                      : null;
                  final int? limit = limitController.text.isNotEmpty
                      ? int.parse(limitController.text)
                      : null;
                  onPick(width, height, quality, limit);
                  Navigator.of(context).pop();
                }),
          ],
        );
      });
}
