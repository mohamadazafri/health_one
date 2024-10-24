import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:health_one/dashboard/diagnose/gpt.dart';

class DiagnosePage extends StatefulWidget {
  final String imagePath;

  const DiagnosePage({super.key, required this.imagePath});

  @override
  State<DiagnosePage> createState() => _DiagnosePageState();
}

class _DiagnosePageState extends State<DiagnosePage> {
  late Future widgetFuture;
  Map<String, dynamic>? gptResponse;
  Map<String, dynamic>? diagnoseResult;

  @override
  void initState() {
    super.initState();
    widgetFuture = firstLoad();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: FutureBuilder(
            future: widgetFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasError) {
                  return Container(
                    child: Text("Error"),
                  );
                } else if (snapshot.hasData) {
                  // print(snapshot.data);
                  gptResponse = snapshot.data;
                  diagnoseResult = jsonDecode(gptResponse!["choices"][0]["message"]["content"]);
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
                            "Diagnose result",
                            style: const TextStyle(fontSize: 30, color: Color(0xff001B2E), fontWeight: FontWeight.w700),
                          )
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      color: Color(0xffF2F1F3),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 20.0, left: 30, right: 30),
                        child: Column(
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
                                  File(widget.imagePath),
                                  height: 150.0,
                                  width: 100.0,
                                ),
                              ),
                            ),
                            Expanded(
                                child: Container(
                              width: double.infinity,
                              child: gptResponse != null
                                  ? SingleChildScrollView(
                                      child:
                                          Column(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.start, children: [
                                        Text(
                                          diagnoseResult!["name of finding"]!,
                                          style: const TextStyle(fontSize: 32, fontWeight: FontWeight.w700),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(bottom: 20),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              const Text(
                                                "Explanation",
                                                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                                              ),
                                              Text(
                                                diagnoseResult!["explanation of finding"]!,
                                                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(bottom: 20),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              const Text(
                                                "What should you do",
                                                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                                              ),
                                              Text(
                                                diagnoseResult!["next steps"]!,
                                                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(bottom: 20),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              const Text(
                                                "Recommendations",
                                                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                                              ),
                                              Text(
                                                diagnoseResult!["recommendations"]!,
                                                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                                              )
                                            ],
                                          ),
                                        ),
                                      ]),
                                    )
                                  : Container(
                                      child: Text("Loading response"),
                                    ),
                            ))
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }),
      ),
    );
  }

  Future firstLoad() async {
    return await imageProcessingGPT4Model(widget.imagePath);
  }
}
