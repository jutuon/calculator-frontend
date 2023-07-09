import "dart:ffi";
import "dart:io";
import "dart:math";

import "package:flutter/gestures.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:calculator_frontend/logic/account/initial_setup.dart";
import "package:calculator_frontend/logic/app/main_state.dart";
import "package:calculator_frontend/ui/login.dart";
import 'package:calculator_frontend/ui/normal.dart';
import "package:calculator_frontend/ui/utils.dart";
import "package:calculator_frontend/ui/utils/root_page.dart";

import "package:flutter/scheduler.dart";

class InitialSetupPage extends RootPage {
  const InitialSetupPage({Key? key}) : super(MainState.initialSetup, key: key);

  @override
  Widget buildRootWidget(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Setup your new account")),
        body: BlocListener<InitialSetupBloc, InitialSetupData>(
          listener: (context, state) {
            if (state.sendingInProgress && !Navigator.canPop(context)) {
              print("Show dialog");
              showDialog<void>(context: context, barrierDismissible: false, builder: (context) {
                return WillPopScope(
                  onWillPop: () async => false,
                  child: AlertDialog(
                    title: const Text("Sending in progress..."),
                    content: Row(mainAxisAlignment: MainAxisAlignment.center, children: const [
                      CircularProgressIndicator(),
                    ]),
                    actions: [],
                  ),
                );
              });
            } else if (!state.sendingInProgress && Navigator.canPop(context)) {
              print("pop");
              Navigator.pop(context);
              if (state.sendError != null) {
                showSnackBar(state.sendError ?? "");
              }
            }
          },
          child: const InitialSetupWidget(),
        ),
      );
  }
}

class InitialSetupWidget extends StatefulWidget {
  const InitialSetupWidget({super.key});

  @override
  State<InitialSetupWidget> createState() => _InitialSetupWidgetState();
}

class _InitialSetupWidgetState extends State<InitialSetupWidget> {
  final _accountFormKey = GlobalKey<FormState>();

  String? email;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InitialSetupBloc, InitialSetupData>(builder: ((context, state) {
      print(state);
      return createStepper(context, state);
    }));
  }

   Stepper createStepper(BuildContext contex, InitialSetupData state) {
    print("Creating new stepper");
    final steps = createSteps(state);
    void Function()? onStepCancelHandler;
    sendingInProgress() => state.currentStep == 4 && state.sendError == null;
    if (state.currentStep == 0 || sendingInProgress()) {
      onStepCancelHandler = null;
    } else {
      onStepCancelHandler = () {
        context.read<InitialSetupBloc>().add(GoBack(null));
      };
    }

    void Function()? onStepContinue;

    if (state.currentStep == 0) {
      onStepContinue = () {
        var valid = _accountFormKey.currentState?.validate() ?? false;
        if (valid) {
          _accountFormKey.currentState?.save();
          context.read<InitialSetupBloc>().add(SetAccountStep(email?.trim() ?? ""));
        }
      };
    } else {
      onStepContinue = null;
    }

    return Stepper(
      currentStep: state.currentStep,
      onStepCancel: onStepCancelHandler,
      onStepContinue: onStepContinue,
      onStepTapped: (i) {
        context.read<InitialSetupBloc>().add(GoBack(i));
      },
      controlsBuilder: (context, details) {
        var buttonContinue = ElevatedButton(
          onPressed: details.onStepContinue,
          child: const Text("CONTINUE"),
        );
        var buttonBack = MaterialButton(
          onPressed: details.onStepCancel,
          child: const Text("BACK"),
        );
        Widget buttons = Row(children: [buttonContinue, const Padding(padding: EdgeInsets.symmetric(horizontal: 10.0)), buttonBack]);
        return Padding(padding: const EdgeInsets.fromLTRB(10.0, 10.0, 0, 0), child: buttons);
      },
      steps: steps,
    );
  }

  List<Step> createSteps(InitialSetupData state) {
    final counter = Counter();

    //timeDilation = 10.0;
    return [
        createAccountStep(counter.next(), state),
      ];
  }

  Step createAccountStep(int id, InitialSetupData state) {
    final accountForm = Form(
      key: _accountFormKey,
      child: TextFormField(
        decoration: const InputDecoration(
          icon: Icon(Icons.email),
          hintText: "Email",
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "Is empty";
          } else {
            return null;
          }
        },
        onSaved: (newValue) => email = newValue,
      ),

    );

    return Step(
      title: const Text("Account"),
      isActive: state.currentStep == id,
      content: Container(
        alignment: Alignment.centerLeft,
        child: accountForm,
      ),
    );
  }
}

class Counter {
  int value = 0;

  Widget? onlyIfSelected(int i, Widget w) {
    if (value == i) {
      return w;
    } else {
      return null;
    }
  }

  int next() {
    var current = value;
    value += 1;
    return current;
  }
}
