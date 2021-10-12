import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

//import 'package:path/path.dart';
//import 'package:sqflite/sqflite.dart';
import 'package:flutter/widgets.dart';
import 'package:master_plan/plan_provider.dart';
import './repositories/shared_prefs_repo.dart';
import './models/data_layer.dart';
import './views/plan_creator_screen.dart';

class Logger extends ProviderObserver {
  @override
  void didUpdateProvider(
    ProviderBase provider,
    Object? previousValue,
    Object? newValue,
    ProviderContainer container,
  ) {
    print('''
    {
      "provider": "${provider.name ?? provider.runtimeType}",
      "newValue": "$newValue"
  }''');
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences? prefs = await SharedPreferences.getInstance();

  List<Plan> plansFromSP = [];
  final List<dynamic>? plansJsons;
  final String plansKey = "plans";

  try {
    plansJsons = jsonDecode(prefs?.getString(plansKey) ?? '[]');
    print('loadStateEarly plansJson: $plansJsons');
    //final List<Plan> plansArr = [];
    //return plansJsons;
    if (plansJsons != null) {
      for (Map<String, dynamic> p in plansJsons) {
        //plansList.add(Plan.fromJson(p));
        plansFromSP.add(Plan.fromJson(p));
      }
    }
    // plansArr;
  } catch (err) {
    print('repo getPlans error: $err');
  }

  //create local
  runApp(ProviderScope(
      observers: [Logger()], child: MasterPlanApp(plans: plansFromSP)));
}

class MasterPlanApp extends ConsumerStatefulWidget {
  //SharedPreferences? prefs;
  List<Plan>? plans;
  MasterPlanApp({Key? key, required this.plans}) : super(key: key);
  @override
  _MasterPlanAppState createState() => _MasterPlanAppState(plansFromSP: plans);
}

class _MasterPlanAppState extends ConsumerState<MasterPlanApp> {
  //SharedPreferences? prefs;
  List<Plan>? plansFromSP = [];

  _MasterPlanAppState({Key? key, required this.plansFromSP});

  @override
  initState() {
    super.initState();
    //if (prefs != null) loadStateEarly(prefs);
  }

  void loadStateEarly(SharedPreferences? prefs) {
    final String plansKey = "plans";
    print('loadStateEarly MasterPlanApp');
    //SharedPreferencesRepo sharedPreferencesRepo = SharedPreferencesRepo();
    //final plansJsons = await sharedPreferencesRepo.getPlans();
    final List<dynamic>? plansJsons;
    try {
      plansJsons = jsonDecode(prefs!.getString(plansKey) ?? '[]');
      print('loadStateEarly plansJson: $plansJsons');
      //final List<Plan> plansArr = [];
      //return plansJsons;
      if (plansJsons != null) {
        for (Map<String, dynamic> p in plansJsons) {
          //plansList.add(Plan.fromJson(p));
          plansFromSP?.add(Plan.fromJson(p));
        }
      }
      // plansArr;
    } catch (err) {
      print('repo getPlans error: $err');
    }
  }

  @override
  Widget build(BuildContext context) {
    //start up the provider early as possible
    ref.watch(plansProvider.notifier);
    //now load state, maybe use prefs
    ref.read(plansProvider.notifier).loadState(plansFromSP);

    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.purple),
      home: PlanCreatorScreen(),
    );
  }
}
