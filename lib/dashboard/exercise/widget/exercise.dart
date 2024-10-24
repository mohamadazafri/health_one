import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:health_one/dashboard/exercise/api/exercise_api.dart';
import 'package:health_one/dashboard/exercise/widget/exercise_detail.dart';

class ExercisePage extends StatefulWidget {
  const ExercisePage({super.key});

  @override
  State<ExercisePage> createState() => _ExercisePageState();
}

class _ExercisePageState extends State<ExercisePage> {
  late Future myFuture;
  dynamic data;

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
                    child: DefaultTabController(
                      length: 3,
                      child: Column(
                        children: [
                          const Padding(
                            padding: EdgeInsets.all(30.0),
                            child: TabBar(
                              isScrollable: true,
                              tabAlignment: TabAlignment.start,
                              tabs: [
                                Tab(
                                  child: Text("Beginner", style: TextStyle(fontSize: 16, color: Color(0xff101935), fontWeight: FontWeight.w500)),
                                ),
                                Tab(
                                  child: Text("Intermediate", style: TextStyle(fontSize: 16, color: Color(0xff101935), fontWeight: FontWeight.w500)),
                                ),
                                Tab(
                                  child: Text("Advanced", style: TextStyle(fontSize: 16, color: Color(0xff101935), fontWeight: FontWeight.w500)),
                                )
                              ],
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
                              child: TabBarView(
                                children: [
                                  SingleChildScrollView(
                                    child: Column(
                                      children: [
                                        InkWell(
                                          onTap: () async {
                                            await Navigator.of(context)
                                                .push(MaterialPageRoute(builder: (context) => ExerciseDetailPage(data["cardioWorkout"], "Cardio")));
                                          },
                                          child: Container(
                                            margin: EdgeInsets.only(bottom: 20),
                                            width: MediaQuery.of(context).size.width,
                                            height: 200,
                                            decoration: BoxDecoration(
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Color(0xFF9a9a9a).withOpacity(1),
                                                  offset: Offset(7, 5),
                                                  blurRadius: 19,
                                                  spreadRadius: -3,
                                                ),
                                              ],
                                              borderRadius: BorderRadius.circular(20),
                                              image: DecorationImage(
                                                fit: BoxFit.cover,
                                                image: AssetImage("assets/png/workout1.jpg"),
                                                colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.4), BlendMode.darken),
                                              ),
                                            ),
                                            child: Padding(
                                              padding: EdgeInsets.all(20.0),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  const Row(
                                                    children: [
                                                      FaIcon(
                                                        FontAwesomeIcons.dumbbell,
                                                        color: Color(0xff9AD4D6),
                                                      ),
                                                      SizedBox(
                                                        width: 12,
                                                      ),
                                                      FaIcon(
                                                        FontAwesomeIcons.dumbbell,
                                                        color: Color(0xffF2FDFF),
                                                      ),
                                                      SizedBox(
                                                        width: 12,
                                                      ),
                                                      FaIcon(
                                                        FontAwesomeIcons.dumbbell,
                                                        color: Color(0xffF2FDFF),
                                                      ),
                                                    ],
                                                  ),
                                                  const Text('Abs', style: TextStyle(fontSize: 38, color: Colors.white, fontWeight: FontWeight.w700)),
                                                  Text(data != null ? '${data["cardioWorkout"].length} Exercises' : "Loading...",
                                                      style: const TextStyle(fontSize: 24, color: Colors.white, fontWeight: FontWeight.w500)),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(bottom: 20),
                                          width: MediaQuery.of(context).size.width,
                                          height: 200,
                                          decoration: BoxDecoration(
                                            boxShadow: [
                                              BoxShadow(
                                                color: Color(0xFF9a9a9a).withOpacity(1),
                                                offset: Offset(7, 5),
                                                blurRadius: 19,
                                                spreadRadius: -3,
                                              ),
                                            ],
                                            borderRadius: BorderRadius.circular(20),
                                            image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: AssetImage("assets/png/workout2.jpg"),
                                              colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.4), BlendMode.darken),
                                            ),
                                          ),
                                          child: Padding(
                                            padding: EdgeInsets.all(20.0),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                const Row(
                                                  children: [
                                                    FaIcon(
                                                      FontAwesomeIcons.dumbbell,
                                                      color: Color(0xff9AD4D6),
                                                    ),
                                                    SizedBox(
                                                      width: 12,
                                                    ),
                                                    FaIcon(
                                                      FontAwesomeIcons.dumbbell,
                                                      color: Color(0xffF2FDFF),
                                                    ),
                                                    SizedBox(
                                                      width: 12,
                                                    ),
                                                    FaIcon(
                                                      FontAwesomeIcons.dumbbell,
                                                      color: Color(0xffF2FDFF),
                                                    ),
                                                  ],
                                                ),
                                                const Text('Chest', style: TextStyle(fontSize: 38, color: Colors.white, fontWeight: FontWeight.w700)),
                                                Text(data != null ? '${data["chestWorkout"].length} Exercises' : "Loading...",
                                                    style: const TextStyle(fontSize: 24, color: Colors.white, fontWeight: FontWeight.w500)),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(bottom: 20),
                                          width: MediaQuery.of(context).size.width,
                                          height: 200,
                                          decoration: BoxDecoration(
                                            boxShadow: [
                                              BoxShadow(
                                                color: Color(0xFF9a9a9a).withOpacity(1),
                                                offset: Offset(7, 5),
                                                blurRadius: 19,
                                                spreadRadius: -3,
                                              ),
                                            ],
                                            borderRadius: BorderRadius.circular(20),
                                            image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: AssetImage("assets/png/workout3.jpg"),
                                              colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.4), BlendMode.darken),
                                            ),
                                          ),
                                          child: Padding(
                                            padding: EdgeInsets.all(20.0),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                const Row(
                                                  children: [
                                                    FaIcon(
                                                      FontAwesomeIcons.dumbbell,
                                                      color: Color(0xff9AD4D6),
                                                    ),
                                                    SizedBox(
                                                      width: 12,
                                                    ),
                                                    FaIcon(
                                                      FontAwesomeIcons.dumbbell,
                                                      color: Color(0xffF2FDFF),
                                                    ),
                                                    SizedBox(
                                                      width: 12,
                                                    ),
                                                    FaIcon(
                                                      FontAwesomeIcons.dumbbell,
                                                      color: Color(0xffF2FDFF),
                                                    ),
                                                  ],
                                                ),
                                                const Text('Waist', style: TextStyle(fontSize: 38, color: Colors.white, fontWeight: FontWeight.w700)),
                                                Text(data != null ? '${data["waistWorkout"].length} Exercises' : "Loading...",
                                                    style: const TextStyle(fontSize: 24, color: Colors.white, fontWeight: FontWeight.w500)),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(bottom: 20),
                                          width: MediaQuery.of(context).size.width,
                                          height: 200,
                                          decoration: BoxDecoration(
                                            boxShadow: [
                                              BoxShadow(
                                                color: Color(0xFF9a9a9a).withOpacity(1),
                                                offset: Offset(7, 5),
                                                blurRadius: 19,
                                                spreadRadius: -3,
                                              ),
                                            ],
                                            borderRadius: BorderRadius.circular(20),
                                            image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: AssetImage("assets/png/workout7.jpg"),
                                              colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.4), BlendMode.darken),
                                            ),
                                          ),
                                          child: Padding(
                                            padding: EdgeInsets.all(20.0),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                const Row(
                                                  children: [
                                                    FaIcon(
                                                      FontAwesomeIcons.dumbbell,
                                                      color: Color(0xff9AD4D6),
                                                    ),
                                                    SizedBox(
                                                      width: 12,
                                                    ),
                                                    FaIcon(
                                                      FontAwesomeIcons.dumbbell,
                                                      color: Color(0xffF2FDFF),
                                                    ),
                                                    SizedBox(
                                                      width: 12,
                                                    ),
                                                    FaIcon(
                                                      FontAwesomeIcons.dumbbell,
                                                      color: Color(0xffF2FDFF),
                                                    ),
                                                  ],
                                                ),
                                                const Text('Back', style: TextStyle(fontSize: 38, color: Colors.white, fontWeight: FontWeight.w700)),
                                                Text(data != null ? '${data["backWorkout"].length} Exercises' : "Loading...",
                                                    style: const TextStyle(fontSize: 24, color: Colors.white, fontWeight: FontWeight.w500)),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(bottom: 20),
                                          width: MediaQuery.of(context).size.width,
                                          height: 200,
                                          decoration: BoxDecoration(
                                            boxShadow: [
                                              BoxShadow(
                                                color: Color(0xFF9a9a9a).withOpacity(1),
                                                offset: Offset(7, 5),
                                                blurRadius: 19,
                                                spreadRadius: -3,
                                              ),
                                            ],
                                            borderRadius: BorderRadius.circular(20),
                                            image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: AssetImage("assets/png/workout7.jpg"),
                                              colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.4), BlendMode.darken),
                                            ),
                                          ),
                                          child: Padding(
                                            padding: EdgeInsets.all(20.0),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                const Row(
                                                  children: [
                                                    FaIcon(
                                                      FontAwesomeIcons.dumbbell,
                                                      color: Color(0xff9AD4D6),
                                                    ),
                                                    SizedBox(
                                                      width: 12,
                                                    ),
                                                    FaIcon(
                                                      FontAwesomeIcons.dumbbell,
                                                      color: Color(0xffF2FDFF),
                                                    ),
                                                    SizedBox(
                                                      width: 12,
                                                    ),
                                                    FaIcon(
                                                      FontAwesomeIcons.dumbbell,
                                                      color: Color(0xffF2FDFF),
                                                    ),
                                                  ],
                                                ),
                                                const Text('Shoulder',
                                                    style: TextStyle(fontSize: 38, color: Colors.white, fontWeight: FontWeight.w700)),
                                                Text(data != null ? '${data["cardioWorkout"].length} Exercises' : "Loading...",
                                                    style: const TextStyle(fontSize: 24, color: Colors.white, fontWeight: FontWeight.w500)),
                                              ],
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Icon(Icons.directions_transit),
                                  Icon(Icons.directions_bike),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
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
    dynamic shouldersWorkout = await getWorkout("shoulders");
    dynamic backWorkout = await getWorkout("back");

    Map<String, dynamic> response = {
      "cardioWorkout": cardioWorkout,
      "chestWorkout": chestWorkout,
      "waistWorkout": waistWorkout,
      "shouldersWorkout": shouldersWorkout,
      "backWorkout": backWorkout
    };
    return response;
  }
}
