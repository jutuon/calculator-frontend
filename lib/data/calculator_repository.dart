


import 'dart:async';

import 'package:http/http.dart';
import 'package:openapi/api.dart';
import 'package:calculator_frontend/api/api_manager.dart';
import 'package:calculator_frontend/api/api_provider.dart';
import 'package:calculator_frontend/logic/app/main_state.dart';
import 'package:calculator_frontend/utils.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CalculatorRepository extends AppSingleton {
  CalculatorRepository._private();
  static final _instance = CalculatorRepository._private();
  factory CalculatorRepository.getInstance() {
    return _instance;
  }

  @override
  Future<void> init() async {
    // nothing to do
  }


  final ApiManager api = ApiManager.getInstance();

  CalculatorRepository();

  Future<String?> requestCurrentState() async {
    final state = await api.calculator((api) => api.getCalculatorState());
    return state?.state;
  }

  Future<void> setState(String calculatorState) async {
    await api.calculator((api) => api.postCalculatorState(CalculatorState(state: calculatorState)));
  }
}
