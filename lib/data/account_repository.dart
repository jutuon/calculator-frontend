


import 'dart:async';
import 'dart:convert';

import 'package:async/async.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart';
import 'package:openapi/api.dart';
import 'package:calculator_frontend/api/api_manager.dart';
import 'package:calculator_frontend/api/api_provider.dart';
import 'package:calculator_frontend/config.dart';
import 'package:calculator_frontend/logic/app/main_state.dart';
import 'package:calculator_frontend/storage/kv.dart';
import 'package:calculator_frontend/utils.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum AccountRepositoryState {
  initRequired,
  waitConnection,
  watchConnection
}

class AccountRepository extends AppSingleton {
  AccountRepository._private();
  static final _instance = AccountRepository._private();
  factory AccountRepository.getInstance() {
    return _instance;
  }

  final api = ApiManager.getInstance();

  final BehaviorSubject<MainState> _mainState =
    BehaviorSubject.seeded(MainState.splashScreen);
  final BehaviorSubject<AccountRepositoryState> _internalState =
    BehaviorSubject.seeded(AccountRepositoryState.initRequired);

  final PublishSubject<void> hintAccountStateUpdated = PublishSubject();

  final _accountState = KvStorageManager.getInstance()
    .getUpdatesForWithConversionAndDefaultIfNull(
      KvString.accountState,
      (value) => AccountState.fromJson(value) ?? AccountState.initialSetup,
      AccountState.initialSetup,
    );
  final _accountId = KvStorageManager.getInstance()
    .getUpdatesForWithConversion(
      KvString.accountId,
      (value) => AccountIdLight(accountId: value)
    );
  final _accountAccessToken = KvStorageManager.getInstance()
    .getUpdatesForWithConversion(
      KvString.accountAccessToken,
      (value) => ApiKey(apiKey: value)
    );

  Stream<MainState> get mainState => _mainState.distinct();

  Stream<AccountState> get accountState => _accountState.distinct();
  Stream<AccountIdLight?> get accountId => _accountId.distinct();
  Stream<ApiKey?> get accountAccessToken => _accountAccessToken.distinct();

  Future<void>? connectionWathcerTask;

  AccountRepository();

  @override
  Future<void> init() async {
    if (_internalState.value != AccountRepositoryState.initRequired) {
      return;
    }
    _internalState.add(AccountRepositoryState.waitConnection);

    _internalState
      .distinct()
      .asyncMap((state) async => await _handleInternalState(state))
      .listen((event) { });

    api.state.listen((event) {
      print(event);
      switch (event) {
        case ApiManagerState.initRequired: {}
        case ApiManagerState.waitingRefreshToken: {
          _mainState.add(MainState.loginRequired);
          _internalState.add(AccountRepositoryState.waitConnection);
        }
        case ApiManagerState.connecting: {
          _internalState.add(AccountRepositoryState.waitConnection);
        }
        case ApiManagerState.connected: {
          _internalState.add(AccountRepositoryState.watchConnection);
        }
      }
    });
  }

  Future<void> _handleInternalState(AccountRepositoryState state) async {
    print(state);
    switch (state) {
      case AccountRepositoryState.initRequired: {}
      case AccountRepositoryState.waitConnection: {
        if (connectionWathcerTask != null) {
          await connectionWathcerTask;
        }
      }
      case AccountRepositoryState.watchConnection: {
        if (connectionWathcerTask != null) {
          await connectionWathcerTask;
        }
        connectionWathcerTask = _accountStateUpdating().then((value) => {});
      }
    }
  }

  Future<void> _accountStateUpdating() async {
    print("Waiting AccountId");
    await for (final value in accountId) {
      if (value == null) {
        _mainState.add(MainState.loginRequired);
      } else {
        break;
      }
    }
    print("AccountId received.");

    print("Waiting accountAccessToken");
    await for (final value in accountAccessToken) {
      if (value == null) {
        _mainState.add(MainState.loginRequired);
      } else {
        break;
      }
    }
    print("accountAccessToken received.");

    var previousState = await accountState.first;
    var state = previousState;

    emitStateUpdates(state);

    while (_internalState.value == AccountRepositoryState.watchConnection) {
      Account? data = await api.account((api) => api.getAccountState());

      if (data == null) {
        print("error: data == null");
      } else {
        print(data.state);
        state = data.state;

        if (previousState != state) {
          await KvStorageManager.getInstance().setString(KvString.accountState, state.toString());
        }
        emitStateUpdates(state);
      }

      await Future.any([
        Future.delayed(const Duration(seconds: 5), () {}),
        hintAccountStateUpdated.stream.first
      ]);
    }
  }

  void emitStateUpdates(AccountState state) {
      if (state == AccountState.initialSetup) {
        _mainState.add(MainState.initialSetup);
      } else if (state == AccountState.normal) {
        _mainState.add(MainState.initialSetupComplete);
      }
  }

  Future<AccountIdLight?> register() async {
    var id = await api.account((api) => api.postRegister());
    if (id != null) {
      await KvStorageManager.getInstance().setString(KvString.accountId, id.accountId);
    }
    return id;
  }

  Future<ApiKey?> login() async {
    final accountIdValue = await accountId.first;
    if (accountIdValue == null) {
      return null;
    }
    final loginResult = await api.account((api) => api.postLogin(accountIdValue));
    if (loginResult != null) {
      await handleLoginResult(loginResult);
    }
    await api.restart();
    return loginResult?.account.access;
  }

  Future<void> handleLoginResult(LoginResult loginResult) async {
    await KvStorageManager.getInstance().setString(KvString.accountRefreshToken, loginResult.account.refresh.token);
    await KvStorageManager.getInstance().setString(KvString.accountAccessToken, loginResult.account.access.apiKey);
    // TODO: microservice support
  }

  Future<void> logout() async {
    await KvStorageManager.getInstance().setString(KvString.accountRefreshToken, null);
    await KvStorageManager.getInstance().setString(KvString.accountAccessToken, null);
    // TODO: microservice support

    await api.close();
  }

  /// Return null on success. Return String if error.
  Future<String?> doInitialSetup(String email) async {

    await api.account((api) => api.postAccountSetup(AccountSetup(email: email)));
    await api.account((api) => api.postCompleteSetup());
    hintAccountStateUpdated.add(null);

    final state = await api.account((api) => api.getAccountState());
    if (state == null || state.state != AccountState.normal) {
      return "Error";
    }

    return null;
  }

  Future<String> getCurrentServerAddress() async {
    return await ConfigManager.getInstance().getString(
      ConfigStringKey.accountServerAddress
    );
  }

  Future<void> setCurrentServerAddress(String serverAddress) async {
    await ConfigManager.getInstance().setString(
      ConfigStringKey.accountServerAddress, serverAddress
    );
    await ApiManager.getInstance().restart();
  }

  Future<void> signInWithGoogle(GoogleSignIn google) async {
     final signedIn = await google.signIn();
      if (signedIn != null) {
        print(signedIn.toString());
        print(signedIn.email.toString());

        var token = await signedIn.authentication;
        print(token.accessToken);
        print(token.idToken);

        final login = await api.account((api) => api.postSignInWithLogin(SignInWithLoginInfo(googleToken: token.idToken)));
        if (login != null) {
          await handleLoginResult(login);
        }
        await api.restart();
      }
  }

  Future<void> signOutFromGoogle(GoogleSignIn google) async {
    final signedIn = await google.disconnect();
    print(signedIn);
    if (signedIn != null) {
      print(signedIn.toString());
      print(signedIn.email.toString());
    }
  }
}
