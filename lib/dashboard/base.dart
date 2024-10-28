import 'dart:convert';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_svg/svg.dart';
import 'package:health_one/dashboard/diagnose/widget/chat.dart';
import 'package:health_one/dashboard/diagnose/widget/diagnose.dart';
import 'package:health_one/dashboard/diagnose/widget/identifySickness.dart';
import 'package:health_one/dashboard/exercise/widget/exercise.dart';
import 'package:health_one/dashboard/exercise/widget/generatedWorkoutPlan.dart';
import 'package:health_one/storage.dart';

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
  Map<String, dynamic>? data;
  int _homeCurrentIndex = 0;
  bool isBottomBarVisible = true;
  String? userName;
  List? diagnoseHistory;
  List? workoutHistory;
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
    setState(() {
      _homeCurrentIndex = value;
    });
  }

  void setIsBottomBarVisible(bool value) {
    setState(() {
      isBottomBarVisible = value;
    });
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
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError) {
                return const Text("Something went wrong. Please try again next time");
              } else if (snapshot.hasData) {
                if (snapshot.data! == false) {
                  return const Text("Something went wrong. Please try again next time");
                } else {
                  data ??= snapshot.data! as Map<String, dynamic>;

                  userName = data!["userName"];
                  diagnoseHistory = data!["diagnoseHistory"];
                  workoutHistory = data!["workoutHistory"];
                }
              }
            }

            return IndexedStack(
              index: _homeCurrentIndex,
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
                            userName == null ? "Hola!" : "Hola, $userName!",
                            style: const TextStyle(fontSize: 30, color: Color(0xff001B2E), fontWeight: FontWeight.w700),
                          ),
                        ),
                      ),
                      Expanded(
                          child: SingleChildScrollView(
                        child: Container(
                          color: Color(0xffF2F1F3),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(bottom: 14),
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 14.0),
                                    child: Row(
                                      children: [
                                        const Expanded(
                                          child: Text(
                                            "Vision Diagnose",
                                            style: TextStyle(fontSize: 28, fontWeight: FontWeight.w500, color: Color(0xff4E4E4E)),
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            Navigator.pushNamed(context, '/diagnoseHistory');
                                          },
                                          child: const Text(
                                            "View all",
                                            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.blue),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                diagnoseHistory == null
                                    ? Container(
                                        margin: EdgeInsets.only(bottom: 30),
                                        child: InkWell(
                                          onTap: () {
                                            Navigator.pushNamed(context, '/identifySickness');
                                          },
                                          child: SizedBox(
                                            width: double.infinity,
                                            height: 200,
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: Color(0xffFFC49B),
                                                borderRadius: BorderRadius.circular(20),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Color(0xff1d1c21).withOpacity(1),
                                                    offset: Offset(3, 3),
                                                    blurRadius: 0,
                                                    spreadRadius: 1,
                                                  ),
                                                ],
                                              ),
                                              child: const Padding(
                                                padding: const EdgeInsets.all(20.0),
                                                child: Column(
                                                  children: [
                                                    Text("You don't have any diagnose history yet"),
                                                    Text("Give it a try"),
                                                    SizedBox(
                                                      height: 30,
                                                    ),
                                                    Icon(
                                                      Icons.add_circle,
                                                      size: 50,
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      )
                                    : Container(
                                        margin: EdgeInsets.only(bottom: 30),
                                        decoration: BoxDecoration(
                                          color: Color(0xffFFC49B),
                                          borderRadius: BorderRadius.circular(20),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Color(0xff1d1c21).withOpacity(1),
                                              offset: Offset(3, 3),
                                              blurRadius: 0,
                                              spreadRadius: 1,
                                            ),
                                          ],
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(20.0),
                                          child: Column(
                                            children: List.generate(diagnoseHistory!.length, (index) {
                                              if (index < 3) {
                                                return InkWell(
                                                  onTap: () async {
                                                    await Navigator.of(context).push(MaterialPageRoute(
                                                        builder: (context) => DiagnosePage(
                                                              imagePath: diagnoseHistory![index]["imagePath"],
                                                              diagnoseDetail: diagnoseHistory![index],
                                                            )));
                                                  },
                                                  child: Container(
                                                    decoration:
                                                        BoxDecoration(color: Colors.white.withOpacity(0.7), borderRadius: BorderRadius.circular(20)),
                                                    margin: EdgeInsets.only(bottom: 20),
                                                    child: Padding(
                                                      padding: const EdgeInsets.all(8.0),
                                                      child: Row(
                                                        children: [
                                                          Container(
                                                            decoration: BoxDecoration(
                                                              borderRadius: BorderRadius.circular(8.0),
                                                              boxShadow: [
                                                                BoxShadow(
                                                                  color: Color(0xff1d1c21).withOpacity(1),
                                                                  offset: Offset(3, 3),
                                                                  blurRadius: 0,
                                                                  spreadRadius: 1,
                                                                ),
                                                              ],
                                                            ),
                                                            child: ClipRRect(
                                                              borderRadius: BorderRadius.circular(8.0),
                                                              child: Image.file(
                                                                File(diagnoseHistory![index]["imagePath"]),
                                                                height: 70.0,
                                                              ),
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            width: 20,
                                                          ),
                                                          Expanded(
                                                            child: Text(
                                                              diagnoseHistory![index]["name of finding"]!,
                                                              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
                                                              overflow: TextOverflow.clip,
                                                            ),
                                                          ),
                                                          Icon(Icons.arrow_circle_right_rounded)
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              } else {
                                                return Container();
                                              }
                                            }),
                                          ),
                                        ),
                                      ),
                                Container(
                                  margin: const EdgeInsets.only(bottom: 14),
                                  child: Padding(
                                    padding: EdgeInsets.only(right: 14.0),
                                    child: Row(
                                      children: [
                                        const Expanded(
                                          child: Text(
                                            "Workout Plan",
                                            style: TextStyle(fontSize: 28, fontWeight: FontWeight.w500, color: Color(0xff4E4E4E)),
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            Navigator.pushNamed(context, '/exerciseHistory');
                                          },
                                          child: const Text(
                                            "View all",
                                            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.blue),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                workoutHistory == null
                                    ? Container(
                                        margin: EdgeInsets.only(bottom: 30),
                                        child: InkWell(
                                          onTap: () {
                                            Navigator.pushNamed(context, '/workoutPlanForm');
                                          },
                                          child: SizedBox(
                                            width: double.infinity,
                                            height: 200,
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: Color(0xffFFC49B),
                                                borderRadius: BorderRadius.circular(20),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Color(0xff1d1c21).withOpacity(1),
                                                    offset: Offset(3, 3),
                                                    blurRadius: 0,
                                                    spreadRadius: 1,
                                                  ),
                                                ],
                                              ),
                                              child: const Padding(
                                                padding: const EdgeInsets.all(20.0),
                                                child: Column(
                                                  children: [
                                                    Text("You don't have any workout plan history yet"),
                                                    Text("Give it a try"),
                                                    SizedBox(
                                                      height: 30,
                                                    ),
                                                    Icon(
                                                      Icons.add_circle,
                                                      size: 50,
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      )
                                    : Container(
                                        margin: EdgeInsets.only(bottom: 30),
                                        decoration: BoxDecoration(
                                          color: Color(0xffFFC49B),
                                          borderRadius: BorderRadius.circular(20),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Color(0xff1d1c21).withOpacity(1),
                                              offset: Offset(3, 3),
                                              blurRadius: 0,
                                              spreadRadius: 1,
                                            ),
                                          ],
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(20.0),
                                          child: Column(
                                            children: List.generate(workoutHistory!.length, (index) {
                                              if (index < 3) {
                                                return InkWell(
                                                  onTap: () async {
                                                    await Navigator.of(context).push(MaterialPageRoute(
                                                        builder: (context) => GeneratedWorkoutPlanPage(
                                                              // diagnoseDetail: diagnoseHistory![index],
                                                              workoutDetail: workoutHistory?[index] as Map<String, dynamic>,
                                                              dataExisted: true,
                                                            )));
                                                  },
                                                  child: Container(
                                                    margin: EdgeInsets.only(bottom: 20),
                                                    decoration:
                                                        BoxDecoration(color: Colors.white.withOpacity(0.7), borderRadius: BorderRadius.circular(20)),
                                                    child: Padding(
                                                      padding: const EdgeInsets.all(8.0),
                                                      child: Row(
                                                        children: [
                                                          Expanded(
                                                            child: Column(
                                                              mainAxisAlignment: MainAxisAlignment.start,
                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                              children: [
                                                                Text(
                                                                  workoutHistory![index]["result"]["goal"]!,
                                                                  style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
                                                                  overflow: TextOverflow.clip,
                                                                ),
                                                                Text(
                                                                  workoutHistory![index]["result"]["fitness_level"]!,
                                                                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                                                                  overflow: TextOverflow.clip,
                                                                ),
                                                                Text(
                                                                  "${workoutHistory![index]["result"]["schedule"]["days_per_week"]!.toString()} days per week",
                                                                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                                                                  overflow: TextOverflow.clip,
                                                                ),
                                                                Text(
                                                                  "${workoutHistory![index]["result"]["schedule"]["session_duration"]!.toString()} minutes",
                                                                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                                                                  overflow: TextOverflow.clip,
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                          Icon(Icons.arrow_circle_right_rounded)
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              } else {
                                                return Container();
                                              }
                                            }),
                                          ),
                                        ),
                                      )
                              ],
                            ),
                          ),
                        ),
                      ))
                    ],
                  ),
                ),
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
              currentIndex: _homeCurrentIndex,
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

  // This will be the first function that will be called when this page loads
  Future<Map<String, dynamic>>? firstLoad() async {
    String userName = await SecureStorage.readStorage("name");
    List? diagnoseHistory;
    List? workoutHistory;
    // Try to get workoutHistory from SecureStorage

    try {
      diagnoseHistory = jsonDecode(await SecureStorage.readStorage("diagnoseHistory"));
    } catch (e) {
      print("There is no diagnoseHistory yet");
    }

    // Try to get workoutHistory from SecureStorage
    try {
      workoutHistory = jsonDecode(await SecureStorage.readStorage("workoutHistory"));
    } catch (e) {
      print("There is no workoutHistory yet");
    }
    return {"userName": userName, "diagnoseHistory": diagnoseHistory, "workoutHistory": workoutHistory};
  }
}
