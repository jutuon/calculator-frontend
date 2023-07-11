
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:calculator_frontend/data/account_repository.dart";

import "package:freezed_annotation/freezed_annotation.dart";
import 'package:flutter/foundation.dart';

part 'initial_setup.freezed.dart';

@freezed
class InitialSetupData with _$InitialSetupData {
  factory InitialSetupData({
    @Default("") String email,
    String? sendError,
    @Default(false) bool sendingInProgress,
    @Default(0) int currentStep,
  }) = _InitialSetupData;
}

abstract class InitialSetupEvent {}

class SetAccountStep extends InitialSetupEvent {
  final String email;
  SetAccountStep(this.email);
}
class GoBack extends InitialSetupEvent {
  final int? step;
  GoBack(this.step);
}

class InitialSetupBloc extends Bloc<InitialSetupEvent, InitialSetupData> {
  final AccountRepository account;

  InitialSetupBloc(this.account) : super(InitialSetupData()) {
    on<SetAccountStep>((data, emit) async {
      emit(state.copyWith(
        email: data.email,
        sendingInProgress: true,
        sendError: null,
      ));

      var error = await account.doInitialSetup(
        data.email,
      );

      if (error != null) {
        emit(state.copyWith(
          sendingInProgress: false,
          sendError: error,
        ));
      }
    });
    on<GoBack>((requestedStep, emit) {
      final stepIndex = requestedStep.step;
      int newIndex;
      if (stepIndex == null && state.currentStep > 0) {
        newIndex = state.currentStep - 1;
      } else if (stepIndex != null && stepIndex < state.currentStep) {
        newIndex = stepIndex;
      } else {
        newIndex = state.currentStep;
      }
      emit(state.copyWith(
        currentStep: newIndex,
      ));
    });
  }
}
