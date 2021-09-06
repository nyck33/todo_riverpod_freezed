import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter/foundation.dart';

import '../plan_provider.dart';
import '../models/data_layer.dart';
import '../controllers/plan_controller.dart';
import '../models/data_layer.dart';

class PlanController extends StateNotifier<List<Plan>> {
  final _plans = <Plan>[];

  PlanController() : super([]);

  //This public getter cannot be modified by any other object
  List<Plan> get plans => List.unmodifiable(_plans);

  void addNewPlan(String name) {
    if (name.isEmpty) {
      return;
    }
    name = _checkForDuplicates(_plans.map((plan) => plan.name), name);
    //found duplicate or not update or not name
    final plan = Plan()..name = name;
    _plans.add(plan);
  }

  void deletePlan(Plan plan) {
    _plans.remove(plan);
  }

  void createNewTask(Plan plan, [String? description]) {
    if (description == null || description.isEmpty) {
      description = 'New Task';
    }

    description = _checkForDuplicates(
        plan.tasks.map((task) => task.description), description);

    final task = Task()..description = description;
    //can't use setter for final field but can add to the list
    plan.tasks.add(task);
    //List<Task> tasks = plan.tasks;
    //plan.tasks = [...(plan.tasks), task];
  }

  //void deleteTask(Plan plan, Task task) {
  //plan.tasks.remove(task);
  //}

  void deleteTask(Plan plan, Task task) => [
        for (var t in plan.tasks)
          if (t.description != task.description) t
      ];

  //passed iterable which is a func that maps list plans to their names
  static String _checkForDuplicates(Iterable<String> items, String text) {
    //so if unique, duplicatedCount = 0 and don't relabel
    final duplicatedCount = items.where((item) => item.contains(text)).length;
    if (duplicatedCount > 0) {
      text += ' ${duplicatedCount + 1}'; //0 becomes 1???
    }
    return text;
  }
}
