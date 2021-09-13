import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/data_layer.dart';
import './abstract_repo.dart';

final _plans_key = 'plans';

class SharedPreferencesRepo {
  SharedPreferencesRepo();

  Future<void>? sendPlans(List<Plan> plans) async {
    //print('repo sendPlans: $plans');
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String json;
    try {
      json = jsonEncode(plans);
      print('sendPlans json $json');
      prefs.setString(_plans_key, json);
    } catch (err) {
      print('error sendPlans: $err');
    }
  }

  Future<dynamic>? getPlans([String? key]) async {
    //if (key == null) return null;
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final List<dynamic> plansJsons;
    try {
      plansJsons = jsonDecode(prefs.getString(_plans_key) ?? '[]');
      print('repo getPlans: $plansJsons');

      return plansJsons;
    } catch (err) {
      print('repo getPlans error: $err');
      return null;
    }
  }
}
