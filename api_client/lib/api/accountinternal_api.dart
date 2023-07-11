//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;


class AccountinternalApi {
  AccountinternalApi([ApiClient? apiClient]) : apiClient = apiClient ?? defaultApiClient;

  final ApiClient apiClient;

  /// Performs an HTTP 'GET /internal/check_api_key' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [ApiKey] apiKey (required):
  Future<Response> checkApiKeyWithHttpInfo(ApiKey apiKey,) async {
    // ignore: prefer_const_declarations
    final path = r'/internal/check_api_key';

    // ignore: prefer_final_locals
    Object? postBody = apiKey;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>['application/json'];


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

  /// Parameters:
  ///
  /// * [ApiKey] apiKey (required):
  Future<AccountIdLight?> checkApiKey(ApiKey apiKey,) async {
    final response = await checkApiKeyWithHttpInfo(apiKey,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'AccountIdLight',) as AccountIdLight;
    
    }
    return null;
  }

  /// Performs an HTTP 'GET /internal/get_account_state/{account_id}' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [String] accountId (required):
  Future<Response> internalGetAccountStateWithHttpInfo(String accountId,) async {
    // ignore: prefer_const_declarations
    final path = r'/internal/get_account_state/{account_id}'
      .replaceAll('{account_id}', accountId);

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

  /// Parameters:
  ///
  /// * [String] accountId (required):
  Future<Account?> internalGetAccountState(String accountId,) async {
    final response = await internalGetAccountStateWithHttpInfo(accountId,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'Account',) as Account;
    
    }
    return null;
  }
}
