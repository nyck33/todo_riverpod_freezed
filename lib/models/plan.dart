//holds all tasks
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'dart:convert';
import './task.dart';
import '../controllers/tasks_controller.dart';

part 'plan.g.dart';
part 'plan.freezed.dart';

///nested Task class to Json
///https://flutter.dev/docs/development/data-and-backend/json#manual-encoding
@freezed //(explicitToJson: true)
class Plan with _$Plan {
  //TasksController tasksController = TasksController();

  Plan._();

  factory Plan({@Default('') String? name, @Default([]) List<Task>? tasks}) =
      _Plan;

  factory Plan.fromJson(Map<String, dynamic> json) => _$PlanFromJson(json);
  //Map<String, dynamic> toJson() => _$PlanToJson(this);

  //param Plan should be this when called
  Map<String, dynamic> myToJson(Plan plan) {
    //todo: need to have top level dict with plan.name{} for multiple plans
    //or put button on plan_screen
    //returns a json-like list of dicts
    final String? name = plan.name;
    final List<Task>? tasks = plan.tasks;

    final Map<String, dynamic> json = {"name": name, "tasks": []};

    late List taskJsonList;

    if (tasks != null) {
      taskJsonList = [];
    } else {
      taskJsonList = [];
      for (Task task in tasks!) {
        final description = task.description;
        final complete = task.complete;
        var taskDict = {};
        taskDict['description'] = description;
        taskDict['complete'] = complete;
        taskJsonList.add(taskDict);
      }
    }

    json[name]['tasks'] = taskJsonList;

    return json;
  }

  List<Task>? get tasks => this.tasks;

  String? get name => this.name;
  int? get completeCount =>
      this.tasks!.where((task) => (task.complete! == true)).length;
  String? get completenessMessage =>
      //tasks == null ? 'null' : '$completeCount ouf of ${tasks!.length} tasks';
      '$completeCount ouf of ${this.tasks!.length} tasks';
}

/*
class Plan {
  String name = '';
  final List<Task> tasks = [];
  //show progress
  int get completeCount => tasks.where((task) => task.complete).length;
  String get completenessMessage =>
      '$completeCount ouf of ${tasks.length} tasks';
}
*/