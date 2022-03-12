import 'dart:io';
import 'dart:math';
import 'dart:ui' as ui;
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:flutter/material.dart';
import 'face_painter.dart'; import 'package:image_picker/image_picker.dart';

class FaceDetector extends StatefulWidget {
  @override
  _FaceDetectorState createState() => _FaceDetectorState();
}

class _FaceDetectorState extends State<FaceDetector> {
  late File _imageFile;
  List<Face>? _faces;
  bool isLoading = false;
  ui.Image? _image;

  Future getImage(bool camera) async {
    File image;
    final _picker = ImagePicker();
    var pickedFile;
    if (camera) {
      pickedFile = await _picker.pickImage(source: ImageSource.camera);
      image = File(pickedFile.path);
    } else {
      pickedFile = await _picker.pickImage(source: ImageSource.gallery);
      image = File(pickedFile.path);
    }

    setState(() {
      _imageFile = image;
      isLoading = true;
    });

    detectFaces(_imageFile);
  }

  detectFaces(File imageFile) async {
    final image = FirebaseVisionImage.fromFile(imageFile);
    final faceDetector = FirebaseVisionImage.fromFile(imageFile);
    List<Face> faces = await faceDetector.processImage(image);

    if (mounted) {
      setState(() {
        _imageFile = imageFile;
        _faces = faces;
        _loadImage(imageFile);
      });
    }
  }

  _loadImage(File file) async {
    final data = await file.readAsBytes();
    await decodeImageFromList(data).then((value) =>
        setState(() {
          _image = value;
          isLoading = false;
        })
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Face Detector"),
      ),
      body: isLoading
        ? Center(
        child: Container(),
      )
    )
  }












}