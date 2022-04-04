import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'crop2.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CropperX Example',
      theme: ThemeData(
        primaryColor: Colors.blueAccent,
      ),
      home: const CropperScreen(),
    );
  }
}

class CropperScreen extends StatefulWidget {
  const CropperScreen({Key? key}) : super(key: key);

  @override
  State<CropperScreen> createState() => _CropperScreenState();
}

class _CropperScreenState extends State<CropperScreen> {
  final ImagePicker _picker = ImagePicker();
  final GlobalKey _cropperKey = GlobalKey(debugLabel: 'cropperKey');
  Uint8List? _imageToCrop;
  Uint8List? _croppedImage;

  // OverlayType _overlayType = OverlayType.rectangle;
  int _rotationTurns = 0;

  File? imgFile;

  final cropKey = GlobalKey<CropState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Flexible(
              child: Container(
                  color: Colors.black,
                  padding: const EdgeInsets.all(16.0),
                  child: imgFile == null
                      ? Text("no image")
                      : Crop2.file(
                          imgFile!,
                          maximumScale: 50.0,
                          key: cropKey,
                          aspectRatio: 3 / 4,
                          onImageError: (exception, stackTrace) {
                            debugPrint("Crop image error: $exception");
                          },
                          // aspectRatio:  487 / 451,
                        )),
            ),
            TextButton(
                onPressed: () async {
                  final ImagePicker _picker = ImagePicker();
                  // Pick an image
                  final XFile? image =
                      await _picker.pickImage(source: ImageSource.gallery);

                  if (image != null) {
                    setState(() {
                      imgFile = File(image.path);
                    });
                  }
                },
                child: Text(
                  "Click here!",
                  style: TextStyle(color: Colors.blue),
                ))
          ],
        ),
      ),
    );
  }
}
