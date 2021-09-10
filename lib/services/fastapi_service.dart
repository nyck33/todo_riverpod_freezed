///take list of plans and call sendPlans() in repo for one plan at a time
///capture the responses and show result or any errors to UI
///
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:http/http.dart' as http;

import '../models/data_layer.dart';
//done in Plan class toJson method
import '../repositories/fastapi_repo.dart';

class FastApiService {
  FastApiClient fastApiClient = FastApiClient();

  List<Plan>? _plansList = [];
  List<http.Response> _responseList = [];

  FastApiService(this._plansList);

  //calls savePlan on each iteration
  Future<void> dividePlans(List<Plan> plans) async {
    http.Response response;
    for (Plan p in plans) {
      response = await fastApiClient.sendPlan(p);
      _responseList.add(response);
    }
  }

  Future<void> getPlans() async {
    _plansList = await fastApiClient.getPlans();
  }
}
