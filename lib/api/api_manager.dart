
import 'dart:async';
import 'dart:io';

import 'package:openapi/api.dart';
import 'package:calculator_frontend/api/api_provider.dart';
import 'package:calculator_frontend/api/api_wrapper.dart';
import 'package:calculator_frontend/api/server_connection.dart';
import 'package:calculator_frontend/config.dart';
import 'package:calculator_frontend/logic/app/main_state.dart';
import 'package:calculator_frontend/storage/kv.dart';
import 'package:calculator_frontend/ui/utils.dart';
import 'package:calculator_frontend/utils.dart';
import 'package:rxdart/rxdart.dart';
import 'package:rxdart/subjects.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

enum ApiManagerState {
  /// Run init mehod.
  initRequired,
  /// No valid refresh token available. UI should display login view.
  waitingRefreshToken,
  /// Making connections to servers.
  connecting,
  /// Connection to servers established.
  connected,
}

sealed class ApiManagerEvent {}

enum ServerWsEvent {
  todo,
}


class ApiManager extends AppSingleton {
  ApiManager._private();
  static final _instance = ApiManager._private();
  factory ApiManager.getInstance() {
    return _instance;
  }

  final ApiProvider _account =
    ApiProvider(ConfigStringKey.accountServerAddress.defaultValue());
  final ApiProvider _calculator =
    ApiProvider(ConfigStringKey.calculatorServerAddress.defaultValue());

  final BehaviorSubject<ApiManagerState> _state =
    BehaviorSubject.seeded(ApiManagerState.initRequired);
  final PublishSubject<ApiManagerEvent> _events =
    PublishSubject();
  final PublishSubject<ServerWsEvent> _serverEvents =
    PublishSubject();

  ServerConnection accountConnection =
    ServerConnection(
      ServerSlot.account,
      "",
    );
  ServerConnection calculatorConnection =
    ServerConnection(
      ServerSlot.calculator,
      "",
    );

  Stream<ApiManagerState> get state => _state.distinct();
  Stream<ServerWsEvent> get serverEvents => _serverEvents;

  @override
  Future<void> init() async {
    if (_state.value != ApiManagerState.initRequired) {
      return;
    }
    await _account.init();
    await _calculator.init();

    _connectEvents();
    await loadAddressesFromConfig();
    await _connect();
  }

  void _connectEvents() {
    _events
      .stream
      .asyncMap((event) {
        switch (event) {
          case _: return;
        }
      })
      .listen((event) { });

      accountConnection.serverEvents.listen((event) {
        _serverEvents.add(event);
      });
      calculatorConnection.serverEvents.listen((event) {
        _serverEvents.add(event);
      });

      accountConnection.state.listen((event) {
        print(event);
        switch (event) {
          // No connection states.
          case ReadyToConnect():
            _state.add(ApiManagerState.connecting); // TODO: try again at some point
          case Error e: {
            switch (e.error) {
              case ServerConnectionError.connectionFailure: {
                showSnackBar("Connection error");
              }
              case ServerConnectionError.invalidToken: {
                _state.add(ApiManagerState.waitingRefreshToken);
              }
            }
          }
          // Ongoing connection states
          case Connecting():
            _state.add(ApiManagerState.connecting);
          case Ready(): {
            setupTokens();
            _state.add(ApiManagerState.connected);
          }
        }
      });
      // TODO: handle calculator
  }

  Future<void> loadAddressesFromConfig() async {
    final config = ConfigManager.getInstance();

    final accountAddress =
      await config.getString(ConfigStringKey.accountServerAddress);
    _account.updateServerAddress(accountAddress);
    accountConnection.setAddress(toWebSocketUri(accountAddress));

    final calculatorAddress =
      await config.getString(ConfigStringKey.calculatorServerAddress);
    _calculator.updateServerAddress(calculatorAddress);
    calculatorConnection.setAddress(toWebSocketUri(calculatorAddress));
  }

  Future<void> _connect() async {
    _state.add(ApiManagerState.connecting);

    final storage = KvStorageManager.getInstance();
    final accountRefreshToken =
      await storage.getString(KvString.accountRefreshToken);
    final accountAccessToken =
      await storage.getString(KvString.accountAccessToken);

    if (accountRefreshToken == null || accountAccessToken == null) {
      _state.add(ApiManagerState.waitingRefreshToken);
      return;
    }

    // TODO: start other connections if needed.
    await accountConnection.start();
  }

  Future<void> restart() async {
    await accountConnection.close();
    await loadAddressesFromConfig();
    await _connect();
  }

  Future<void> close() async {
    await accountConnection.close();
    _state.add(ApiManagerState.waitingRefreshToken);
  }

  Future<void> setupTokens() async {
    final storage = KvStorageManager.getInstance();

    final accountToken = await storage.getString(KvString.accountAccessToken);
    if (accountToken != null) {
      _account.setKey(ApiKey(apiKey: accountToken));
    }
  }

  ApiWrapper<AccountApi> accountWrapper() {
    return ApiWrapper(_account.account);
  }

  ApiWrapper<CalculatorApi> calculatorWrapper() {
    if (calculatorConnection.inUse()) {
      return ApiWrapper(_calculator.calculator);
    } else {
      return ApiWrapper(_account.calculator);
    }
  }

  Future<R?> account<R extends Object>(Future<R?> Function(AccountApi) action) async {
    return await accountWrapper().request(action);
  }

  Future<R?> calculator<R extends Object>(Future<R?> Function(CalculatorApi) action) async {
    return await calculatorWrapper().request(action);
  }
}

String toWebSocketUri(String baseUrl) {
  final base = Uri.parse(baseUrl);

  final newAddress = Uri(
    scheme: base.scheme,
    host: base.host,
    port: base.port,
    path: "/common_api/connect",
  ).toString();

  return newAddress;
}
