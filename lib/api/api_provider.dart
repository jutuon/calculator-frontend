
import 'dart:io';

import 'package:http/http.dart';
import 'package:http/io_client.dart';
import 'package:openapi/api.dart';
import 'package:calculator_frontend/assets.dart';

const accessTokenHeaderName = "x-api-key";

class ApiProvider {
  ApiKeyAuth? _apiKey;
  AccountApi _account;
  CalculatorApi _calculator;

  String _serverAddress;

  late final Client httpClient;

  AccountApi get account => _account;
  CalculatorApi get calculator => _calculator;
  String get serverAddress => _serverAddress;

  ApiProvider(String address) :
    this._withClient(ApiClient(basePath: address), address);

  ApiProvider._withClient(ApiClient client, String serverAddress) :
    _serverAddress = serverAddress,
    _account = AccountApi(client),
    _calculator = CalculatorApi(client);

  void setKey(ApiKey apiKey) {
    var auth = ApiKeyAuth("header", accessTokenHeaderName);
    auth.apiKey = apiKey.apiKey;
    _apiKey = auth;
    var client = ApiClient(basePath: serverAddress, authentication: auth);
    client.client = httpClient;
    _account = AccountApi(client);
    _calculator = CalculatorApi(client);
  }

  void updateServerAddress(String serverAddress) {
    _serverAddress = serverAddress;
    var client = ApiClient(basePath: serverAddress, authentication: _apiKey);
    client.client = httpClient;
    _account = AccountApi(client);
    _calculator = CalculatorApi(client);
  }

  Future<void> init() async {
    final client = IOClient(HttpClient(context: await createSecurityContextForBackendConnection()));
    httpClient = client;
    _account.apiClient.client = client;
    _calculator.apiClient.client = client;
  }
}
