import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:health_one/dashboard/diagnose/widget/diagnose.dart';
import 'package:health_one/storage.dart';

// This file contains a widget to list down all vision diagnose history that user saved
// In this page, user get to preview back their diagnose history

class DiagnoseHistoryPage extends StatefulWidget {
  const DiagnoseHistoryPage({super.key});

  @override
  State<DiagnoseHistoryPage> createState() => _DiagnoseHistoryPageState();
}

class _DiagnoseHistoryPageState extends State<DiagnoseHistoryPage> {
  Map<String, dynamic>? data;
  List? diagnoseHistory;
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

                    diagnoseHistory = data!["diagnoseHistory"];
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
                            "Vision Diagnose History",
                            style: const TextStyle(fontSize: 30, color: Color(0xff001B2E), fontWeight: FontWeight.w700),
                          )
                        ],
                      ),
                    ),
                  ),
                  diagnoseHistory != null
                      ? Expanded(
                          child: SingleChildScrollView(
                          child: Container(
                            margin: EdgeInsets.only(bottom: 30),
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Column(
                                children: List.generate(diagnoseHistory!.length, (index) {
                                  return InkWell(
                                    onTap: () async {
                                      await Navigator.of(context).push(MaterialPageRoute(
                                          builder: (context) => DiagnosePage(
                                                imagePath: diagnoseHistory![index]["imagePath"],
                                                diagnoseDetail: diagnoseHistory![index],
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
                                }),
                              ),
                            ),
                          ),
                        ))
                      : Container(
                          child: Center(
                            child: Text("Loading..."),
                          ),
                        )
                ],
              );
            },
          )),
    );
  }

  // This will be the first function that will be called when this page loads
  Future<Map<String, dynamic>>? firstLoad() async {
    List? diagnoseHistory;

    // Try to get diagnoseHistory from SecureStorage
    try {
      diagnoseHistory = jsonDecode(await SecureStorage.readStorage("diagnoseHistory"));
    } catch (e) {
      print("There is no diagnoseHistory yet");
    }
    return {"diagnoseHistory": diagnoseHistory};
  }
}
