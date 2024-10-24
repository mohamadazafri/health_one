import 'package:dynamic_tabbar/dynamic_tabbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ExerciseDetailPage extends StatefulWidget {
  List<dynamic> exerciseDetail;
  String bodyPart;

  ExerciseDetailPage(this.exerciseDetail, this.bodyPart, {super.key});

  @override
  State<ExerciseDetailPage> createState() => _ExerciseDetailPageState();
}

class _ExerciseDetailPageState extends State<ExerciseDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
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
                borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20)),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage("assets/png/workout1.jpg"),
                  colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.4), BlendMode.darken),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(32.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Icon(
                        Icons.arrow_back_rounded,
                        color: Color(0xffF2FDFF),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(widget.bodyPart, style: const TextStyle(fontSize: 38, color: Color(0xffF2FDFF), fontWeight: FontWeight.w700)),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: DynamicTabBarWidget(
                  dynamicTabs: List.generate(widget.exerciseDetail.length, (index) {
                    return TabData(
                        index: index,
                        title: Tab(text: widget.exerciseDetail[index]["name"]),
                        content: Padding(
                          padding: const EdgeInsets.all(14.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(bottom: 32),
                                    height: 200,
                                    width: 200,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Color(0xFF9a9a9a).withOpacity(1),
                                            offset: Offset(7, 5),
                                            blurRadius: 19,
                                            spreadRadius: -3,
                                          ),
                                        ],
                                        image: const DecorationImage(
                                            fit: BoxFit.cover,
                                            image: AssetImage(
                                              "assets/gif/astrid jumps.gif",
                                            ))),
                                  ),
                                ],
                              ),
                              Expanded(
                                child: SingleChildScrollView(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: List.generate(widget.exerciseDetail[index]["instructions"].length, (instructionIndex) {
                                      return Container(
                                          margin: EdgeInsets.only(bottom: 20),
                                          child: Text("${instructionIndex + 1}. ${widget.exerciseDetail[index]["instructions"][instructionIndex]}"));
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
            )
          ],
        ),
      ),
    );
  }
}
