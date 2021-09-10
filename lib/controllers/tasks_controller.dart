import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../plan_provider.dart';
import '../models/data_layer.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../plan_provider.dart';
import '../models/data_layer.dart';

class TasksController extends StateNotifier<List<Task>> {
  List<Task> _tasks = [];

  TasksController() : super([]);

  //This public getter cannot be modified by any other object
  //immutable list of plans
  List<Plan> get plans => List.unmodifiable(_tasks);
  //List<Plan> get plans => _plans;
  void addNewTask(String description) {
    if (description.isEmpty) {
      return;
    }
    description = _checkForDuplicates(
        _tasks.map((task) => task.description!), description);

    List<Task> newTasksList = [..._tasks, Task(description: description)];
    _tasks = newTasksList;
  }

  ///unused
  void deleteTask(Task task) {
    //_plans.remove(plan);
    List<Task> newTasksList = [
      for (Task t in _tasks)
        if (t.description != t.description) t
    ];
    _tasks = newTasksList;
  }

  //passed iterable which is a func that maps list plans to their descriptions
  static String _checkForDuplicates(Iterable<String> items, String text) {
    //so if unique, duplicatedCount = 0 and don't relabel
    final duplicatedCount = items.where((item) => item.contains(text)).length;
    if (duplicatedCount > 0) {
      text += ' ${duplicatedCount + 1}'; //0 becomes 1???
    }
    return text;
  }
}
