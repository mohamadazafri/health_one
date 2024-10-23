import 'package:camera/camera.dart';
import 'package:dart_openai/dart_openai.dart';
import 'package:flutter/material.dart';
import 'package:health_one/global.dart';
import 'package:health_one/login/login.dart';
import 'package:health_one/routes.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Get data from env file
  await dotenv.load(fileName: ".env");

  // Configuration for using the camera in the app
  final cameras = await availableCameras();
  // final firstCamera = cameras.first;

  GlobalValue().setListCamera(cameras);
  // GlobalValue().setCameras(firstCamera);

  // Setting up OpenAI API
  OpenAI.apiKey = dotenv.env["OPENAI_API_KEY"]!;

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Health One',
      debugShowCheckedModeBanner: false,
      initialRoute: "/login",
      routes: routes,
      theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple), useMaterial3: true, fontFamily: "AfacadFlux"),
      // home: const LoginPage(),
    );
  }
}
