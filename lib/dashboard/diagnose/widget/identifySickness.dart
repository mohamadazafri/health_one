import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:health_one/dashboard/diagnose/widget/diagnose.dart';
import 'package:health_one/global.dart';

// This file contains a widget to run a camera on user device
// In this page, user are allowed to capture anything that their concern about expecially on their skin.
// Right after capturing the picture, it will lead user to DiagnosePage()

class IdentifySicknessPage extends StatefulWidget {
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
    // We will get a list of Camera Description from GlobalValue that we assign on 'main' function in 'main.dart'
    listCamera = GlobalValue().getListCamera();

    // We will initialize one of the Camera Description so then user can use it
    _controller = CameraController(
      listCamera.first,
      ResolutionPreset.medium,
    );
    _initializeControllerFuture = _controller.initialize();

    super.initState();
  }

  // We will dispose _controller after we are not using this widget anymore
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // Function for user to change the lens direction, either use the front camera or back camera
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
    return SafeArea(
      child: AnnotatedRegion(
        value: const SystemUiOverlayStyle(
            statusBarColor: Color(0xff101935), statusBarIconBrightness: Brightness.light, statusBarBrightness: Brightness.light),
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
                              decoration: const BoxDecoration(color: Colors.transparent),
                              child: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        // widget.setBaseCurrentIndex(context, 0);
                                        Navigator.pop(context);
                                      },
                                      child: const Icon(
                                        Icons.arrow_back_rounded,
                                        color: Color(0xffF2F1F3),
                                        size: 30,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    const Text(
                                      "Capture your concern",
                                      style: const TextStyle(fontSize: 30, color: Color(0xffF2F1F3), fontWeight: FontWeight.w700),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            const Spacer(),
                            Padding(
                              padding: const EdgeInsets.all(30.0),
                              child: GlassmorphicContainer(
                                width: double.infinity,
                                height: 100,
                                borderRadius: 100,
                                blur: 20,
                                alignment: Alignment.center,
                                border: 1,
                                linearGradient: LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [
                                  const Color(0xFFffffff).withOpacity(0.1),
                                  const Color(0xFFFFFFFF).withOpacity(0.05),
                                ], stops: const [
                                  0.1,
                                  1,
                                ]),
                                borderGradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [
                                    const Color(0xFFffffff).withOpacity(0.5),
                                    const Color((0xFFFFFFFF)).withOpacity(0.5),
                                  ],
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 0.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        width: 30,
                                        child: Container(),
                                      ),
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
                                          child: SizedBox(
                                            width: 70,
                                            height: 70,
                                            child: Container(
                                              decoration:
                                                  const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(100))),
                                            ),
                                          )),
                                      InkWell(
                                        onTap: () {
                                          _toggleCameraLens();
                                        },
                                        child: Icon(
                                          _isRearCameraSelected ? CupertinoIcons.switch_camera : CupertinoIcons.switch_camera_solid,
                                          color: Color(0xffF2F1F3),
                                          size: 30,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      );
                    } else {
                      return Container(color: Colors.black, child: const Center(child: CircularProgressIndicator()));
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

  // This will be the first function that will be called when this page loads
  Future<void>? firstLoad() async {
    return await _initializeControllerFuture;
  }
}
