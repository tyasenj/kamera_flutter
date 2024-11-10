import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'widget/takepicture_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Dapatkan daftar kamera yang tersedia di perangkat.
  final cameras = await availableCameras();

  // Ambil kamera pertama dari daftar kamera yang tersedia.
  final firstCamera = cameras.isNotEmpty ? cameras.first : null;

  runApp(
    MaterialApp(
      theme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      home: firstCamera != null
          ? TakePictureScreen(camera: firstCamera)
          : const Center(child: Text("No camera available")),
    ),
  );
}
