import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'dart:convert';

import '../models/data_layer.dart';

abstract class Repository {
  Future<List<Map<String, dynamic>>?> getPlans([String? key]);
  Future<dynamic> sendPlan(Plan plan);
}
