import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:health_one/dashboard/diagnose/gpt.dart';
import 'package:health_one/storage.dart';

// This file contains a widget to show the respond from GPT 4o regarding the picture that user just captured
// In this page, user get to know about their skin condition in detail
// User can save the detail for future reference

class DiagnosePage extends StatefulWidget {
  final String imagePath;
  dynamic diagnoseDetail;

  DiagnosePage({super.key, required this.imagePath, this.diagnoseDetail});

  @override
  State<DiagnosePage> createState() => _DiagnosePageState();
}

class _DiagnosePageState extends State<DiagnosePage> {
  late Future widgetFuture;
  Map<String, dynamic>? gptResponse;
  Map<String, dynamic>? diagnoseResult;
  bool validToSave = true;
  bool isLoading = false;
  bool resultSaved = false;

  @override
  void initState() {
    super.initState();
    widgetFuture = firstLoad();
  }

  // Function to set whether the diagnose result has been saved or not
  void setResultSaved() {
    setState(() {
      resultSaved = !resultSaved;
    });
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
                  String apiAccessToken = dotenv.env["OPENAI_API_KEY"]!;
                  return Container(
                    child: const Column(
                      children: [
                        Text("Error"),
                      ],
                    ),
                  );
                } else if (snapshot.hasData) {
                  gptResponse = snapshot.data;
                  if (widget.diagnoseDetail != null) {
                    diagnoseResult = gptResponse;
                  } else {
                    try {
                      diagnoseResult = jsonDecode(gptResponse!["choices"][0]["message"]["content"]);
                    } catch (e) {
                      return const Center(child: Text("Something went wrong. Please try again"));
                    }
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
                                      child: diagnoseResult!["code"] != "0"
                                          ? Column(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
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
                                                    margin: const EdgeInsets.only(bottom: 20),
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
                                                ])
                                          : Column(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                  const Text(
                                                    "Can't identify the picture",
                                                    style: TextStyle(fontSize: 32, fontWeight: FontWeight.w700),
                                                  ),
                                                  Container(
                                                    margin: EdgeInsets.only(bottom: 20),
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Text(
                                                          diagnoseResult!["message"]!,
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
                                                          "Disclaimer",
                                                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                                                        ),
                                                        Text(
                                                          diagnoseResult!["disclaimer"]!,
                                                          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ]),
                                    )
                                  : Container(
                                      child: Text("Loading response"),
                                    ),
                            )),
                          ],
                        ),
                      ),
                    ),
                  ),
                  widget.diagnoseDetail == null && diagnoseResult?["code"] != "0" && diagnoseResult != null
                      ? Container(
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
                            color: Color(0xffF2F1F3),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0xffB3BAC3).withOpacity(0.25),
                                spreadRadius: 0,
                                blurRadius: 4,
                                offset: const Offset(0, -4),
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
                                              Navigator.pushNamedAndRemoveUntil(context, '/', (Route route) => false,
                                                  arguments: {"homeCurrentIndex": 1});
                                            }
                                          : (() async {
                                              diagnoseResult!["imagePath"] = widget.imagePath;
                                              try {
                                                String history = await SecureStorage.readStorage("diagnoseHistory");
                                                List diagnoseHistoryEncoded = jsonDecode(history);
                                                diagnoseHistoryEncoded.add(diagnoseResult);

                                                String diagnoseHistory = jsonEncode(diagnoseHistoryEncoded);
                                                await SecureStorage.writeStorage("diagnoseHistory", diagnoseHistory);
                                              } catch (e) {
                                                String diagnoseHistory = jsonEncode([diagnoseResult]);
                                                await SecureStorage.writeStorage("diagnoseHistory", diagnoseHistory);
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
                                        backgroundColor:
                                            WidgetStatePropertyAll(resultSaved ? const Color.fromARGB(255, 19, 35, 44) : const Color(0xff294C60)),
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
                                                          "Back to chat",
                                                          style: TextStyle(
                                                              fontWeight: FontWeight.w600,
                                                              color: validToSave ? const Color(0xffF2F1F3) : const Color.fromARGB(117, 0, 27, 46)),
                                                        )
                                                      : Text(
                                                          "Save this result",
                                                          style: TextStyle(
                                                              fontWeight: FontWeight.w600,
                                                              color: validToSave ? const Color(0xffF2F1F3) : const Color.fromARGB(117, 0, 27, 46)),
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
              );
            }),
      ),
    );
  }

  // This will be the first function that will be called when this page loads
  Future firstLoad() async {
    if (widget.diagnoseDetail != null) {
      return widget.diagnoseDetail;
    } else {
      return await imageProcessingGPT4Model(widget.imagePath);
    }
  }
}
