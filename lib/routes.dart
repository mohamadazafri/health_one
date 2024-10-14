import 'package:flutter/material.dart';
import 'package:health_one/base.dart';
import 'package:health_one/login.dart';

Map<String, Widget Function(BuildContext)> routes = {
  '/': (context) {
    Map<String, dynamic>? args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
    return Base(
      homeCurrentIndex: args!["homeCurrentIndex"],
      camera: args!["camera"],
    );
  },

  '/login': (context) => LoginPage(),

  // '/update_documents': (context) {
  //   Map args = ModalRoute.of(context)!.settings.arguments as Map<dynamic, dynamic>;
  //   return ComplianceUpdateDocuments(args["documentDetail"], args["status"]);
  // },
};
