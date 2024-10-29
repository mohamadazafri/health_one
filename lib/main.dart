import 'package:camera/camera.dart';
import 'package:dart_openai/dart_openai.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:health_one/global.dart';
import 'package:health_one/routes.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:health_one/storage.dart';

void main() async {
  String firstPage = "/greet";
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      systemNavigationBarColor: Color(0xff1d1c21), // navigation bar color

      statusBarColor: Color(0xff1d1c21), // status bar color
      statusBarIconBrightness: Brightness.light));

  // Get data from env file
  await dotenv.load(fileName: ".env");

  // Configuration for using the camera in the app
  final cameras = await availableCameras();

  // Store list of available Camera Description in GlobalValue class
  GlobalValue().setListCamera(cameras);

  // Setting up OpenAI API
  OpenAI.apiKey = dotenv.env["OPENAI_API_KEY"]!;

  // If there is no user name store in SecureStorage, we will lead user to '/greet' route to get their name first
  try {
    String? name = await SecureStorage.readStorage("name");
    firstPage = "/";
  } catch (e) {
    firstPage = "/greet";
  }

  runApp(MyApp(firstPage));
}

class MyApp extends StatelessWidget {
  String firstPage;
  MyApp(this.firstPage, {super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Health One',
      debugShowCheckedModeBanner: false,
      initialRoute: firstPage,
      routes: routes,
      theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple), useMaterial3: true, fontFamily: "AfacadFlux"),
    );
  }
}
