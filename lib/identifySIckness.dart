import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class IdentifySickness extends StatefulWidget {
  final CameraDescription camera;
  const IdentifySickness({
    super.key,
    required this.camera,
  });

  @override
  State<IdentifySickness> createState() => _IdentifySicknessState();
}

class _IdentifySicknessState extends State<IdentifySickness> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;

  @override
  void initState() {
    super.initState();

    _controller = CameraController(
      widget.camera,
      ResolutionPreset.medium,
    );

    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
      future: _initializeControllerFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return CameraPreview(_controller);
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
