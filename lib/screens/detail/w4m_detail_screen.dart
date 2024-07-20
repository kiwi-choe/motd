import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class W4mDetailScreen extends StatelessWidget {
  const W4mDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: const Text("함께 걸어요 walking for miracle"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              width: 300.0,
              height: 300.0,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  width: 8,
                  color: const Color(0xFF2f72ba),
                ),
                image: const DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage(
                    "images/insummer.png",
                  ),
                ),
              ),
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("함께 걸은 걸음"),
                  Text(
                    "12345",
                    style: TextStyle(fontSize: 60),
                  ),
                ],
              ),
            )

            // Container(
            //   height: 300,
            //   width: 300,
            //   clipBehavior: Clip.hardEdge,
            //   decoration: BoxDecoration(
            //     shape: BoxShape.circle,
            //     border: Border.all(
            //       width: 8,
            //       color: const Color(0xFFd5e2f1),
            //     ),
            //   ),
            //   child: Padding(
            //     padding: const EdgeInsets.all(20.0),
            //     child: Stack(
            //       children: [
            //         SizedBox.expand(
            //           child: Image.asset("images/insummer.png",
            //               fit: BoxFit.cover),
            //         ),
            //         const Column(
            //           mainAxisAlignment: MainAxisAlignment.center,
            //           children: [
            //             Text("함께 걸은 걸음"),
            //             Text(
            //               "12345",
            //               style: TextStyle(fontSize: 50),
            //             ),
            //           ],
            //         ),
            //       ],
            //     ),
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}
