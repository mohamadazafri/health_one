import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:health_one/global.dart';
import 'package:health_one/storage.dart';

class GreetPage extends StatefulWidget {
  const GreetPage({super.key});

  @override
  State<GreetPage> createState() => _GreetPageState();
}

class _GreetPageState extends State<GreetPage> {
  final TextEditingController nameController = TextEditingController();

  bool _obscureText = true;
  bool _invalidDialog = false;
  bool _errorDialog = false;
  String? errorMessage;
  bool _nameFieldFill = false;

  void toggle_vis_password() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  void invalid_login_dialog() {
    setState(() {
      _invalidDialog = !_invalidDialog;
    });
  }

  void error_login_dialog(String response) {
    setState(() {
      _errorDialog = !_errorDialog;
      errorMessage = response;
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
                const Text(
                  "Health One",
                  style: TextStyle(fontFamily: "ABeeZee", color: Color(0xffDBCBD8), fontSize: 24, fontWeight: FontWeight.w600),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 12),
                  child: const Text(
                    "What is your name",
                    style: TextStyle(fontFamily: "ABeeZee", color: Color(0xffDBCBD8), fontSize: 18),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 32),
                  child: Theme(
                    data: Theme.of(context).copyWith(splashColor: Colors.transparent),
                    child: TextField(
                      controller: nameController,
                      onTapOutside: (event) {
                        FocusManager.instance.primaryFocus?.unfocus();
                      },
                      onChanged: (value) => {
                        if (value.isNotEmpty) {setState(() => _nameFieldFill = true)} else {setState(() => _nameFieldFill = false)}
                      },
                      autofocus: false,
                      style: TextStyle(color: Color(0xff101935)),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        // hintText: 'John',

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
                          backgroundColor: (_nameFieldFill) ? WidgetStatePropertyAll(Color(0xff9AD4D6)) : WidgetStatePropertyAll(Color(0xffF5F6F8)),
                          foregroundColor: WidgetStatePropertyAll(Colors.black)),
                      onPressed: () async {
                        await SecureStorage.writeStorage("name", nameController.text);
                        Navigator.of(context).pushNamed('/', arguments: {"homeCurrentIndex": 0, "camera": GlobalValue().getCameras()});
                      },
                      child: Text(
                        "Continue",
                        style: TextStyle(color: (_nameFieldFill) ? Color(0xff101935) : Color(0xff9AD4D6)),
                      ),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // bool login() {
  //   bool success;

  //   if (emailController.text == "" && passwordController.text == "") {
  //     success = true;
  //   } else {
  //     success = false;
  //   }
  //   return success;
  // }
}
