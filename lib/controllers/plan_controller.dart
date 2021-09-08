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
  List _plans = <Plan>[];

  PlanController(this._plans) : super([]);

  //This public getter cannot be modified by any other object
  //List<Plan> get plans => List.unmodifiable(_plans);
  List<dynamic> get plans => _plans;
  void addNewPlan(String name) {
    if (name.isEmpty) {
      return;
    }
    name = _checkForDuplicates(_plans.map((plan) => plan.name), name);

    List<Plan> newPlanList = [..._plans, Plan(name: name)];
    _plans = newPlanList;
  }

  void deletePlan(Plan plan) {
    //_plans.remove(plan);
    List<Plan> newPlanList = [
      for (Plan p in plans)
        if (p.name != plan.name) p
    ];
    _plans = newPlanList;
  }

  void createNewTask(Plan plan, [String? description]) {
    if (description == null || description.isEmpty) {
      description = 'New Task';
    }

    description = _checkForDuplicates(
        plan.tasks.map((task) => task.description), description);
    bool complete = false;
    final Task newTask = Task(description: description, complete: complete);
    List<Task> newTaskList = [...plan.tasks, newTask];
    Plan newPlan = Plan(name: plan.name, tasks: newTaskList);
    //remove the plan, and add a new Plan with newTaskList
    _plans = [
      for (Plan p in _plans)
        {
          if (p.name == plan.name)
            newPlan.copyWith(name: plan.name, tasks: newTaskList)
          else
            p
        }
    ];
  }

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
