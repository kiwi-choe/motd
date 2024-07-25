import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:motd/main.dart';
import 'package:motd/screens/detail/w4m/w4m_photo_screen.dart';
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
      body: StreamBuilder<QuerySnapshot<W4mResponse>>(
        stream: W4mService().getW4mStream(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          }

          var totalWalkCount = 0;
          if (snapshot.hasData) {
            logger.d("${snapshot.data!.size}");
            if (snapshot.data!.size > 0) {
              totalWalkCount =
                  snapshot.data!.docs.first.data().totalWalkCount ?? 0;
            } else {
              totalWalkCount = 0;
            }
          }

          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TotalWalkingView(
                    totalWalkCount: totalWalkCount,
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  _renderButton()
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  _renderButton() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF2f72ba),
      ),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const W4mPhotoScreen()),
        );
      },
      child: const Padding(
        padding: EdgeInsets.symmetric(vertical: 16.0),
        child: Center(
          widthFactor: double.infinity,
          child: Text(
            '걸으며 사진 찍어 올리기',
            style: TextStyle(color: Colors.white, fontSize: 14),
          ),
        ),
      ),
    );
  }
}


// class W4mGuideView extends StatelessWidget {
//   const W4mGuideView({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.symmetric(vertical: 32),
//       alignment: Alignment.center,
//       width: double.infinity,
//       child: const Column(
//         children: [
//           Row(
//             children: [
//               Text(
//                 '일시',
//                 style: TextStyle(
//                   fontSize: 16,
//                   color: Color(0xFFc5aed1),
//                   fontWeight: FontWeight.w900,
//                 ),
//               ),
//               SizedBox(
//                 width: 32,
//               ),
//               Text(
//                 '2024년 7월 25일 저녁 7시 20분',
//                 style: TextStyle(fontWeight: FontWeight.w600),
//               ),
//             ],
//           ),
//           SizedBox(
//             height: 6,
//           ),
//           Row(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 '장소',
//                 style: TextStyle(
//                   fontSize: 16,
//                   color: Color(0xFFc5aed1),
//                   fontWeight: FontWeight.w900,
//                 ),
//               ),
//               SizedBox(
//                 width: 32,
//               ),
//               Text(
//                 '한강 고수부지, 동작대교 남단 ~\n반포 한강 고수부지(왕복 약 4km)',
//                 style: TextStyle(fontWeight: FontWeight.w600),
//               ),
//             ],
//           ),
//           SizedBox(
//             height: 6,
//           ),
//           Row(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 '대상',
//                 style: TextStyle(
//                   fontSize: 16,
//                   color: Color(0xFFc5aed1),
//                   fontWeight: FontWeight.w900,
//                 ),
//               ),
//               SizedBox(
//                 width: 32,
//               ),
//               Text(
//                 '빛의교회 성도, 아웃리치 신청자',
//                 style: TextStyle(fontWeight: FontWeight.w600),
//               ),
//             ],
//           ),
//           SizedBox(
//             height: 6,
//           ),
//           Row(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 '방법',
//                 style: TextStyle(
//                   fontSize: 16,
//                   color: Color(0xFFc5aed1),
//                   fontWeight: FontWeight.w900,
//                 ),
//               ),
//               SizedBox(
//                 width: 32,
//               ),
//               Text(
//                 '함께, 혹은 각자 걸으면서 아웃리치 위\n해서 기도하고 선교헌금 드리기\n라이브 방송 참여하며 걷기',
//                 style: TextStyle(fontWeight: FontWeight.w600),
//               ),
//             ],
//           ),
//           SizedBox(
//             height: 32,
//           ),
//           Row(
//             children: [
//               Text(
//                 '7 : 20',
//                 style: TextStyle(
//                   fontSize: 16,
//                   fontWeight: FontWeight.w600,
//                 ),
//               ),
//               SizedBox(
//                 width: 16,
//               ),
//               Text(
//                 '집합 후 정진욱 선생님과 함께 몸 풀기',
//                 style: TextStyle(fontWeight: FontWeight.w600),
//               ),
//             ],
//           ),
//           Row(
//             children: [
//               Text(
//                 '7 : 30',
//                 style: TextStyle(
//                   fontSize: 16,
//                   fontWeight: FontWeight.w600,
//                 ),
//               ),
//               SizedBox(
//                 width: 16,
//               ),
//               Text(
//                 '출발, 라이브 방송',
//                 style: TextStyle(fontWeight: FontWeight.w600),
//               ),
//             ],
//           ),
//           Row(
//             children: [
//               Text(
//                 '8 : 45',
//                 style: TextStyle(
//                   fontSize: 16,
//                   fontWeight: FontWeight.w600,
//                 ),
//               ),
//               SizedBox(
//                 width: 16,
//               ),
//               Text(
//                 '기념 사진 / 이영은 성미숙',
//                 style: TextStyle(fontWeight: FontWeight.w600),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }
