


import 'package:openapi/api.dart';
import 'package:calculator_frontend/api/error_manager.dart';

class ApiWrapper<T> {
  final T api;

  ApiWrapper(this.api);

  /// Handle ApiException.
  Future<R?> request<R extends Object>(Future<R?> Function(T) action) async {
    try {
      return await action(api);
    } on ApiException catch (e) {
      print(e);
      print(e.message);
      ErrorManager.getInstance().send(Error.api);
    }

    return null;
  }

  /// Rethrow ApiException.
  Future<R?> requestWithException<R extends Object>(Future<R?> Function(T) action) async {
    try {
      return await action(api);
    } on ApiException catch (e) {
      print(e);
      print(e.message);
      ErrorManager.getInstance().send(Error.api);
      rethrow;
    }
  }
}
