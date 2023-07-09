//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;


class CalculatorApi {
  CalculatorApi([ApiClient? apiClient]) : apiClient = apiClient ?? defaultApiClient;

  final ApiClient apiClient;

  /// Get account's current calculator state.
  ///
  /// Get account's current calculator state. 
  ///
  /// Note: This method returns the HTTP [Response].
  Future<Response> getCalculatorStateWithHttpInfo() async {
    // ignore: prefer_const_declarations
    final path = r'/calculator_api/state';

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>[];


    return apiClient.invokeAPI(
      path,
      'GET',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// Get account's current calculator state.
  ///
  /// Get account's current calculator state. 
  Future<CalculatorState?> getCalculatorState() async {
    final response = await getCalculatorStateWithHttpInfo();
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'CalculatorState',) as CalculatorState;
    
    }
    return null;
  }

  /// Update calculator state.
  ///
  /// Update calculator state.
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [CalculatorState] calculatorState (required):
  Future<Response> postCalculatorStateWithHttpInfo(CalculatorState calculatorState,) async {
    // ignore: prefer_const_declarations
    final path = r'/calculator_api/state';

    // ignore: prefer_final_locals
    Object? postBody = calculatorState;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>['application/json'];


    return apiClient.invokeAPI(
      path,
      'POST',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// Update calculator state.
  ///
  /// Update calculator state.
  ///
  /// Parameters:
  ///
  /// * [CalculatorState] calculatorState (required):
  Future<void> postCalculatorState(CalculatorState calculatorState,) async {
    final response = await postCalculatorStateWithHttpInfo(calculatorState,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }
}
