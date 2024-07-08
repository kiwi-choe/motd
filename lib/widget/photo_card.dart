import 'package:flutter/material.dart';

class PhotoCard extends StatelessWidget {
  const PhotoCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.amber,
      child: Stack(
        children: [
          Image.asset(
            'assets/images/test.jpeg',
            fit: BoxFit.cover,
            height: 200,
          ),
          const Text("#MOTD #워킹포미라클"),
        ],
      ),
    );
  }
}
