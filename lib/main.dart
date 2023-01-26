import 'package:flutter/material.dart';
import 'package:flutter_video_call_demo/splash_screen.dart';
import 'package:flutter_video_call_demo/theme.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: AppColor.kDarkBackgroundPrimaryColor,
      ),
      home: SplashAnimation(),
    );
  }
}
