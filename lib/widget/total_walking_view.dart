import 'package:flutter/material.dart';

class TotalWalkingView extends StatefulWidget {
  final int totalWalkCount;
  const TotalWalkingView({
    super.key,
    required this.totalWalkCount,
  });

  @override
  State<TotalWalkingView> createState() => _TotalWalkingViewState();
}

class _TotalWalkingViewState extends State<TotalWalkingView> {
  @override
  Widget build(BuildContext context) {
    final totalWalkCount = widget.totalWalkCount;
    return Container(
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
            "assets/images/insummer.png",
          ),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("함께 걸은 걸음"),
          Text(
            totalWalkCount.toString(),
            style: const TextStyle(fontSize: 60),
          ),
        ],
      ),
    );
  }
}
