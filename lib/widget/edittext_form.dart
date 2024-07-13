import 'package:flutter/material.dart';

class EditTextForm extends StatefulWidget {
  final String hintText;
  final Function(String val) getContent;

  const EditTextForm({
    super.key,
    this.hintText = "",
    required this.getContent,
  });

  @override
  State<EditTextForm> createState() => _EditTextFormState();
}

// Define a corresponding State class.
// This class holds data related to the Form.
class _EditTextFormState extends State<EditTextForm> {
  // Create a text controller and use it to retrieve the current value
  // of the TextField.
  final myController = TextEditingController();

  String content = "";

  @override
  void initState() {
    super.initState();

    // Start listening to changes.
    myController.addListener(_onTextChanged);
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the widget tree.
    // This also removes the _printLatestValue listener.
    myController.dispose();
    super.dispose();
  }

  void _onTextChanged() {
    final text = myController.text;
    widget.getContent(text);
    print('Second text field: $text (${text.characters.length})');
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        hintText: widget.hintText,
      ),
      controller: myController,
    );
  }
}
