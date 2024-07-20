import 'package:flutter/material.dart';
import 'package:motd/widget/input_walking_count.dart';

class W4mDetailScreen extends StatelessWidget {
  const W4mDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: const Text("함께 걸어요 walking for miracle"),
      ),
      body: const Padding(
        padding: EdgeInsets.symmetric(vertical: 32, horizontal: 16),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TotalWalkingView(),
              InputWalkingCount(),
            ],
          ),
        ),
      ),
    );
  }
}

class TotalWalkingView extends StatelessWidget {
  const TotalWalkingView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
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
    );
  }
}
