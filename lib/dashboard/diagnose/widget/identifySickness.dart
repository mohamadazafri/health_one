import 'dart:io';

import 'package:camera/camera.dart';
import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:health_one/dashboard/diagnose/widget/diagnose.dart';
import 'package:health_one/global.dart';

class IdentifySicknessPage extends StatefulWidget {
  // final Function setBaseCurrentIndex;
  const IdentifySicknessPage({
    super.key,
  });

  @override
  State<IdentifySicknessPage> createState() => _IdentifySicknessState();
}

class _IdentifySicknessState extends State<IdentifySicknessPage> {
  late CameraController _controller;
  Future<void>? _initializeControllerFuture;
  late List<CameraDescription> listCamera;
  bool _isRearCameraSelected = true;

  dynamic cameraScale;

  @override
  void initState() {
    listCamera = GlobalValue().getListCamera();
    _controller = CameraController(
      listCamera.first,
      ResolutionPreset.medium,
    );

    _initializeControllerFuture = _controller.initialize();

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggleCameraLens() {
    setState(() {
      final lensDirection = _controller.description.lensDirection;
      CameraDescription newDescription;
      if (lensDirection == CameraLensDirection.front) {
        newDescription = listCamera.firstWhere((description) => description.lensDirection == CameraLensDirection.back);
      } else {
        newDescription = listCamera.firstWhere((description) => description.lensDirection == CameraLensDirection.front);
      }

      _controller = CameraController(
        newDescription,
        ResolutionPreset.medium,
      );

      _initializeControllerFuture = _controller.initialize();
    });
  }

  @override
  Widget build(BuildContext context) {
    // // fetch screen size
    // final size = MediaQuery.of(context).size;

    // // calculate scale depending on screen and camera ratios
    // // this is actually size.aspectRatio / (1 / camera.aspectRatio)
    // // because camera preview size is received as landscape
    // // but we're calculating for portrait orientation

    // double scale = size.aspectRatio * _controller.value.aspectRatio;

    // // to prevent scaling down, invert the value
    // if (scale < 1) scale = 1 / scale;
    return SafeArea(
      child: AnnotatedRegion(
        value: const SystemUiOverlayStyle(
          statusBarColor: Color(0xff101935),
          statusBarIconBrightness: Brightness.light,
        ),
        child: Scaffold(
          body: Column(
            children: [
              Expanded(
                child: FutureBuilder<void>(
                  future: _initializeControllerFuture,
                  builder: (context, snapshot) {
                    // fetch screen size
                    final size = MediaQuery.of(context).size;
                    double screenSizeRatio = size.aspectRatio;
                    double cameraRatio = 0;
                    double scale = 0;

                    if (_controller.value.isInitialized) {
                      cameraRatio = _controller.value.aspectRatio;
                      scale = screenSizeRatio * cameraRatio;
                      // to prevent scaling down, invert the value
                      if (scale < 1) scale = 1 / scale;
                    }

                    if (snapshot.connectionState == ConnectionState.done) {
                      return CameraPreview(
                        _controller,
                        child: Column(
                          children: [
                            Container(
                              decoration: const BoxDecoration(color: Color(0xff101935)),
                              child: Padding(
                                padding: EdgeInsets.all(20.0),
                                child: Row(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        // widget.setBaseCurrentIndex(context, 0);
                                        Navigator.pop(context);
                                      },
                                      child: const Icon(
                                        Icons.arrow_back_ios,
                                        color: Color(0xffF2FDFF),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    const Text(
                                      "Capture your concern",
                                      style: TextStyle(color: Color(0xffF2FDFF), fontSize: 16),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            const Spacer(),
                            Padding(
                              padding: EdgeInsets.all(30.0),
                              child: Row(
                                // crossAxisAlignment: CrossAxisAlignment.center,
                                // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Expanded(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        InkWell(
                                          onTap: () async {
                                            try {
                                              await _initializeControllerFuture;

                                              final image = await _controller.takePicture();

                                              if (!context.mounted) return;

                                              await Navigator.of(context).push(MaterialPageRoute(
                                                  builder: (context) => DiagnosePage(
                                                        imagePath: image.path,
                                                      )));
                                            } catch (e) {
                                              print(e);
                                            }
                                          },
                                          child: const Icon(
                                            Icons.camera,
                                            color: Colors.white,
                                            size: 32,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(right: 35.0),
                                          child: InkWell(
                                            onTap: () {
                                              _toggleCameraLens();
                                              // _initializeControllerFuture = _controller.initialize();
                                            },
                                            child: Icon(_isRearCameraSelected ? CupertinoIcons.switch_camera : CupertinoIcons.switch_camera_solid,
                                                color: Colors.white),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      );
                    } else {
                      return Container(color: Colors.white, child: const Center(child: CircularProgressIndicator()));
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void>? firstLoad() async {
    return await _initializeControllerFuture;
  }
}
