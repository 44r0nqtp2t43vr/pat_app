// ignore_for_file: avoid_print

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:pat_app/core/controllers/language_controller.dart';
import 'package:pat_app/core/widgets/app_button.dart';
import 'package:pat_app/core/widgets/app_title_text.dart';

class WorkIdPhoto extends StatefulWidget {
  const WorkIdPhoto({super.key});

  @override
  State<WorkIdPhoto> createState() => _WorkIdPhotoState();
}

class _WorkIdPhotoState extends State<WorkIdPhoto> {
  late CameraController _cameraController;
  late Future<void> _initializeControllerFuture;

  Future<void> _initializeCamera() async {
    try {
      final cameras = await availableCameras();

      final frontCamera = cameras.firstWhere(
        (camera) => camera.lensDirection == CameraLensDirection.front,
        orElse: () => cameras.first,
      );

      _cameraController = CameraController(
        frontCamera,
        ResolutionPreset.high,
      );

      await _cameraController.initialize();
    } catch (e) {
      print('Error initializing camera: $e');
      rethrow;
    }
  }

  Future<void> _takePicture() async {
    try {
      await _initializeControllerFuture;

      final image = await _cameraController.takePicture();

      if (!mounted) return;

      Navigator.pushReplacementNamed(context, '/workIdPreview', arguments: image);
    } catch (e) {
      print('Error taking picture: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    _initializeControllerFuture = _initializeCamera();
  }

  @override
  void dispose() {
    _cameraController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }

            return Stack(
              children: [
                Center(
                  child: FittedBox(
                    fit: BoxFit.cover,
                    child: SizedBox(
                      width: _cameraController.value.previewSize!.height,
                      height: _cameraController.value.previewSize!.width,
                      child: CameraPreview(_cameraController),
                    ),
                  ),
                ),
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    decoration: const BoxDecoration(color: Colors.white),
                    child: const Padding(
                      padding: EdgeInsets.only(
                        left: 20.0,
                        right: 20.0,
                        top: 40.0,
                        bottom: 10.0,
                      ),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: AppTitleText(
                          title: TextMeaning.workIDPhoto,
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 20,
                  left: 10,
                  right: 10,
                  child: Center(
                    child: AppButton(
                      onPressed: _takePicture,
                      textMeaning: TextMeaning.takePhoto,
                    ),
                  ),
                ),
              ],
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
