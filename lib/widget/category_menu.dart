import 'package:flutter/material.dart';

class CategoryMenu extends StatelessWidget {
  const CategoryMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: ListView.separated(
          itemBuilder: (context, index) {
            return Text("Miracle On Thursday $index");
            // Navigator.pop(context);
          },
          separatorBuilder: (context, index) => const Divider(),
          itemCount: 5,
          // categories
        ),
      ),
    );
  }
}
