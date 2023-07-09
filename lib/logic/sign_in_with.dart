import "dart:io";

import "package:flutter/services.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:google_sign_in/google_sign_in.dart";
import "package:openapi/api.dart";
import "package:calculator_frontend/data/account_repository.dart";
import "package:calculator_frontend/secrets.dart";
import "package:calculator_frontend/ui/initial_setup.dart";
import "package:calculator_frontend/utils.dart";
import "package:rxdart/rxdart.dart";


import "package:freezed_annotation/freezed_annotation.dart";
import 'package:flutter/foundation.dart';


sealed class SignInWithEvent {}
class SignInWithGoogle extends SignInWithEvent {
  SignInWithGoogle();
}
class LogOutFromGoogle extends SignInWithEvent {
  LogOutFromGoogle();
}

class SignInWithBloc extends Bloc<SignInWithEvent, String> with ActionRunner {
  final AccountRepository account;

  GoogleSignIn google = createSignInWithGoogle();

  SignInWithBloc(this.account) : super("") {

    on<SignInWithGoogle>((data, emit) async {
      await runOnce(() async => await account.signInWithGoogle(google));
    });
    on<LogOutFromGoogle>((data, emit) async {
      await runOnce(() async => await account.signOutFromGoogle(google));
    });
  }
}

GoogleSignIn createSignInWithGoogle() {
  if (Platform.isAndroid) {
    return GoogleSignIn(
      serverClientId: signInWithGoogleBackendClientId(),
      scopes: ["email"],
    );
  } else if (Platform.isIOS) {
    return GoogleSignIn(
      clientId: signInWithGoogleIosClientId(),
      serverClientId: signInWithGoogleBackendClientId(),
      scopes: ["email"],
    );
  } else {
    throw UnsupportedError("Unsupported platform");
  }
}
