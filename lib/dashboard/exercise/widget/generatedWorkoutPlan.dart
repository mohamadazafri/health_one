import 'dart:convert';

import 'package:dynamic_tabbar/dynamic_tabbar.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:health_one/storage.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';

class GeneratedWorkoutPlanPage extends StatefulWidget {
  Map<String, dynamic>? workoutDetail;
  bool? dataExisted;
  GeneratedWorkoutPlanPage({this.workoutDetail, this.dataExisted, super.key});

  @override
  State<GeneratedWorkoutPlanPage> createState() => _GeneratedWorkoutPlanPageState();
}

class _GeneratedWorkoutPlanPageState extends State<GeneratedWorkoutPlanPage> {
  bool validToSave = true;
  bool isLoading = false;
  bool resultSaved = false;

  void setResultSaved() {
    setState(() {
      resultSaved = !resultSaved;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF2F1F3),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 00),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(children: [
                Container(
                  margin: EdgeInsets.only(bottom: 20),
                  width: MediaQuery.of(context).size.width,
                  height: 320,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Color(0xFF9a9a9a).withOpacity(1),
                        offset: Offset(7, 5),
                        blurRadius: 19,
                        spreadRadius: -3,
                      ),
                    ],
                    borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20)),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage("assets/png/workout3.jpg"),
                      colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.4), BlendMode.darken),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 14),
                  decoration: BoxDecoration(
                      color: Color(0xffF2F1F3).withOpacity(0.9),
                      borderRadius:
                          BorderRadius.only(bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20), topRight: Radius.circular(20))),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: const Icon(
                              Icons.arrow_back_rounded,
                              color: Color(0xff001B2E),
                              size: 30,
                            )),
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                widget.workoutDetail!["result"]["goal"],
                                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 32, overflow: TextOverflow.clip),
                              ),
                            ),
                          ],
                        ),
                        Text(
                          widget.workoutDetail!["result"]["fitness_level"],
                          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 32),
                          overflow: TextOverflow.clip,
                        ),
                        Container(
                          child: Text(
                            "${widget.workoutDetail!["result"]["schedule"]["days_per_week"].toString()} days per week",
                            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 32),
                          ),
                        ),
                        Container(
                          child: Text(
                            "${widget.workoutDetail!["result"]["schedule"]["session_duration"].toString()} minutes",
                            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 32),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ]),
              Expanded(
                child: DynamicTabBarWidget(
                  indicatorColor: Color(0xff001B2E),
                  labelColor: Color(0xff001B2E),
                  dynamicTabs: List.generate(widget.workoutDetail!["result"]["exercises"].length, (index) {
                    return TabData(
                        index: index,
                        title: Tab(
                          text: widget.workoutDetail!["result"]["exercises"][index]["day"],
                        ),
                        content: Padding(
                          padding: const EdgeInsets.only(top: 10, bottom: 0, left: 10, right: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: SingleChildScrollView(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: List.generate(widget.workoutDetail!["result"]["exercises"][index]["exercises"].length, (exerciseIndex) {
                                      return InkWell(
                                        onTap: () {
                                          showBottomSheet(
                                              context,
                                              widget.workoutDetail!["result"]["exercises"][index]["exercises"][exerciseIndex]["name"],
                                              widget.workoutDetail!["result"]["exercises"][index]["exercises"][exerciseIndex]["instructions"]);
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Container(
                                            margin: EdgeInsets.only(bottom: 10),
                                            width: double.infinity,
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
                                              padding: const EdgeInsets.all(30.0),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Expanded(
                                                        child: Text(
                                                          widget.workoutDetail!["result"]["exercises"][index]["exercises"][exerciseIndex]["name"],
                                                          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 28),
                                                          overflow: TextOverflow.clip,
                                                        ),
                                                      ),
                                                      Icon(Icons.arrow_circle_right_rounded)
                                                    ],
                                                  ),
                                                  Text(
                                                    "Duration: ${widget.workoutDetail!["result"]["exercises"][index]["exercises"][exerciseIndex]["duration"]}",
                                                    style: TextStyle(fontWeight: FontWeight.w400, fontSize: 18),
                                                  ),
                                                  Text(
                                                    "Repetitions: ${widget.workoutDetail!["result"]["exercises"][index]["exercises"][exerciseIndex]["repetitions"]} times",
                                                    style: TextStyle(fontWeight: FontWeight.w400, fontSize: 18),
                                                  ),
                                                  Text(
                                                    "Sets: ${widget.workoutDetail!["result"]["exercises"][index]["exercises"][exerciseIndex]["sets"]} sets",
                                                    style: TextStyle(fontWeight: FontWeight.w400, fontSize: 18),
                                                  ),
                                                  Text(
                                                    "Equipment: ${widget.workoutDetail!["result"]["exercises"][index]["exercises"][exerciseIndex]["equipment"]}",
                                                    style: TextStyle(fontWeight: FontWeight.w400, fontSize: 18),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    }),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ));
                  }),
                  isScrollable: true,
                  onTabControllerUpdated: (controller) {},
                  onTabChanged: (index) {},
                  onAddTabMoveTo: MoveToTab.last,
                  showBackIcon: true,
                  showNextIcon: true,
                ),
              ),
              // widget.workoutDetail != null
              widget.dataExisted == null
                  ? Container(
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
                                  boxShadow: validToSave
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
                                  onPressed: resultSaved
                                      ? () {
                                          Navigator.pushNamedAndRemoveUntil(context, '/', (Route route) => false, arguments: {"homeCurrentIndex": 2});
                                        }
                                      : (() async {
                                          try {
                                            String history = await SecureStorage.readStorage("workoutHistory");
                                            List workoutHistoryEncoded = jsonDecode(history);
                                            workoutHistoryEncoded.add(widget.workoutDetail);

                                            String workoutHistory = jsonEncode(workoutHistoryEncoded);
                                            await SecureStorage.writeStorage("workoutHistory", workoutHistory);
                                          } catch (e) {
                                            String workoutHistory = jsonEncode([widget.workoutDetail]);
                                            await SecureStorage.writeStorage("workoutHistory", workoutHistory);
                                          } finally {
                                            Fluttertoast.showToast(
                                                msg: "Successfully saved",
                                                toastLength: Toast.LENGTH_SHORT,
                                                gravity: ToastGravity.CENTER,
                                                timeInSecForIosWeb: 1,
                                                backgroundColor: Color(0xff294C60),
                                                textColor: Colors.white,
                                                fontSize: 16.0);

                                            setResultSaved();
                                          }
                                        }),
                                  style: ButtonStyle(
                                    elevation: WidgetStatePropertyAll(0),
                                    shape: WidgetStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    )),
                                    backgroundColor: WidgetStatePropertyAll(resultSaved ? Color.fromARGB(255, 19, 35, 44) : Color(0xff294C60)),
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
                                              resultSaved
                                                  ? Text(
                                                      "Back to exercise",
                                                      style: TextStyle(
                                                          fontWeight: FontWeight.w600,
                                                          color: validToSave ? Color(0xffF2F1F3) : Color.fromARGB(117, 0, 27, 46)),
                                                    )
                                                  : Text(
                                                      "Save this workout plan",
                                                      style: TextStyle(
                                                          fontWeight: FontWeight.w600,
                                                          color: validToSave ? Color(0xffF2F1F3) : Color.fromARGB(117, 0, 27, 46)),
                                                    )
                                            ],
                                          ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ))
                  : Container()
            ],
          ),
        ),
      ),
    );
  }

  Future showBottomSheet(BuildContext context, String workoutName, List instructions) {
    return showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        isDismissible: true,
        enableDrag: true,
        builder: (BuildContext context) {
          return Wrap(children: [
            Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(12), topRight: Radius.circular(12)),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0xffB3BAC3).withOpacity(0.25),
                      spreadRadius: 0,
                      blurRadius: 4,
                      offset: Offset(0, -4),
                    ),
                  ],
                ),
                child: Align(
                  alignment: FractionalOffset.bottomCenter,
                  child: Container(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 40),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.only(bottom: 16),
                            child: Text(
                              workoutName,
                              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 28),
                            ),
                          ),
                          ...List.generate(instructions.length, (index) {
                            return Container(
                              margin: EdgeInsets.only(bottom: 20),
                              child: Text(
                                "${index + 1}. ${instructions[index]}",
                                style: TextStyle(fontWeight: FontWeight.w400, fontSize: 18),
                              ),
                            );
                          }),
                        ],
                      ),
                    ),
                  ),
                )),
          ]);
        });
  }
}
