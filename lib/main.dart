import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:health_one/global.dart';
import 'package:health_one/login.dart';
import 'package:health_one/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final cameras = await availableCameras();

  final firstCamera = cameras.first;

  GlobalValue().setCameras(firstCamera);

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
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      // home: const LoginPage(),
    );
  }
}
