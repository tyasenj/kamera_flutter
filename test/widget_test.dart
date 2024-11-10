import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:camera/camera.dart';
import 'package:kamera_flutter/widget/takepicture_screen.dart';
import 'package:kamera_flutter/main.dart';

void main() {
  testWidgets('Camera app smoke test', (WidgetTester tester) async {
    // Inisialisasi kamera
    final cameras = await availableCameras();
    final firstCamera = cameras.isNotEmpty ? cameras.first : null;

    // Bangun widget MaterialApp dengan halaman TakePictureScreen atau Center jika kamera tidak tersedia
    await tester.pumpWidget(
      MaterialApp(
        theme: ThemeData.dark(),
        debugShowCheckedModeBanner: false,
        home: firstCamera != null
            ? TakePictureScreen(camera: firstCamera)
            : const Center(child: Text("No camera available")),
      ),
    );

    // Lakukan pengujian sederhana
    expect(find.text("No camera available"), findsNothing);
    expect(find.byType(TakePictureScreen), findsOneWidget);
  });
}
