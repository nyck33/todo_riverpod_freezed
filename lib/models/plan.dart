//holds all tasks
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:flutter/foundation.dart';
import 'dart:convert';

import './task.dart';

part 'plan.g.dart';
part 'plan.freezed.dart';

@freezed
class Plan with _$Plan {
  const Plan._();

  const factory Plan(
      {@Default('') String name, @Default([]) List<Task> tasks}) = _Plan;

  factory Plan.fromJson(Map<String, dynamic> json) => _$PlanFromJson(json);
  //Map<String, dynamic> toJson() => _$PlanToJson(this);
  /*
  List<dynamic> myToJson(Plan plan) {
    final String name = plan.name;
    final List<Task>? tasks = plan.tasks;
    final Map<String, dynamic> json = {"plan_name": name, "tasks": []};

    if (tasks == null) return [];

    List taskJsonList = [];
    for (Task task in tasks) {
      final description = task.description;
      final complete = task.complete;
      var taskDict = {};
      taskDict['description'] = description;
      taskDict['complete'] = complete;
      taskJsonList.add(taskDict);
    }
    return taskJsonList;
  }
  */
  List<Task> get planTasks => tasks;

  String get planName => name;
  int get completeCount => tasks.where((task) => task.complete).length;
  String get completenessMessage =>
      //tasks == null ? 'null' : '$completeCount ouf of ${tasks!.length} tasks';
      '$completeCount ouf of ${tasks.length} tasks';
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