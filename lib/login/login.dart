import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:health_one/global.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool _obscureText = true;
  bool _invalidDialog = false;
  bool _errorDialog = false;
  String? errorMessage;
  bool _usernameFieldFill = false;
  bool _passwordFieldFill = false;

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
                // SvgPicture.asset(
                //   'assets/svg/logo-no-background.svg',
                //   height: 48,
                //   width: 69,
                // ),
                const Text(
                  "Health One",
                  style: TextStyle(fontFamily: "ABeeZee", color: Color(0xffDBCBD8), fontSize: 24, fontWeight: FontWeight.w600),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 12),
                  child: const Text(
                    "Email",
                    style: TextStyle(fontFamily: "ABeeZee", color: Color(0xffDBCBD8), fontSize: 18),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 32),
                  child: Theme(
                    data: Theme.of(context).copyWith(splashColor: Colors.transparent),
                    child: TextField(
                      controller: emailController,
                      onTapOutside: (event) {
                        FocusManager.instance.primaryFocus?.unfocus();
                      },
                      onChanged: (value) => {
                        if (value.isNotEmpty) {setState(() => _usernameFieldFill = true)} else {setState(() => _usernameFieldFill = false)}
                      },
                      autofocus: false,
                      style: TextStyle(color: Color(0xff101935)),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: 'john@doe.com',
                        // contentPadding: const EdgeInsets.symmetric(horizontal: 20),
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
                  margin: EdgeInsets.only(bottom: 12),
                  child: const Text(
                    "Password",
                    style: TextStyle(fontFamily: "ABeeZee", color: Color(0xffDBCBD8), fontSize: 18),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 15),
                  child: Theme(
                    data: Theme.of(context).copyWith(splashColor: Colors.transparent),
                    child: TextField(
                      controller: passwordController,
                      obscureText: _obscureText,
                      onTapOutside: (event) {
                        FocusManager.instance.primaryFocus?.unfocus();
                      },
                      onChanged: (value) => {
                        if (value.isNotEmpty) {setState(() => _passwordFieldFill = true)} else {setState(() => _passwordFieldFill = false)}
                      },
                      autofocus: false,
                      style: TextStyle(color: Color(0xff101935)),
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                            onPressed: () => {toggle_vis_password()},
                            icon: _obscureText ? Icon(Icons.visibility_off_outlined) : Icon(Icons.visibility_outlined)),
                        filled: true,
                        fillColor: Color(0xffF2FDFF),
                        hintText: '',
                        // contentPadding: const EdgeInsets.symmetric(horizontal: 20),
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
                          backgroundColor: (_usernameFieldFill && _passwordFieldFill)
                              ? WidgetStatePropertyAll(Color(0xff9AD4D6))
                              : WidgetStatePropertyAll(Color(0xffF5F6F8)),
                          foregroundColor: WidgetStatePropertyAll(Colors.black)),
                      onPressed: () async {
                        // dynamic response = await login(context, emailController.text, passwordController.text, null);

                        // if (response == false) {
                        //   if (!_invalidDialog) {
                        //     invalid_login_dialog();
                        //   }
                        // } else if (response == true) {
                        //   Navigator.push(
                        //       context, CupertinoPageRoute(builder: (context) => LoginOTP(username_controller.text, password_controller.text)));
                        // } else {
                        //   error_login_dialog(response as String);
                        // }

                        bool successLogin = login();
                        if (successLogin) {
                          Navigator.of(context).pushNamed('/', arguments: {"homeCurrentIndex": 0, "camera": GlobalValue().getCameras()});
                        }
                      },
                      child: Text(
                        "Log in",
                        style: TextStyle(color: (_usernameFieldFill && _passwordFieldFill) ? Color(0xff101935) : Color(0xff9AD4D6)),
                      ),
                    )),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  child: RichText(
                      text: TextSpan(children: [
                    const TextSpan(text: "Don't have an account? ", style: TextStyle(color: Color(0xffF2FDFF))),
                    WidgetSpan(
                        child: InkWell(
                      child: Text("Sign Up", style: TextStyle(color: Colors.blue.shade200, fontSize: 12)),
                    ))
                  ])),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  bool login() {
    bool success;

    if (emailController.text == "" && passwordController.text == "") {
      success = true;
    } else {
      success = false;
    }
    return success;
  }
}
