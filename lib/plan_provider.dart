///Change to Riverpod
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter/foundation.dart';

import './models/data_layer.dart';
import './controllers/plan_controller.dart';

//first way
//final plansProvider = StateNotifierProvider((ref) => PlanController());

//second way using listen
final plansProvider = StateNotifierProvider<PlanController, List<Plan>>(
    (ref) => PlanController([]));
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
