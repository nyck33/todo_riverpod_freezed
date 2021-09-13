import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'dart:async';
//import 'package:path/path.dart';
//import 'package:sqflite/sqflite.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

import './views/plan_creator_screen.dart';

void main() async {
  //create local
  runApp(ProviderScope(child: MasterPlanApp()));
}

class MasterPlanApp extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.purple),
      home: PlanCreatorScreen(),
    );
  }
}
