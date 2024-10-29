import 'package:dynamic_tabbar/dynamic_tabbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// This file contains a widget to list down a detail for each exercise
// In this page, user get to view in much detail about the exercise

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
                    color: const Color(0xFF9a9a9a).withOpacity(1),
                    offset: const Offset(7, 5),
                    blurRadius: 19,
                    spreadRadius: -3,
                  ),
                ],
                borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20)),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: const AssetImage("assets/png/workout1.jpg"),
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
                              Expanded(
                                child: SingleChildScrollView(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: List.generate(widget.exerciseDetail[index]["instructions"].length, (instructionIndex) {
                                      return Container(
                                          margin: const EdgeInsets.only(bottom: 20),
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
