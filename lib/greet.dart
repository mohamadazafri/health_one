import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:health_one/global.dart';
import 'package:health_one/storage.dart';

// This page will only been shown to first time user
// This page will appear if SecureStorage don't have any "name" key

class GreetPage extends StatefulWidget {
  const GreetPage({super.key});

  @override
  State<GreetPage> createState() => _GreetPageState();
}

class _GreetPageState extends State<GreetPage> {
  final TextEditingController nameController = TextEditingController();

  bool _invalidDialog = false;
  bool _errorDialog = false;
  String? errorMessage;
  bool _nameFieldFill = false;

  void showErrorDialog(bool value) {
    setState(() {
      _invalidDialog = value;
    });
  }

  void setErrorLoginDialog(bool value) {
    setState(() {
      _errorDialog = value;
    });
  }

  void setNameFieldFill(bool value) {
    setState(() {
      _nameFieldFill = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color(0xff101935),
      body: Center(
        child: Container(
          margin: EdgeInsets.only(top: 60),
          width: screenSize.width >= 500 ? screenSize.width - 200 : screenSize.width - 40,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.only(bottom: 40),
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Welcome to ",
                        style: TextStyle(fontFamily: "ABeeZee", color: Color(0xffffc49b), fontSize: 24, fontWeight: FontWeight.w400),
                      ),
                      const Text(
                        "Health One",
                        style: TextStyle(fontFamily: "ABeeZee", color: Color(0xffffc49b), fontSize: 32, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: _errorDialog ? 0 : 14),
                  child: const Text(
                    "What is your name?",
                    style: TextStyle(fontFamily: "ABeeZee", color: Color(0xffffefd3), fontSize: 18),
                  ),
                ),
                _invalidDialog
                    ? Container(
                        margin: EdgeInsets.only(bottom: 14),
                        child: const Text(
                          "Please enter your name?",
                          style: TextStyle(fontFamily: "ABeeZee", color: Color.fromARGB(255, 248, 124, 93), fontSize: 12),
                        ),
                      )
                    : Container(),
                Container(
                  margin: const EdgeInsets.only(bottom: 32),
                  child: Theme(
                    data: Theme.of(context).copyWith(splashColor: Colors.transparent),
                    child: TextField(
                      controller: nameController,
                      onTapOutside: (event) {
                        FocusManager.instance.primaryFocus?.unfocus();
                      },
                      onChanged: (value) {
                        if (value.isNotEmpty) {
                          setNameFieldFill(true);
                          setErrorLoginDialog(true);
                        } else {
                          setNameFieldFill(false);
                          setErrorLoginDialog(false);
                        }
                      },
                      autofocus: false,
                      style: TextStyle(color: Color(0xff101935)),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: 'John Doe',
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xffF2FDFF)),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Color(0xffF2FDFF)),
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                    margin: EdgeInsets.only(bottom: 20),
                    width: double.infinity,
                    height: 52,
                    child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor:
                              (_nameFieldFill) ? const WidgetStatePropertyAll(Color(0xff9AD4D6)) : const WidgetStatePropertyAll(Color(0xffF5F6F8)),
                          foregroundColor: const WidgetStatePropertyAll(Colors.black)),
                      onPressed: nameController.text != ""
                          ? () async {
                              await SecureStorage.writeStorage("name", nameController.text);
                              Navigator.of(context).pushNamed('/', arguments: {"homeCurrentIndex": 0, "camera": GlobalValue().getCameras()});
                            }
                          : () {
                              if (_errorDialog) {
                                showErrorDialog(true);
                              } else {
                                showErrorDialog(false);
                              }
                            },
                      child: Text(
                        "Continue",
                        style: TextStyle(color: (_nameFieldFill) ? Color(0xff101935) : Color(0xffadb6c4)),
                      ),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
