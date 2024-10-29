// This file contain all of the routes to each page in this application

import 'package:flutter/material.dart';
import 'package:health_one/dashboard/base.dart';
import 'package:health_one/dashboard/diagnose/widget/chat.dart';
import 'package:health_one/dashboard/diagnose/widget/diagnose_history.dart';
import 'package:health_one/dashboard/diagnose/widget/identifySickness.dart';
import 'package:health_one/dashboard/exercise/widget/exercise_history.dart';
import 'package:health_one/dashboard/exercise/widget/generatedWorkoutPlan.dart';
import 'package:health_one/dashboard/exercise/widget/workoutPlanForm.dart';
import 'package:health_one/greet.dart';

// This file contains all routes to each page
Map<String, Widget Function(BuildContext)> routes = {
  '/': (context) {
    Map<String, dynamic>? args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
    return Base(
      homeCurrentIndex: args?["homeCurrentIndex"],
      camera: args?["camera"],
    );
  },
  '/greet': (context) => const GreetPage(),

  // Routes for Diagnose
  '/identifySickness': (context) => const IdentifySicknessPage(),
  '/diagnoseHistory': (context) => const DiagnoseHistoryPage(),

  // Routes for Exercise
  '/workoutPlanForm': (context) => const WorkoutPlanFormPage(),
  '/exerciseHistory': (context) => const ExerciseHistoryPage(),
};
