///Change to Riverpod

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

import './models/data_layer.dart';
import './controllers/plan_controller.dart';
import './controllers/tasks_controller.dart';
import '../repositories/shared_prefs_repo.dart';

//first way
//final plansProvider = StateNotifierProvider((ref) => PlanController());

//put one in each PlanController
final tasksNotifierProvider =
    StateNotifierProvider<TasksController, List<Task>>(
        (ref) => TasksController());

/*
Future<List<Plan>> getSharedPrefs() async {
  SharedPreferencesRepo sharedPreferencesRepo = SharedPreferencesRepo();
  List<Plan> plansList = [];

  final savedMaps = await sharedPreferencesRepo.getPlans();
  for (Map<String, dynamic> p in savedMaps) {
    plansList.add(Plan.fromJson(p));
  }
  return plansList;
}
*/
//final plansProvider = StateNotifierProvider<PlanController, List<Plan>>(
//  (ref) => PlanController((List<Plan>)getSharedPrefs() ?? []));

final plansProvider = StateNotifierProvider<PlanController, List<Plan>>(
    (ref) => PlanController([])..loadState());

/*
final plansProvider = StateNotifierProvider<PlanController, List<Plan>>((ref) {
  final plansList = getSharedPrefs();
  if (plansList is List<Plan>) {
    return PlanController(plansList);
  } else {
    return PlanController([]);
  }
  
});
*/
//second way using listen

//assigned a function that returns plans?
//can do something with plans in function body

//final plans = Provider((ref) {
  //ref.listen<List<Plan>>(plansProvider, (List<Plan> plans) {
    //for (Plan p in plans) print(p);
  //});
//});

//or just use the ref.listen inside build method of widget
//ConsumerWidget 
//use ref.read(someProvider.notifier).function() if using onPressed 
//elevated button
