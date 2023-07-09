import 'dart:io';

import 'package:calculator_frontend/logic/calculator/calculator.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:calculator_frontend/api/api_manager.dart';
import 'package:calculator_frontend/api/error_manager.dart';
import 'package:calculator_frontend/assets.dart';
import 'package:calculator_frontend/data/account_repository.dart';
import 'package:calculator_frontend/api/api_provider.dart';
import 'package:calculator_frontend/data/calculator_repository.dart';
import 'package:calculator_frontend/logic/account/account.dart';
import 'package:calculator_frontend/logic/account/initial_setup.dart';
import 'package:calculator_frontend/logic/server/address.dart';
import 'package:calculator_frontend/logic/sign_in_with.dart';

import 'package:calculator_frontend/ui/normal.dart';
import 'package:calculator_frontend/ui/login.dart';
import 'package:calculator_frontend/logic/app/main_state.dart';
import 'package:calculator_frontend/ui/splash_screen.dart';
import 'package:calculator_frontend/utils.dart';

import 'package:rxdart/rxdart.dart';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Bloc.observer = DebugObserver();

  await GlobalInitManager.getInstance().init();

  var accountRepository = AccountRepository.getInstance();
  var calculatorRepository = CalculatorRepository.getInstance();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => MainStateBloc(accountRepository)),
        BlocProvider(create: (_) => AccountBloc(accountRepository)),
        BlocProvider(create: (_) => InitialSetupBloc(accountRepository)),
        BlocProvider(create: (_) => ServerAddressBloc(accountRepository)),
        BlocProvider(create: (_) => CalculatorBloc(accountRepository, calculatorRepository)),

        // Login
        BlocProvider(create: (_) => SignInWithBloc(accountRepository)),

      ],
      child: const MyApp(),
    )
  );
}

final globalScaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator',
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SplashScreen(),
      scaffoldMessengerKey: globalScaffoldMessengerKey,
      debugShowCheckedModeBanner: false,
    );
  }
}


class DebugObserver extends BlocObserver {
  @override
  void onChange(BlocBase bloc, Change change) {
    print("${bloc.runtimeType} $change");
  }
}


class GlobalInitManager extends AppSingleton {
  GlobalInitManager._private();
  static final _instance = GlobalInitManager._private();
  factory GlobalInitManager.getInstance() {
    return _instance;
  }

  final PublishSubject<void> startInit = PublishSubject();
  bool _globalInitDone = false;

  /// Run this in app main function.
  @override
  Future<void> init() async {
    startInit.stream
      .asyncMap((event) async => await _runInit())
      .listen((event) {});
  }

  Future<void> _runInit() async {
    if (_globalInitDone) {
      return;
    }
    _globalInitDone = true;

    await ErrorManager.getInstance().init();
    await ApiManager.getInstance().init();

    await AccountRepository.getInstance().init();
    await CalculatorRepository.getInstance().init();
  }

  /// Global init should be triggerred after when splash screen
  /// is visible.
  Future<void> triggerGlobalInit() async {
    startInit.add(null);
  }
}
