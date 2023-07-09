import 'package:flutter/material.dart';

import "package:flutter_bloc/flutter_bloc.dart";
import "package:calculator_frontend/logic/account/account.dart";
import "package:calculator_frontend/logic/app/main_state.dart";
import "package:calculator_frontend/ui/login.dart";
import 'package:calculator_frontend/ui/normal.dart';
import 'package:calculator_frontend/ui/normal/calculator.dart';
import "package:calculator_frontend/ui/normal/settings.dart";
import "package:calculator_frontend/ui/utils/root_page.dart";

class NormalStatePage extends RootPage {
  const NormalStatePage({Key? key}) : super(MainState.initialSetupComplete, key: key);

  @override
  Widget buildRootWidget(BuildContext context) {
    return const NormalStateContent();
  }
}

class NormalStateContent extends StatefulWidget {
  const NormalStateContent({Key? key}) : super(key: key);

  @override
  State<NormalStateContent> createState() => _NormalStateContentState();
}

class _NormalStateContentState extends State<NormalStateContent> {
  int selectedView = 0;

  @override
  Widget build(BuildContext context) {
    var widgets = const [
      CalculatorView(),
      SettingsView(),
    ];
    var titles = const [
      "Calculator",
      "Settings"
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(titles[selectedView]),
      ),
      body: widgets[selectedView],
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.calculate), label: "Calculator"),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: "Settings"),
        ],
        selectedItemColor: Colors.lightBlue[900],
        unselectedItemColor: Colors.black54,
        currentIndex: selectedView,
        onTap: (value) {
          setState(() {
            selectedView = value;
          });
        },
      ),
    );
  }
}
