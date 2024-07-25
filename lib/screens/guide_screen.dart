import 'package:flutter/material.dart';

class GuideScreen extends StatelessWidget {
  const GuideScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.only(top: 8.0, bottom: 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset('assets/images/motd_header.png'),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 16.0),
                child: Text(
                  "작은 섬김이 큰 기적을,\n삶의 자리에서 함께 하는 기적의 릴레이입니다.\n\n"
                  "매일 매일 선한 일을 하면서 살아가면 좋겠지만\n뜻대로 되지 않는다면\n목요일 하루만이라도 함께 선한 것을 꿈꾸고 시도해 봅시다.\n\n"
                  "작고 사소해 보이는 섬김이\n하나님의 손에 들리면\n크고 아름다운 기적으로 열매 맺게 될 거에요.\n\n"
                  "마치 소년의 도시락이\n오병이어의 기적이 된 것 처럼 말이에요.\n\n"
                  "오늘은 일주일의 하루,\n‘목요일의 기적’을 꿈꾸지만\n나중에는 날마다 기적의 씨앗을 심는 삶으로,\n그렇게 살아가기를 바랍니다.\n\n"
                  "2024년 여름 ‘miracles on thursday’에 초대합니다.\n\n",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
