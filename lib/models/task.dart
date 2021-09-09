import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:flutter/foundation.dart';

part 'task.freezed.dart';
part 'task.g.dart';

@freezed
class Task with _$Task {
  //late String description;
  //late bool complete;

  const Task._();

  const factory Task(
      {@Default('') String description, @Default(false) bool complete}) = _Task;

  factory Task.fromJson(Map<String, dynamic> json) => _$TaskFromJson(json);

  //Map<String, dynamic> toJson() => _$TaskToJson(this);

  String get description => this.description;
  bool get complete => this.complete;

  @override
  String toString() {
    return "Task is $description, complete is $complete";
  }
}
