import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'displaypicture_screen.dart';

class TakePictureScreen extends StatefulWidget {
  final CameraDescription camera;

  const TakePictureScreen({super.key, required this.camera});

  @override
  TakePictureScreenState createState() => TakePictureScreenState();
}

class TakePictureScreenState extends State<TakePictureScreen> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;

  @override
  void initState() {
    super.initState();
    // Inisialisasi CameraController untuk menampilkan pratinjau dari kamera.
    _controller = CameraController(
      widget.camera,
      ResolutionPreset.medium,
    );

    // Menginisialisasi controller.
    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    // Pastikan controller dibuang saat widget dibuang.
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Take a picture - NIM Anda')),
      // Menampilkan preview kamera atau indikator loading.
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            // Jika Future selesai, tampilkan pratinjau.
            return CameraPreview(_controller);
          } else {
            // Jika masih loading, tampilkan indikator loading.
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // Ambil gambar dalam blok try / catch.
          try {
            // Pastikan kamera sudah diinisialisasi.
            await _initializeControllerFuture;

            // Ambil gambar dan simpan ke file `image`.
            final image = await _controller.takePicture();

            if (!context.mounted) return;

            // Jika gambar berhasil diambil, tampilkan di layar baru.
            await Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => DisplayPictureScreen(
                  // Berikan path gambar ke widget DisplayPictureScreen.
                  imagePath: image.path,
                ),
              ),
            );
          } catch (e) {
            // Jika terjadi error, cetak error ke console.
            print(e);
          }
        },
        child: const Icon(Icons.camera_alt),
      ),
    );
  }
}
