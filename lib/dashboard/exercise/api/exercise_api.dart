import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

// This file contain a list of function to make an API call

// Function to get workout detail from ExerciseDB API
Future<dynamic> getWorkout(String bodyPart) async {
  String rapidAPIKey = dotenv.env["RAPID_API_KEY"]!;
  Uri urlGetTeamMemberList = Uri.parse("https://exercisedb.p.rapidapi.com/exercises/bodyPart/$bodyPart");

  return await http.get(urlGetTeamMemberList,
      headers: <String, String>{"X-RapidAPI-Host": "exercisedb.p.rapidapi.com", "X-RapidAPI-Key": rapidAPIKey}).then((res) async {
    if (res.statusCode == 200) {
      List<dynamic> resData = jsonDecode(res.body);
      return resData;
    } else if (res.statusCode == 401) {
      Map<String, dynamic> resData = jsonDecode(res.body);
      if (resData["code"] == "token_not_valid") {
        if (kDebugMode) {
          print("ACCESS token expired! Claiming new ACCESS token using current REFRESH token...");
        }
      } else {
        return resData;
      }
    }
  });
}
