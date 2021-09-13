///instantiated in the PlanController for use on list of plans to send
///https://flutter.dev/docs/cookbook/networking/send-data
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'dart:convert';

import '../models/data_layer.dart';
import './abstract_repo.dart';

class FastApiClient implements Repository {
  ///need port number
  final String defaultUri = 'todo-fastapi-flutter.herokuapp.com';
  final String path = 'plan/';
  //final String defaultUri = 'http://localhost:8000';
  //inet 172.18.0.1/16

  //String get defaultUri => defaultUri;

  //FastApiClient({@Default('http://localhost:8000') defaultUri});
  FastApiClient();
  //Future<http.Response> sendPlan(Map<String,dynamic planMap) async{
  /*
  Future<http.Response?> sendPlan(Plan plan) async {
    final String json = jsonEncode(plan);
    Uri url = Uri.https(defaultUri, path);
    print('uri: ${url.toString()}');
    try {
      http.Response response =
          await http.post(url, //Uri.parse(this.defaultUri),
              headers: <String, String>{
                'Content-Type': 'application/json',
              },
              body: json);
      print('response body: ${response.body}, status: ${response.statusCode}');
      return response;
    } catch (err) {
      print('FastApiClient error sendPlan: $err');
      return null;
    }
  }
  */
  Future<http.Response?> sendPlan(Plan plan) async {
    final String json = jsonEncode(plan);
    http.Response? response;
    Uri url = Uri.parse('https://todo-fastapi-flutter.herokuapp.com/plan/');
    try {
      response = await http.post(url, //Uri.parse(this.defaultUri),
          headers: <String, String>{
            'Content-Type': 'application/json',
          },
          body: json);
      print('response body: ${response.body}, status: ${response.statusCode}');
      return response;
    } catch (err) {
      print('FastApiClient error sendPlan: $err');
      return null;
    }
  }

  Future<List<Map<String, dynamic>>?> getPlans([String? key]) async {
    final List<Map<String, dynamic>> planList;
    Uri url = Uri.parse(defaultUri);
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
