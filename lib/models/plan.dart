//holds all tasks
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:json_serializable/builder.dart';
import 'package:json_serializable/json_serializable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:flutter/foundation.dart';

import './task.dart';

part 'plan.g.dart';
part 'plan.freezed.dart';

@freezed
class Plan with _$Plan {
  //final List<Task>? tasks; // = [];

  const Plan._();

  const factory Plan(
      {@Default('') String name, @Default([]) List<Task> tasks}) = _Plan;

  factory Plan.fromJson(Map<String, dynamic> json) => _$PlanFromJson(json);
  Map<String,dynamic> toJson() => _$PlanToJson(this);

  int get completeCount => tasks.where((task) => task.complete).length;
  String get completenessMessage => '$completeCount ouf of ${tasks.length} tasks';
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