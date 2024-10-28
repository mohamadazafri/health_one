import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:health_one/dashboard/exercise/api/gpt.dart';
import 'package:health_one/dashboard/exercise/widget/generatedWorkoutPlan.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';
import 'package:wheel_picker/wheel_picker.dart';

class WorkoutPlanFormPage extends StatefulWidget {
  const WorkoutPlanFormPage({super.key});

  @override
  State<WorkoutPlanFormPage> createState() => _WorkoutPlanFormStatePage();
}

class _WorkoutPlanFormStatePage extends State<WorkoutPlanFormPage> {
  String? level;
  String? goal;
  List<String> preference = [];
  List<String> equipment = [];
  List<int> daysOfWeek = [1, 2, 3, 4, 5, 6, 7];
  int frequency = 1;
  List<String> durationTime = ["30 minutes", "45 minutes", "1 hour", "1 hour 30 minutes", "2 hours"];
  int duration = 30;
  List<String> focus = [];
  bool validToSubmit = false;
  bool isLoading = false;

  void setLevel(String value) {
    setState(() {
      level = value;
    });
  }

  void setGoal(String value) {
    setState(() {
      goal = value;
    });
  }

  void setPreference(String value) {
    setState(() {
      if (preference.contains(value)) {
        preference.remove(value);
      } else {
        preference.add(value);
      }
    });
  }

  void setEquipment(String value) {
    setState(() {
      if (equipment.contains(value)) {
        equipment.remove(value);
      } else {
        equipment.add(value);
      }
    });
  }

  void setFrequency(int value) {
    setState(() {
      frequency = value;
    });
  }

  void setDuration(int value) {
    setState(() {
      duration = value;
    });
  }

  void setFocus(String value) {
    setState(() {
      if (focus.contains(value)) {
        focus.remove(value);
      } else {
        focus.add(value);
      }
    });
  }

  void setValidStoSubmit() {
    setState(() {
      if (level != null && goal != null && preference.isNotEmpty && equipment.isNotEmpty && focus.isNotEmpty) {
        validToSubmit = true;
      } else {
        validToSubmit = false;
      }
    });
  }

