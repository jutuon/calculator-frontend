import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:calculator_frontend/logic/app/main_state.dart";
import "package:calculator_frontend/ui/initial_setup.dart";
import "package:calculator_frontend/ui/login.dart";
import 'package:calculator_frontend/ui/normal.dart';

abstract class RootPage extends StatelessWidget {
  const RootPage(this.rootPageIdentifier, {Key? key}) : super(key: key);

  final MainState rootPageIdentifier;

  Widget buildRootWidget(BuildContext context);

  @override
  Widget build(BuildContext context) {
    return BlocListener<MainStateBloc, MainState>(
      listener: (context, state) {
        if (state == rootPageIdentifier) {
          return;
        }

        if (state == MainState.loginRequired) {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute<void>(builder: (_) => LoginPage()),
              (_) => false,
          );
        } else if (state == MainState.initialSetup) {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute<void>(builder: (_) => const InitialSetupPage()),
              (_) => false,
          );
        } else if (state == MainState.initialSetupComplete) {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute<void>(builder: (_) => const NormalStatePage()),
              (_) => false,
          );
        }

      },
      child: buildRootWidget(context)
    );
  }
}
