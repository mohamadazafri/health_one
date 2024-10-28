import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:health_one/dashboard/diagnose/gpt.dart';
import 'package:health_one/storage.dart';

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
                  return Container(
                    child: Text("Error"),
                  );
                } else if (snapshot.hasData) {
                  gptResponse = snapshot.data;
                  if (widget.diagnoseDetail != null) {
                    diagnoseResult = gptResponse;
                  } else {
                    diagnoseResult = jsonDecode(gptResponse!["choices"][0]["message"]["content"]);
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
                            )),
                          ],
                        ),
                      ),
                    ),
                  ),
                  widget.diagnoseDetail == null
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
                                                          "Back to chat",
                                                          style: TextStyle(
                                                              fontWeight: FontWeight.w600,
                                                              color: validToSave ? Color(0xffF2F1F3) : Color.fromARGB(117, 0, 27, 46)),
                                                        )
                                                      : Text(
                                                          "Save this result",
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
              );
            }),
      ),
    );
  }

  Future firstLoad() async {
    if (widget.diagnoseDetail != null) {
      return widget.diagnoseDetail;
    } else {
      return await imageProcessingGPT4Model(widget.imagePath);
    }
  }
}
