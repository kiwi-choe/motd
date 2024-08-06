import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:motd/widget/image_placeholder.dart';

class SeniorDetailScreen extends StatefulWidget {
  final String? noticeImageUrl;
  final Color noticeColor;

  const SeniorDetailScreen({
    super.key,
    this.noticeImageUrl,
    required this.noticeColor,
  });

  @override
  State<SeniorDetailScreen> createState() => _SeniorDetailScreenState();
}

class _SeniorDetailScreenState extends State<SeniorDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: const Text(
          "삼성동 독거 어르신 돌봄",
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Column(
                  children: [
                    _renderNoticeBanner(),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _renderDescription(),
                        _renderEventDetails(widget.noticeColor),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  _renderDescription() {
    return const Padding(
      padding: EdgeInsets.only(top: 24),
      child: Text(
        "우리 주변에 홀로 사는 분들이 적지 않습니다.\n"
        "평생을 애쓰고 살아오셨지만,\n"
        "지금은 돌봐줄 분이 없는 독거 어르신들에게\n"
        "매일 아침 우유를 한 병씩 보내 드리고\n"
        "있습니다.\n"
        "아침에 안부를 묻는 '굿모닝 프로젝트'입니다.\n\n"
        "그리고 이번엔 우리가 직접 찾아가서\n"
        "얼굴을 뵙고 문안하려고 합니다.",
        style: TextStyle(
          fontSize: 14,
        ),
      ),
    );
  }

  _renderEventDetails(Color noticeColor) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 24,
        bottom: 24,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "일시",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: noticeColor,
                ),
              ),
              const SizedBox(
                width: 24,
              ),
              const Text(
                "8월 10일 오전 10시",
              ),
            ],
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "장소",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: noticeColor,
                ),
              ),
              const SizedBox(
                width: 24,
              ),
              const Text(
                "빛의교회에서 출발",
              ),
            ],
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "문의",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: noticeColor,
                ),
              ),
              const SizedBox(
                width: 24,
              ),
              const Text(
                "02-532-9826",
              ),
            ],
          ),
        ],
      ),
    );
  }

  _renderNoticeBanner() {
    return Card(
      color: widget.noticeColor,
      clipBehavior: Clip.hardEdge,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SizedBox(
          height: 120,
          child: widget.noticeImageUrl?.isNotEmpty == true
              ? CachedNetworkImage(
                  fit: BoxFit.contain,
                  placeholder: (context, url) => const ImagePlaceholder(),
                  imageUrl: widget.noticeImageUrl!,
                )
              : const Text(""),
        ),
      ),
    );
  }
}
