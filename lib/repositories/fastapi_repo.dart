///instantiated in the PlanController for use on list of plans to send
///https://flutter.dev/docs/cookbook/networking/send-data
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'dart:convert';

import '../models/plan.dart';

class FastApiClient {
  ///need port number
  final String? defaultUri;
  //final String defaultUri = 'http://localhost:8000';

  FastApiClient({@Default('http://localhost:8000') this.defaultUri});
  //Future<http.Response> sendPlan(Map<String,dynamic planMap) async{
  Future<http.Response> sendPlan(Plan plan) async {
    final String json = jsonEncode(plan);

    return await http.post(Uri.parse(defaultUri!),
        headers: <String, String>{
          'Content-type': 'application/json; charset=UTF-8',
        },
        body: json);
  }

  Future<List<Plan>?> getPlans() async {
    final List<Plan> planList;
    Uri url = Uri.parse(defaultUri!);
    http.Response response = await http.get(url);
    if (response.statusCode == HttpStatus.ok) {
      planList = jsonDecode(response.body);
    } else {
      print('error: ${response.statusCode}');
      return null;
    }
    return planList;
  }
}
