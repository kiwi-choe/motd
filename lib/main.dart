import 'package:flutter/material.dart';
import 'package:motd/screens/home_screen.dart';
import 'package:motd/service/photo_service.dart';

void main() {
  PhotoService().getPhotos();
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(scaffoldBackgroundColor: Colors.white),
      home: HomeScreen(context),
    );
  }
}
