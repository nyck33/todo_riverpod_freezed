import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../plan_provider.dart';
import '../models/data_layer.dart';
import '../repositories/fastapi_repo.dart';

//import 'tasks_controller.dart';

class PlanController extends StateNotifier<List<Plan>> {
  List<Plan> _plans = [];
  PlanController() : super([]);

  //plans to save to backend, can send them one by one
  List<Map<String, dynamic>> planMaps = [];

  //the repo
  FastApiClient apiClient = FastApiClient();

  //This public getter cannot be modified by any other object
  //immutable list of plans
  List<Plan> get plans => List.unmodifiable(_plans);
  //List<Plan> get plans => _plans;
  void addNewPlan(String name) {
    if (name.isEmpty) {
      return;
    }
    name = _checkForDuplicates(_plans.map((plan) => plan.name!), name);

    List<Plan> newPlanList = [..._plans, Plan(name: name)];
    _plans = newPlanList;
  }

  ///unused
  void deletePlan(Plan plan) {
    //_plans.remove(plan);
    List<Plan> newPlanList = [
      for (Plan p in _plans)
        if (p.name != plan.name) p
    ];
    _plans = newPlanList;
  }

  void createNewTask(Plan plan, [String? description]) {
    //adds a new empty task to task list of plan
    print('in createNewTask');
    if (description == null || description.isEmpty) {
      description = 'New Task';
    }

    description = _checkForDuplicates(
        plan.tasks!.map((task) => task.description!), description);

    bool complete = false;
    final Task newTask = Task(description: description, complete: complete);

    List<Task> newTasksList = [...plan.tasks!, newTask];

    _plans = [
      for (Plan p in _plans)
        if (p.name! == plan.name!)
          p.copyWith(name: plan.name!, tasks: newTasksList)
        else
          p
    ];
  }

  void updateTask(Plan plan, Task oldTask, Task updatedTask) {
    //params: plan is target, oldTask is target
    //find the old task with description and replace with new task
    print('in updateTask');
    //List<Task> newTasksList = [...plan.tasks, updatedTask];

    List<Plan> newPlans = [];
    List<Task> newTasks = [];

    for (Plan p in _plans) {
      if (p.name! == plan.name!) {
        for (Task t in p.tasks!) {
          if (t.description! == oldTask.description!) {
            newTasks.add(updatedTask);
          } else {
            newTasks.add(t);
          }
        }
        final newPlan = plan.copyWith(name: plan.name, tasks: newTasks);
        newPlans.add(newPlan);
      } else {
        newPlans.add(p);
      }
    }
    _plans = newPlans;
  }

  ///unused
  void deleteTask(Plan plan, Task task) => [
        for (var t in plan.tasks!)
          if (t.description! != task.description!) t
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
