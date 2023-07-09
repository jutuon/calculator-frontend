
import "dart:math";

import "package:flutter_bloc/flutter_bloc.dart";
import "package:openapi/api.dart";
import "package:calculator_frontend/data/account_repository.dart";
import 'package:calculator_frontend/data/calculator_repository.dart';
import "package:calculator_frontend/logic/account/initial_setup.dart";
import "package:calculator_frontend/ui/initial_setup.dart";
import "package:calculator_frontend/utils.dart";
import "package:rxdart/rxdart.dart";

import "package:freezed_annotation/freezed_annotation.dart";
import 'package:flutter/foundation.dart';

part 'calculator.freezed.dart';

@freezed
class CalculatorData with _$CalculatorData {
  factory CalculatorData({
    String? state,
  }) = _CalculatorData;
}

sealed class CalculatorEvent {}
class SetCalculatorState extends CalculatorEvent {
  final String state;
  SetCalculatorState(this.state);
}

class Reset extends CalculatorEvent {
  Reset();
}
class DoOperation extends CalculatorEvent {
  final CalculatorOperation value;
  final int number;
  DoOperation(this.value, this.number);
}
class LoadCalculatorState extends CalculatorEvent {
  LoadCalculatorState();
}

enum CalculatorOperation {
  add,
  subtract,
  multiply,
  divide,
  equals,
}

class CalculatorBloc extends Bloc<CalculatorEvent, CalculatorData> with ActionRunner {
  final AccountRepository account;
  final CalculatorRepository calculator;

  CalculatorOperation? _previousOperation;
  int _previousNumber = 0;

  CalculatorBloc(this.account, this.calculator) : super(CalculatorData()) {
    on<SetCalculatorState>((data, emit) async {
      emit(state.copyWith(state: data.state));
    });
    on<Reset>((data, emit) async {
      _previousNumber = 0;
      _previousOperation = null;
      emit(state.copyWith(state: ""));
    });
    on<DoOperation>((data, emit) async {
      print("previous: ${_previousNumber}, ${_previousOperation}, current: ${data.value}");
      final int number;
      try {
        number = _previousNumber;
      } catch (e) {
        // not a number
        print("Not a number");
        return;
      }
      switch (data.value){
        case CalculatorOperation.add ||
          CalculatorOperation.subtract ||
          CalculatorOperation.multiply ||
          CalculatorOperation.divide: {

          if (_previousOperation == null) {
            final int value = handleOperation(data.value, number, data.number, neutral: true);
            _previousOperation = data.value;
            _previousNumber = value;
            print("new previous: ${_previousNumber}, ${_previousOperation}");
          } else {
            final int value = handleOperation(data.value, number, data.number);
            _previousOperation = data.value;
            _previousNumber = value;
            print("new previous: ${_previousNumber}, ${_previousOperation}");
          }
        }
        case CalculatorOperation.equals: {
          final int value = handleOperation(_previousOperation ?? CalculatorOperation.equals, number, data.number);
          _previousOperation = null;
          _previousNumber = value;
          print("new previous: ${_previousNumber}, ${_previousOperation}");
          emit(state.copyWith(state: value.toString()));
          await calculator.setState(value.toString());
        }
      }
    });
    on<LoadCalculatorState>((data, emit) async {
      await runOnce(() async {
        final calculatorState = await calculator.requestCurrentState();

        if (calculatorState != null) {
          emit(state.copyWith(state: calculatorState));
        }
      });
    });

    calculator
      .requestCurrentState()
      .then((value) => add(SetCalculatorState(value ?? "")));
  }

int handleOperation(CalculatorOperation op, int number, int newNumber, { bool neutral = false }) {
  print("handle operation: ${op}, ${number}, ${newNumber}");

  if (neutral) {
    return newNumber;
  }

  final int r;
  switch (op) {
      case CalculatorOperation.add: {
        r = number + newNumber;
      }
      case CalculatorOperation.subtract: {
        r = number - newNumber;
      }
      case CalculatorOperation.multiply: {
        r = number * newNumber;
      }
      case CalculatorOperation.divide: {
        r = number ~/ newNumber;
      }
      case CalculatorOperation.equals: {
        r = newNumber;
      }
    }
    return r;
  }
}
