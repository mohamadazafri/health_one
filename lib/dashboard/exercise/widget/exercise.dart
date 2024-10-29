import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:health_one/dashboard/exercise/api/exercise_api.dart';
import 'package:health_one/dashboard/exercise/widget/exercise_detail.dart';
import 'package:health_one/dashboard/exercise/widget/workoutPlanForm.dart';
import 'package:shimmer/shimmer.dart';

class ExercisePage extends StatefulWidget {
  const ExercisePage({super.key});

  @override
  State<ExercisePage> createState() => _ExercisePageState();
}

class _ExercisePageState extends State<ExercisePage> {
  late Future myFuture;
  dynamic data;
  List<Map<String, dynamic>> exerciseDetail = [
    {"name": "cardio", "detail": null},
    {"name": "chest", "detail": null},
    {"name": "waist", "detail": null},
    // {"name": "shoulder", "detail": null},
    {"name": "back", "detail": null},
  ];

  @override
  void initState() {
    // TODO: implement initState

    myFuture = firstLoad();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: myFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return const Text("Something went wrong. Please try again next time");
            } else if (snapshot.hasData) {
              if (snapshot.data! == false) {
                // Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => Login()), (Route<dynamic> route) => false);
                return const Text("Something went wrong. Please try again next time");
              } else {
                if (data == null) {
                  data = snapshot.data! as Map;

                  data.forEach((key, value) {
                    exerciseDetail.forEach((exerciseValue) {
                      if (exerciseValue["name"] == key) {
                        exerciseValue["detail"] = value;
                      }
                    });
                  });
                }
              }
            }
          }
          return SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: const BoxDecoration(
                    color: Color(0xffF2F1F3),
                  ),
                  width: double.infinity,
                  child: const Padding(
                    padding: EdgeInsets.all(20.0),
                    child: Text(
                      "Let\'s exercise!",
                      style: TextStyle(fontSize: 30, color: Color(0xff001B2E), fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    color: Color(0xffF2F1F3),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24.0),
                          child: InkWell(
                            onTap: () async {
                              await Navigator.of(context).push(MaterialPageRoute(builder: (context) => const WorkoutPlanFormPage()));
                            },
                            child: Container(
                              margin: EdgeInsets.only(bottom: 20),
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Color(0xffFFC49B).withOpacity(1),
                                    offset: Offset(7, 7),
                                    blurRadius: 0,
                                    spreadRadius: 1,
                                  ),
                                ],
                                borderRadius: BorderRadius.circular(20),
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: AssetImage("assets/png/workout8.jpg"),
                                  colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.4), BlendMode.darken),
                                ),
                              ),
                              child: const Padding(
                                padding: EdgeInsets.all(20.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Generate Your Own Workout Plan",
                                        style: TextStyle(fontSize: 38, color: Colors.white, fontWeight: FontWeight.w700)),
                                    Text("by AI Trainer", style: TextStyle(fontSize: 24, color: Colors.white, fontWeight: FontWeight.w500)),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24.0),
                          child: Container(
                            margin: const EdgeInsets.only(bottom: 20),
                            child: const Text(
                              "Discover",
                              style: TextStyle(fontSize: 30, color: Color(0xff001B2E), fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                        Expanded(
                          child: SingleChildScrollView(
                            child: data != null
                                ? Column(
                                    children: List.generate(exerciseDetail.length, (index) {
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 24.0),
                                      child: InkWell(
                                        onTap: () async {
                                          if (exerciseDetail[index]["detail"] != null) {
                                            await Navigator.of(context).push(MaterialPageRoute(
                                                builder: (context) =>
                                                    ExerciseDetailPage(exerciseDetail[index]["detail"], exerciseDetail[index]["name"])));
                                          } else {
                                            Fluttertoast.showToast(
                                                msg: "Something went wrong. Please try again later",
                                                toastLength: Toast.LENGTH_SHORT,
                                                gravity: ToastGravity.CENTER,
                                                timeInSecForIosWeb: 1,
                                                backgroundColor: Color(0xff1d1c21),
                                                textColor: Colors.white,
                                                fontSize: 16.0);
                                          }
                                        },
                                        child: Container(
                                          margin: EdgeInsets.only(bottom: 20),
                                          width: MediaQuery.of(context).size.width,
                                          height: 200,
                                          decoration: BoxDecoration(
                                            boxShadow: [
                                              BoxShadow(
                                                color: Color(0xff1d1c21).withOpacity(1),
                                                offset: Offset(3, 3),
                                                blurRadius: 0,
                                                spreadRadius: 1,
                                              ),
                                            ],
                                            borderRadius: BorderRadius.circular(20),
                                            image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: AssetImage("assets/png/workout${index + 1}.jpg"),
                                              colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.4), BlendMode.darken),
                                            ),
                                          ),
                                          child: Padding(
                                            padding: EdgeInsets.all(20.0),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(exerciseDetail[index]["name"],
                                                    style: TextStyle(fontSize: 38, color: Colors.white, fontWeight: FontWeight.w700)),
                                                Text(data != null ? '${exerciseDetail[index]["detail"].length} Exercises' : "Loading...",
                                                    style: const TextStyle(fontSize: 24, color: Colors.white, fontWeight: FontWeight.w500)),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  }))
                                : Column(
                                    children: List.generate(5, (index) {
                                      return Padding(
                                        padding: const EdgeInsets.all(020),
                                        child: Container(
                                          width: double.infinity,
                                          height: 200,
                                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
                                          child: Shimmer.fromColors(
                                            baseColor: Color(0xffFFEFD3),
                                            highlightColor: Color(0xffFFC49B).withOpacity(0.2),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: Colors.white,
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
                                            ),
                                          ),
                                        ),
                                      );
                                    }),
                                  ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }

  Future<dynamic> firstLoad() async {
    dynamic cardioWorkout = await getWorkout("cardio");
    dynamic chestWorkout = await getWorkout("chest");
    dynamic waistWorkout = await getWorkout("waist");
    // dynamic shouldersWorkout = await getWorkout("shoulders");
    dynamic backWorkout = await getWorkout("back");

    Map<String, dynamic> response = {
      "cardio": cardioWorkout,
      "chest": chestWorkout,
      "waist": waistWorkout,
      // "shoulders": shouldersWorkout,
      "back": backWorkout
    };
    return response;
  }
}