  void setIsLoading() {
    setState(() {
      isLoading = !isLoading;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xffF2F1F3),
        body: Column(
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
                      "Generate Workout Plan",
                      style: const TextStyle(fontSize: 30, color: Color(0xff001B2E), fontWeight: FontWeight.w700),
                    )
                  ],
                ),
              ),
            ),
            Expanded(
              child: Container(
                color: Color(0xffF2F1F3),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20.0, left: 30, right: 30),
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.only(bottom: 24),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: EdgeInsets.only(bottom: 6),
                                child: const Text(
                                  "Fitness Level",
                                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.w500, color: Color(0xff4E4E4E)),
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      setLevel("beginner");
                                      setValidStoSubmit();
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: level == "beginner" ? Color(0xffFFC49B) : Color(0xffFFF0E5),
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
                                        padding: EdgeInsets.all(20.0),
                                        child: Column(
                                          children: [
                                            Row(
                                              children: [
                                                FaIcon(
                                                  FontAwesomeIcons.dumbbell,
                                                  size: 20,
                                                ),
                                              ],
                                            ),
                                            Text("Beginner")
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      setLevel("intermediate");
                                      setValidStoSubmit();
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: level == "intermediate" ? Color(0xffFFC49B) : Color(0xffFFF0E5),
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
                                        padding: EdgeInsets.all(20.0),
                                        child: Column(
                                          children: [
                                            Row(
                                              children: [
                                                FaIcon(
                                                  FontAwesomeIcons.dumbbell,
                                                  size: 20,
                                                ),
                                              ],
                                            ),
                                            Text("Intermediate")
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      setLevel("advanced");
                                      setValidStoSubmit();
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: level == "advanced" ? Color(0xffFFC49B) : Color(0xffFFF0E5),
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
                                        padding: EdgeInsets.all(20.0),
                                        child: Column(
                                          children: [
                                            Row(
                                              children: [
                                                FaIcon(
                                                  FontAwesomeIcons.dumbbell,
                                                  size: 20,
                                                ),
                                              ],
                                            ),
                                            Text("Advanced")
                                          ],
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(bottom: 24),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: EdgeInsets.only(bottom: 6),
                                child: const Text(
                                  "Fitness Goal",
                                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.w500, color: Color(0xff4E4E4E)),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(bottom: 18),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Flexible(
                                      flex: 1,
                                      fit: FlexFit.tight,
                                      child: InkWell(
                                        onTap: () {
                                          setGoal("muscle building");
                                          setValidStoSubmit();
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: goal == "muscle building" ? Color(0xffFFC49B) : Color(0xffFFF0E5),
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
                                            padding: EdgeInsets.all(20.0),
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                Icon(
                                                  Icons.fitness_center_rounded,
                                                  size: 30,
                                                ),
                                                Text(
                                                  "Muscle building",
                                                  textAlign: TextAlign.center,
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Flexible(
                                      flex: 1,
                                      fit: FlexFit.tight,
                                      child: InkWell(
                                        onTap: () {
                                          setGoal("fat loss");
                                          setValidStoSubmit();
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: goal == "fat loss" ? Color(0xffFFC49B) : Color(0xffFFF0E5),
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
                                            padding: EdgeInsets.all(20.0),
                                            child: Column(
                                              children: [
                                                Icon(
                                                  Symbols.monitor_weight_loss_rounded,
                                                  size: 30,
                                                ),
                                                Text(
                                                  "Fat loss",
                                                  textAlign: TextAlign.center,
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(bottom: 18),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Flexible(
                                      flex: 1,
                                      fit: FlexFit.tight,
                                      child: InkWell(
                                        onTap: () {
                                          setGoal("endurance");
                                          setValidStoSubmit();
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: goal == "endurance" ? Color(0xffFFC49B) : Color(0xffFFF0E5),
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
                                            padding: EdgeInsets.all(20.0),
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                Icon(
                                                  Symbols.sprint,
                                                  size: 30,
                                                ),
                                                Text(
                                                  "Endurance",
                                                  textAlign: TextAlign.center,
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Flexible(
                                      flex: 1,
                                      fit: FlexFit.tight,
                                      child: InkWell(
                                        onTap: () {
                                          setGoal("strength");
                                          setValidStoSubmit();
                                        },
                                        child: Container(
                                          width: 150,
                                          decoration: BoxDecoration(
                                            color: goal == "strength" ? Color(0xffFFC49B) : Color(0xffFFF0E5),
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
                                            padding: EdgeInsets.all(20.0),
                                            child: Column(
                                              children: [
                                                Icon(
                                                  Symbols.sports_kabaddi_rounded,
                                                  size: 30,
                                                ),
                                                Text(
                                                  "Strength",
                                                  textAlign: TextAlign.center,
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(bottom: 18),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Flexible(
                                      flex: 1,
                                      fit: FlexFit.tight,
                                      child: InkWell(
                                        onTap: () {
                                          setGoal("combination");
                                          setValidStoSubmit();
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: goal == "combination" ? Color(0xffFFC49B) : Color(0xffFFF0E5),
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
                                            padding: EdgeInsets.all(20.0),
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                Icon(
                                                  Symbols.join_full_rounded,
                                                  size: 30,
                                                ),
                                                Text("Combination")
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(bottom: 24),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: EdgeInsets.only(bottom: 6),
                                child: const Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Workout Preference",
                                      style: TextStyle(fontSize: 28, fontWeight: FontWeight.w500, color: Color(0xff4E4E4E)),
                                    ),
                                    Text(
                                      "(can choose more than 1)",
                                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Color(0xff4E4E4E)),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(bottom: 18),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Flexible(
                                      flex: 1,
                                      fit: FlexFit.tight,
                                      child: InkWell(
                                        onTap: () {
                                          setPreference("bodyweight exercise");
                                          setValidStoSubmit();
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: preference.contains("bodyweight exercise") ? Color(0xffFFC49B) : Color(0xffFFF0E5),
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
                                            padding: EdgeInsets.all(20.0),
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                Icon(
                                                  Symbols.sports_martial_arts_rounded,
                                                  size: 30,
                                                ),
                                                Text(
                                                  "Bodyweight exercise",
                                                  textAlign: TextAlign.center,
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Flexible(
                                      flex: 1,
                                      fit: FlexFit.tight,
                                      child: InkWell(
                                        onTap: () {
                                          setPreference("weight training");
                                          setValidStoSubmit();
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: preference.contains("weight training") ? Color(0xffFFC49B) : Color(0xffFFF0E5),
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
                                            padding: EdgeInsets.all(20.0),
                                            child: Column(
                                              children: [
                                                Icon(
                                                  Symbols.weight_rounded,
                                                  size: 30,
                                                ),
                                                Text(
                                                  "Weight training",
                                                  textAlign: TextAlign.center,
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(bottom: 18),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Flexible(
                                      flex: 1,
                                      fit: FlexFit.tight,
                                      child: InkWell(
                                        onTap: () {
                                          setPreference("cardio");
                                          setValidStoSubmit();
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: preference.contains("cardio") ? Color(0xffFFC49B) : Color(0xffFFF0E5),
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
                                            padding: EdgeInsets.all(20.0),
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                Icon(
                                                  Symbols.cardiology_rounded,
                                                  size: 30,
                                                ),
                                                Text(
                                                  "Cardio",
                                                  textAlign: TextAlign.center,
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Flexible(
                                      flex: 1,
                                      fit: FlexFit.tight,
                                      child: InkWell(
                                        onTap: () {
                                          setPreference("combination");
                                          setValidStoSubmit();
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: preference.contains("combination") ? Color(0xffFFC49B) : Color(0xffFFF0E5),
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
                                            padding: EdgeInsets.all(20.0),
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                Icon(
                                                  Symbols.join_full_rounded,
                                                  size: 30,
                                                ),
                                                Text(
                                                  "Combination",
                                                  textAlign: TextAlign.center,
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(bottom: 24),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: EdgeInsets.only(bottom: 6),
                                child: const Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Available Equipment",
                                      style: TextStyle(fontSize: 28, fontWeight: FontWeight.w500, color: Color(0xff4E4E4E)),
                                    ),
                                    Text(
                                      "(can choose more than 1)",
                                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Color(0xff4E4E4E)),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(bottom: 18),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Flexible(
                                      flex: 1,
                                      fit: FlexFit.tight,
                                      child: InkWell(
                                        onTap: () {
                                          setEquipment("gym equipment");
                                          setValidStoSubmit();
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: equipment.contains("gym equipment") ? Color(0xffFFC49B) : Color(0xffFFF0E5),
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
                                            padding: EdgeInsets.all(20.0),
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                Icon(
                                                  Symbols.weight_rounded,
                                                  size: 30,
                                                ),
                                                Text(
                                                  "Gym equipment",
                                                  textAlign: TextAlign.center,
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Flexible(
                                      flex: 1,
                                      fit: FlexFit.tight,
                                      child: InkWell(
                                        onTap: () {
                                          setEquipment("dumbells");
                                          setValidStoSubmit();
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: equipment.contains("dumbells") ? Color(0xffFFC49B) : Color(0xffFFF0E5),
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
                                            padding: EdgeInsets.all(20.0),
                                            child: Column(
                                              children: [
                                                Icon(
                                                  Icons.fitness_center_rounded,
                                                  size: 30,
                                                ),
                                                Text(
                                                  "Dumbells",
                                                  textAlign: TextAlign.center,
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(bottom: 18),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Flexible(
                                      flex: 1,
                                      fit: FlexFit.tight,
                                      child: InkWell(
                                        onTap: () {
                                          setEquipment("resistance bands");
                                          setValidStoSubmit();
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: equipment.contains("resistance bands") ? Color(0xffFFC49B) : Color(0xffFFF0E5),
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
                                            padding: EdgeInsets.all(20.0),
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                Icon(
                                                  Symbols.diagonal_line_rounded,
                                                  size: 30,
                                                ),
                                                Text(
                                                  "Resistance bands",
                                                  textAlign: TextAlign.center,
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Flexible(
                                      flex: 1,
                                      fit: FlexFit.tight,
                                      child: InkWell(
                                        onTap: () {
                                          setEquipment("bodyweight exercises");
                                          setValidStoSubmit();
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: equipment.contains("bodyweight exercises") ? Color(0xffFFC49B) : Color(0xffFFF0E5),
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
                                            padding: EdgeInsets.all(20.0),
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                Icon(
                                                  Symbols.sports_martial_arts_rounded,
                                                  size: 30,
                                                ),
                                                Text(
                                                  "Bodyweight exercises",
                                                  textAlign: TextAlign.center,
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(bottom: 24),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: EdgeInsets.only(bottom: 6),
                                child: const Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      "Workout Frequency",
                                      style: TextStyle(fontSize: 28, fontWeight: FontWeight.w500, color: Color(0xff4E4E4E)),
                                    ),
                                    const Text(
                                      "How much you can work out in a week?",
                                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Color(0xff4E4E4E)),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                  height: 200,
                                  decoration: BoxDecoration(
                                    color: Color(0xffFFF0E5),
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
                                  width: double.infinity,
                                  child: WheelPicker(
                                    onIndexChanged: (index) {
                                      setFrequency(index + 1);
                                    },
                                    itemCount: 7,
                                    builder: (context, index) => Text(
                                      daysOfWeek[index].toString(),
                                      style: TextStyle(fontSize: 28),
                                    ),
                                    selectedIndexColor: Color.fromARGB(255, 252, 170, 113),
                                    looping: false,
                                    style: WheelPickerStyle(
                                      itemExtent: TextStyle(fontSize: 32.0, height: 1.5).fontSize! *
                                          TextStyle(fontSize: 32.0, height: 1.5).height!, // Text height
                                      squeeze: 1.25,
                                      diameterRatio: .8,
                                      surroundingOpacity: .25,
                                      magnification: 1.2,
                                    ),
                                  ))
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(bottom: 24),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: EdgeInsets.only(bottom: 6),
                                child: const Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      "Workout Duration",
                                      style: TextStyle(fontSize: 28, fontWeight: FontWeight.w500, color: Color(0xff4E4E4E)),
                                    ),
                                    const Text(
                                      "How long you want to work out?",
                                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Color(0xff4E4E4E)),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                  height: 200,
                                  decoration: BoxDecoration(
                                    color: Color(0xffFFF0E5),
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
                                  width: double.infinity,
                                  child: WheelPicker(
                                    onIndexChanged: (index) {
                                      int selectedDuration;
                                      switch (index) {
                                        case 0:
                                          selectedDuration = 30;
                                          break;
                                        case 1:
                                          selectedDuration = 45;
                                          break;
                                        case 2:
                                          selectedDuration = 60;
                                          break;
                                        case 3:
                                          selectedDuration = 90;
                                          break;
                                        case 4:
                                          selectedDuration = 120;
                                          break;
                                        default:
                                          selectedDuration = 30;
                                          break;
                                      }
                                      setDuration(selectedDuration);
                                    },
                                    itemCount: 5,
                                    builder: (context, index) => Text(
                                      durationTime[index].toString(),
                                      style: TextStyle(fontSize: 28),
                                    ),
                                    selectedIndexColor: Color.fromARGB(255, 252, 170, 113),
                                    looping: false,
                                    style: WheelPickerStyle(
                                      itemExtent: TextStyle(fontSize: 32.0, height: 1.5).fontSize! *
                                          TextStyle(fontSize: 32.0, height: 1.5).height!, // Text height
                                      squeeze: 1.25,
                                      diameterRatio: .8,
                                      surroundingOpacity: .25,
                                      magnification: 1.2,
                                    ),
                                  ))
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(bottom: 24),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: EdgeInsets.only(bottom: 6),
                                child: const Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Area of Focus",
                                      style: TextStyle(fontSize: 28, fontWeight: FontWeight.w500, color: Color(0xff4E4E4E)),
                                    ),
                                    Text(
                                      "(can choose more than 1)",
                                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Color(0xff4E4E4E)),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(bottom: 18),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Flexible(
                                      flex: 1,
                                      fit: FlexFit.tight,
                                      child: InkWell(
                                        onTap: () {
                                          setFocus("full body");
                                          setValidStoSubmit();
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: focus.contains("full body") ? Color(0xffFFC49B) : Color(0xffFFF0E5),
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
                                            padding: EdgeInsets.all(20.0),
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                Text(
                                                  "Full body",
                                                  textAlign: TextAlign.center,
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Flexible(
                                      flex: 1,
                                      fit: FlexFit.tight,
                                      child: InkWell(
                                        onTap: () {
                                          setFocus("upper body");
                                          setValidStoSubmit();
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: focus.contains("upper body") ? Color(0xffFFC49B) : Color(0xffFFF0E5),
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
                                            padding: EdgeInsets.all(20.0),
                                            child: Column(
                                              children: [
                                                Text(
                                                  "Upper body",
                                                  textAlign: TextAlign.center,
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(bottom: 18),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Flexible(
                                      flex: 1,
                                      fit: FlexFit.tight,
                                      child: InkWell(
                                        onTap: () {
                                          setFocus("lower body");
                                          setValidStoSubmit();
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: focus.contains("lower body") ? Color(0xffFFC49B) : Color(0xffFFF0E5),
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
                                            padding: EdgeInsets.all(20.0),
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                Text(
                                                  "Lower body",
                                                  textAlign: TextAlign.center,
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Flexible(
                                      flex: 1,
                                      fit: FlexFit.tight,
                                      child: InkWell(
                                        onTap: () {
                                          setFocus("core");
                                          setValidStoSubmit();
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: focus.contains("core") ? Color(0xffFFC49B) : Color(0xffFFF0E5),
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
                                            padding: EdgeInsets.all(20.0),
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                Text(
                                                  "Core",
                                                  textAlign: TextAlign.center,
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
                  color: Color(0xffF2F1F3),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0xffB3BAC3).withOpacity(0.25),
                      spreadRadius: 0,
                      blurRadius: 4,
                      offset: Offset(0, -4),
                    ),
                  ],
                ),
                height: 80,
                child: Align(
                  alignment: FractionalOffset.bottomCenter,
                  child: Container(
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: validToSubmit
                                ? [
                                    BoxShadow(
                                      color: Color(0xff1d1c21).withOpacity(1),
                                      offset: Offset(3, 3),
                                      blurRadius: 0,
                                      spreadRadius: 1,
                                    ),
                                  ]
                                : null,
                          ),
                          child: ElevatedButton(
                            onPressed: validToSubmit
                                ? () async {
                                    setIsLoading();

                                    dynamic response = await generateWorkoutPlanGPT4Model(
                                      level!,
                                      goal!,
                                      preference,
                                      equipment,
                                      frequency,
                                      duration,
                                      focus,
                                    );
                                    setIsLoading();
                                    try {
                                      Map<String, dynamic> data = jsonDecode(response["choices"][0]["message"]["content"]);
                                      Navigator.of(context).push(MaterialPageRoute(
                                          builder: (context) => GeneratedWorkoutPlanPage(
                                                workoutDetail: data,
                                              )));
                                    } catch (e) {
                                      Fluttertoast.showToast(
                                          msg: "Please try again",
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.CENTER,
                                          timeInSecForIosWeb: 1,
                                          backgroundColor: Color(0xff294C60),
                                          textColor: Colors.white,
                                          fontSize: 16.0);
                                    }
                                  }
                                : (() {}),
                            style: ButtonStyle(
                              elevation: WidgetStatePropertyAll(0),
                              shape: WidgetStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              )),
                              backgroundColor: WidgetStatePropertyAll(validToSubmit ? Color(0xff294C60) : Colors.white),
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 14),
                              child: isLoading
                                  ? const Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                          height: 25.0,
                                          width: 25.0,
                                          child: CircularProgressIndicator(
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    )
                                  : Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "Generate",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600, color: validToSubmit ? Color(0xffF2F1F3) : Color.fromARGB(117, 0, 27, 46)),
                                        ),
                                      ],
                                    ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
