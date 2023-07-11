import "package:flutter_bloc/flutter_bloc.dart";
import "package:calculator_frontend/data/account_repository.dart";
import "package:calculator_frontend/ui/initial_setup.dart";

/// States for top level UI main states
enum MainState {
  splashScreen, loginRequired, initialSetup, initialSetupComplete
}

abstract class MainStateEvent {}

class ToSplashScreen extends MainStateEvent {}
class ToLoginRequiredScreen extends MainStateEvent {}
class ToInitialSetup extends MainStateEvent {}
class ToMainScreen extends MainStateEvent {}

/// Get current main state of the account/app
class MainStateBloc extends Bloc<MainStateEvent, MainState> {
  final AccountRepository account;

  MainStateBloc(this.account) : super(MainState.splashScreen) {
    on<ToSplashScreen>((_, emit) => emit(MainState.splashScreen));
    on<ToLoginRequiredScreen>((_, emit) => emit(MainState.loginRequired));
    on<ToInitialSetup>((_, emit) => emit(MainState.initialSetup));
    on<ToMainScreen>((_, emit) => emit(MainState.initialSetupComplete));

    account.mainState.listen((event) {
      if (event == MainState.loginRequired) {
          add(ToLoginRequiredScreen());
        } else if (event == MainState.initialSetup) {
          add(ToInitialSetup());
        } else if (event == MainState.initialSetupComplete) {
          add(ToMainScreen());
        } else if (event == MainState.splashScreen) {
          add(ToSplashScreen());
        }
    });
  }
}
