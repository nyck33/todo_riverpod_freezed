import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:master_plan/services/fastapi_service.dart';
import '../models/data_layer.dart';
import '../repositories/fastapi_repo.dart';
import '../repositories/shared_prefs_repo.dart';

//import 'tasks_controller.dart';

class PlanController extends StateNotifier<List<Plan>> {
  PlanController([List<Plan>? initialPlans]) : super(initialPlans ?? []);

  //List<Plan> state = [];

  //plans to save to backend, can send them one by one
  List<Map<String, dynamic>> planMaps = [];

  //the service to divide each plan
  FastApiClient apiClient = FastApiClient();
  FastApiService fastApiService = FastApiService();

  //SharedPreferences
  SharedPreferencesRepo sharedPreferencesRepo = SharedPreferencesRepo();

  //This public getter cannot be modified by any other object
  //immutable list of plans
  List<Plan> get plans => List.unmodifiable(state);

  void loadState() async {
    final plansJsons = await sharedPreferencesRepo.getPlans();
    final List<Plan> plansList = [];
    if (plansJsons != null) {
      for (Map<String, dynamic> p in plansJsons) {
        plansList.add(Plan.fromJson(p));
      }
    }
    print(
        'controller load: plansList.length: ${plansList.length}, plansList: $plansList');
    state = plansList;
  }

  void addNewPlan(String name) {
    if (name.isEmpty) {
      return;
    }
    name = _checkForDuplicates(state.map((plan) => plan.name!), name);

    List<Plan> newPlanList = [...state, Plan(name: name)];
    state = newPlanList;
    savePlansLocal(state);
  }

  ///unused
  void deletePlan(Plan plan) {
    //state.remove(plan);
    List<Plan> newPlanList = [
      for (Plan p in state)
        if (p.name != plan.name) p
    ];
    state = newPlanList;

    savePlansLocal(state);
  }

  void savePlans(List<Plan> plans) {
    fastApiService.dividePlans(plans);
  }

  Future<void> savePlansLocal(List<Plan> plans) async {
    //can call it after each change to state
    await sharedPreferencesRepo.sendPlans(state);
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

    //List<Task> newTasksList = [...plan.tasks!, newTask];

    state = [
      for (Plan p in state)
        if (p.name! == plan.name!)
          p.copyWith(name: plan.name!, tasks: [...p.tasks!, newTask])
        else
          p
    ];
    savePlansLocal(state);
  }

  void updateTask(Plan plan, Task oldTask, Task updatedTask) async {
    //params: plan is target, oldTask is target
    //find the old task with description and replace with new task
    print('in updateTask');
    //List<Task> newTasksList = [...plan.tasks, updatedTask];

    List<Plan> newPlans = [];
    List<Task> newTasks = [];

    for (Plan p in state) {
      if (p.name! == plan.name!) {
        for (Task t in p.tasks!) {
          if (t.description! == oldTask.description!) {
            newTasks.add(updatedTask);
          } else {
            newTasks.add(t);
          }
        }
      }
    }
    state = [
      for (Plan p in state)
        if (p.name! == plan.name!)
          p.copyWith(name: plan.name!, tasks: newTasks)
        else
          p
    ];
    await savePlansLocal(state);
  }

  ///unused
  void deleteTask(Plan plan, Task task) {
    final List<Task> newTasks = [
      for (var t in plan.tasks!)
        if (t.description! != task.description!) t
    ];
    //state = state.copyWith()
  }

  String showNumTasksComplete(Plan plan) {
    int completeCount = 0;
    int numTasks = 0;
    for (Plan p in state) {
      if (p.name! == plan.name!) {
        completeCount =
            p.tasks!.where((task) => (task.complete! == true)).length;
        numTasks = p.tasks!.length;
      }
    }

    return '$completeCount ouf of $numTasks tasks';
  }

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
