import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:health_one/dashboard/exercise/widget/generatedWorkoutPlan.dart';
import 'package:health_one/storage.dart';

// This file contains a widget to list down all generate workout plan history that user saved
// In this page, user get to preview back their workout plan

class ExerciseHistoryPage extends StatefulWidget {
  const ExerciseHistoryPage({super.key});

  @override
  State<ExerciseHistoryPage> createState() => _ExerciseHistoryPageState();
}

class _ExerciseHistoryPageState extends State<ExerciseHistoryPage> {
  Map<String, dynamic>? data;
  List? workoutHistory;
  late Future? myFuture;

  @override
  void initState() {
    myFuture = firstLoad();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Color(0xffF2F1F3),
          body: FutureBuilder(
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

                    workoutHistory = data!["workoutHistory"];
                  }
                }
              }
              return Column(
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      color: Color(0xffF2F1F3),
                    ),
                    width: double.infinity,
                    child: Padding(
                      padding: EdgeInsets.all(20.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: const Icon(
                              Icons.arrow_back_rounded,
                              color: Color(0xff001B2E),
                              size: 30,
                            ),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          const Text(
                            "Workout Plan Exercise",
                            style: const TextStyle(fontSize: 30, color: Color(0xff001B2E), fontWeight: FontWeight.w700),
                          )
                        ],
                      ),
                    ),
                  ),
                  workoutHistory != null
                      ? Expanded(
                          child: Container(
                          margin: EdgeInsets.only(bottom: 30),
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(20),
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
                                                workoutDetail: workoutHistory?[index] as Map<String, dynamic>,
                                                dataExisted: true,
                                              )));
                                    },
                                    child: Container(
                                      margin: EdgeInsets.only(bottom: 20),
                                      decoration: BoxDecoration(
                                        color: Color(0xffffc49b),
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
                        ))
                      : const Center(
                          child: Text("Loading..."),
                        )
                ],
              );
            },
          )),
    );
  }

  // This will be the first function that will be called when this page loads
  Future<Map<String, dynamic>>? firstLoad() async {
    List? workoutHistory;

    // Try to get workoutHistory from SecureStorage
    try {
      workoutHistory = jsonDecode(await SecureStorage.readStorage("workoutHistory"));
    } catch (e) {
      print("There is no workoutHistory yet");
    }
    return {"workoutHistory": workoutHistory};
  }
}
