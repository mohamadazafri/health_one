import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:health_one/dashboard/diagnose/widget/chat.dart';
import 'package:health_one/dashboard/diagnose/widget/identifySickness.dart';
import 'package:health_one/dashboard/exercise/widget/exercise.dart';

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
  bool isBottomBarVisible = true;

  late Future? myFuture;

  @override
  void initState() {
    if (widget.homeCurrentIndex != null || widget.homeCurrentIndex == 0) {
      _homeCurrentIndex = widget.homeCurrentIndex!;
    } else {
      _homeCurrentIndex = 0;
    }
    myFuture = firstLoad();
    super.initState();
  }

  void setBaseCurrentIndex(BuildContext context, int value) async {
    // if (value == 1) {
    //   setIsBottomBarVisible(false);
    // } else {
    //   setIsBottomBarVisible(true);
    // }
    setState(() {
      baseCurrentIndex = value;
    });
  }

  void setIsBottomBarVisible(bool value) {
    setState(() {
      isBottomBarVisible = value;
    });
  }

  Future<void> fetchStorageData() {
    return Future.value("abc");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF4F6F8),
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light.copyWith(statusBarColor: Color(0xffF2F1F3)),
        child: FutureBuilder(
          future: myFuture,
          builder: (context, snapshot) {
            Map<String, String> _storage_data;
            dynamic user_detail;

            return IndexedStack(
              index: baseCurrentIndex,
              children: [
                SafeArea(
                  child: Column(
                    children: [
                      Container(
                        decoration: const BoxDecoration(
                          color: Color(0xffF2F1F3),
                        ),
                        width: double.infinity,
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Text(
                            user_detail == null ? "Hola John Doe!" : "Hola, ${user_detail['first_name']}!",
                            style: const TextStyle(fontSize: 30, color: Color(0xff001B2E), fontWeight: FontWeight.w700),
                          ),
                        ),
                      ),
                      Expanded(
                          child: Container(
                        color: Color(0xffF2F1F3),
                      ))
                    ],
                  ),
                ),
                // IdentifySicknessPage(setBaseCurrentIndex),
                const ChatPage(),
                const ExercisePage()
              ],
            );
          },
        ),
      ),
      bottomNavigationBar: Visibility(
        visible: isBottomBarVisible,
        maintainAnimation: true,
        maintainState: true,
        child: Theme(
          data: Theme.of(context).copyWith(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            hoverColor: Colors.transparent,
            canvasColor: Color(0xff1d1c21),
          ),
          child: BottomNavigationBar(
              currentIndex: baseCurrentIndex,
              onTap: (value) {
                setBaseCurrentIndex(context, value);
              },
              type: BottomNavigationBarType.fixed,
              selectedItemColor: Color(0xffFFC49B),
              unselectedItemColor: Color(0xffF2FDFF),
              showSelectedLabels: true,
              showUnselectedLabels: true,
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(icon: Icon(Icons.accessibility_new_rounded), label: "You"),
                BottomNavigationBarItem(icon: Icon(Icons.medical_services_rounded), label: "Diagnose"),
                BottomNavigationBarItem(icon: Icon(Icons.sports_gymnastics_rounded), label: "Exercise"),
              ]),
        ),
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
