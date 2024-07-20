import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:motd/main.dart';
import 'package:motd/service/model/w4m_response.dart';
import 'package:motd/service/w4m_service.dart';
import 'package:motd/widget/input_walking_count.dart';
import 'package:motd/widget/total_walking_view.dart';

class W4mDetailScreen extends StatefulWidget {
  const W4mDetailScreen({super.key});

  @override
  State<W4mDetailScreen> createState() => _W4mDetailScreenState();
}

class _W4mDetailScreenState extends State<W4mDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: const Text("함께 걸어요 walking for miracle"),
      ),
      //   body: StreamBuilder<QuerySnapshot<W4mResponse>>(
      //     stream: W4mService().getW4mStream(),
      //     builder: (context, snapshot) {
      //       if (snapshot.hasError) {
      //         return Center(
      //           child: Text(snapshot.error.toString()),
      //         );
      //       }

      //       var totalWalkCount = 0;
      //       List<QueryDocumentSnapshot<W4mResponse>>? docs;
      //       if (!snapshot.hasData) {
      //         totalWalkCount = 0;
      //       } else {
      //         docs = snapshot.requireData.docs;
      //         logger.d("w4m data: ${docs.first.data().toString()}");
      //       }

      //       return Padding(
      //         padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
      //         child: SingleChildScrollView(
      //           physics: const BouncingScrollPhysics(),
      //           child: Column(
      //             crossAxisAlignment: CrossAxisAlignment.stretch,
      //             children: [
      //               TotalWalkingView(
      //                 totalWalkCount: totalWalkCount,
      //               ),
      //               InputWalkingCount(
      //                 docs: docs,
      //               ),
      //             ],
      //           ),
      //         ),
      //       );
      //     },
      //   ),
      body: const Padding(
        padding: EdgeInsets.symmetric(vertical: 32, horizontal: 16),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TotalWalkingView(
                totalWalkCount: 1111,
              ),
              InputWalkingCount(
                docs: null,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
