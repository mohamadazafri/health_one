import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:health_one/identifySIckness.dart';

class Base extends StatefulWidget {
  final int? homeCurrentIndex;
  final CameraDescription? camera;
  const Base({
    super.key,
    this.homeCurrentIndex,
    this.camera,
  });

  @override
  State<Base> createState() => _MyBase();
}

class _MyBase extends State<Base> {
  int? _homeCurrentIndex;
  int baseCurrentIndex = 0;
  late CameraController _controller;
  Future<void>? _initializeControllerFuture;

  late Future? myFuture;

  @override
  void initState() {
    if (widget.homeCurrentIndex != null || widget.homeCurrentIndex == 0) {
      _homeCurrentIndex = widget.homeCurrentIndex!;
    } else {
      _homeCurrentIndex = 0;
    }

    // if (widget.camera != null) {
    //   _controller = CameraController(
    //     widget.camera!,
    //     ResolutionPreset.medium,
    //   );

    //   _initializeControllerFuture = _controller.initialize();
    // }

    myFuture = firstLoad();
    super.initState();
  }

  void setBaseCurrentIndex(BuildContext context, int value) async {
    // if (value == 2) {
    //   // await _initializeControllerFuture;

    //   // final image = await _controller.takePicture();

    //   // if (!context.mounted) return;

    //   // setState(() {
    //   //   baseCurrentIndex = value;
    //   // });

    //   // await Navigator.of(context).push(
    //   //   MaterialPageRoute(
    //   //     builder: (context) => DisplayPictureScreen(
    //   //       imagePath: image.path,
    //   //     ),
    //   //   ),
    //   // );
    // } else {
    //   setState(() {
    //     baseCurrentIndex = value;
    //   });
    // }

    setState(() {
      baseCurrentIndex = value;
    });
  }

  Future<void> fetchStorageData() {
    return Future.value("abc");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF4F6F8),
      body: FutureBuilder(
        future: myFuture,
        builder: (context, snapshot) {
          Map<String, String> _storage_data;
          dynamic user_detail;

          return IndexedStack(
            index: baseCurrentIndex,
            children: [
              Column(
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      color: Color(0xff101935),
                    ),
                    width: double.infinity,
                    height: 100,
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: 30,
                        right: 30,
                        top: 30,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            user_detail == null ? "Hi" : "Hi, ${user_detail['first_name']}",
                            style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.w700),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Container(),
              IdentifySickness(),
              Container(),
              Container()
            ],
          );
        },
      ),
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          hoverColor: Colors.transparent,
          canvasColor: Colors.white,
        ),
        child: BottomNavigationBar(
            currentIndex: baseCurrentIndex,
            onTap: (value) {
              setBaseCurrentIndex(context, value);
            },
            type: BottomNavigationBarType.fixed,
            selectedItemColor: Color(0xffF6921E),
            showSelectedLabels: false,
            showUnselectedLabels: false,
            items: <BottomNavigationBarItem>[
              const BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
              const BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
              BottomNavigationBarItem(
                  icon: Container(
                      height: 45,
                      width: 45,
                      decoration: BoxDecoration(
                          gradient: const LinearGradient(
                              transform: GradientRotation(0.5),
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                              colors: [
                                Color(0xff0E3871),
                                Color(0xff0E3871),
                                Color(0xff4F66AC),
                              ],
                              stops: [
                                0.1,
                                0.3,
                                1,
                              ]),
                          borderRadius: BorderRadius.circular(30)),
                      child: const Padding(padding: EdgeInsets.all(14), child: Icon(Icons.add))),
                  label: "Home"),
              const BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
              const BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
            ]),
      ),
    );
  }

  Future<void>? firstLoad() {
    // return _initializeControllerFuture;
    return Future.value(2020);
  }
}

class DisplayPictureScreen extends StatelessWidget {
  final String imagePath;

  const DisplayPictureScreen({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Display the Picture')),
      body: Image.file(File(imagePath)),
    );
  }
}
