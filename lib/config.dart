

import 'dart:io';

import 'package:shared_preferences/shared_preferences.dart';

const String _defaultAccountServerAddressAndroid = "https://10.0.2.2:3000";

String defaultAccountServerAddress() {
  if (Platform.isAndroid) {
    return _defaultAccountServerAddressAndroid;
  } else {
    throw UnimplementedError();
  }
}

const String _defaultCalculatorServerAddress = "https://10.0.2.2:3000";

String defaultCalculatorServerAddress() {
  return _defaultCalculatorServerAddress;
}


enum ConfigStringKey {
  accountServerAddress,
  calculatorServerAddress;

  String key() {
    return "string-key-$name";
  }

  String defaultValue() {
    switch (this) {
      case accountServerAddress: return defaultAccountServerAddress();
      case calculatorServerAddress: return defaultCalculatorServerAddress();
    }
  }
}

class ConfigManager {
  static final _instance = ConfigManager._private();

  ConfigManager._private();

  factory ConfigManager.getInstance() {
    return _instance;
  }

  /// Get current or default value.
  Future<String> getString(ConfigStringKey key) async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(key.key()) ?? key.defaultValue();
  }

  Future<void> setString(ConfigStringKey key, String value) async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString(key.key(), value);
  }
}
