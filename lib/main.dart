import 'package:flutter/material.dart';
import 'face_detector.dart';
import 'test_dart.dart';

void main() => runApp(MaterialApp(
  title: "Face Detector",
  darkTheme: ThemeData.dark(),
  debugShowCheckedModeBanner: false,
  home: FaceDetector(),
  themeMode: ThemeMode.dark,
));