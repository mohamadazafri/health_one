import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:dart_openai/dart_openai.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

String generatePrompt(
  String level,
  String goal,
  List<String> preference,
  List<String> equipment,
  int frequency,
  int duration,
  List<String> focus,
) {
  String preferenceString = "";
  String equipmentString = "";
  String focusString = "";

  preference.forEach((value) {
    preferenceString += "$value, ";
  });
  equipment.forEach((value) {
    equipmentString += "$value, ";
  });
  focus.forEach((value) {
    focusString += "$value, ";
  });

  return """"
I want you to create a personalized workout plan for me based on the following details:

Fitness Level: $level.
Fitness Goals: My primary goal is $goal.
Workout Preference: I prefer $preferenceString.
Available Equipment: I have access to $equipmentString.
Workout Frequency: I can work out $frequency days per week.
Session Duration: Each workout should last $duration mins.
Areas of Focus: I want to focus on $focusString.

Based on this information, please generate a workout plan for me that spans in 4 weeks and includes progressive overload or changes in intensity as I progress.

Give me answer in JSON. The response will look like this: 
{
    "result": {
        "goal": "Build muscle",
        "fitness_level": "Intermediate",
        "total_weeks": 4,
        "schedule": {
            "days_per_week": 4,
            "session_duration": 60
        },
        "exercises": [
            {
                "day": "Monday",
                "exercises": [
                    {
                        "name": "Bench Press",
                        "duration": "15 minutes",
                        "repetitions": "8-12",
                        "sets": "4",
                        "equipment": "Barbell"
                        "instructions": // ... instruction step by step in array
                    },
                    // ... more exercises
                ]
            },
            // ... more days
        ],
    }
}

Please make sure the JSON can be decode by Dart language. Do not mention 'json' word in the string.
""";
}

Future<Map<String, dynamic>> generateWorkoutPlanGPT4Model(
  String level,
  String goal,
  List<String> preference,
  List<String> equipment,
  int frequency,
  int duration,
  List<String> focus,
) async {
  Uri url = Uri.parse("https://api.openai.com/v1/chat/completions");
  String apiAccessToken = dotenv.env["OPENAI_API_KEY"]!;

  String chatSystemPrompt = generatePrompt(level, goal, preference, equipment, frequency, duration, focus);

  final response = await http.post(
    url,
    headers: <String, String>{
      "Authorization": "Bearer $apiAccessToken",
      "Content-Type": "application/json",
    },
    body: jsonEncode({
      'model': "gpt-4o-mini",
      'messages': [
        {'role': 'system', 'content': chatSystemPrompt},
      ],
      'max_tokens': 2000,
    }),
  );

  Map<String, dynamic> resData = jsonDecode(response.body);
  if (response.statusCode == 200) {
    return resData;
  } else {
    return resData;
  }
}
