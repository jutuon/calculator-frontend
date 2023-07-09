# openapi.api.AccountApi

## Load the API package
```dart
import 'package:openapi/api.dart';
```

All URIs are relative to *http://localhost*

Method | HTTP request | Description
------------- | ------------- | -------------
[**getAccountState**](AccountApi.md#getaccountstate) | **GET** /account_api/state | Get current account state.
[**postAccountSetup**](AccountApi.md#postaccountsetup) | **POST** /account_api/setup | Setup non-changeable user information during `initial setup` state.
[**postCompleteSetup**](AccountApi.md#postcompletesetup) | **POST** /account_api/complete_setup | Complete initial setup.
[**postDelete**](AccountApi.md#postdelete) | **PUT** /account_api/delete | Delete account.
[**postLogin**](AccountApi.md#postlogin) | **POST** /account_api/login | Get new ApiKey.
[**postRegister**](AccountApi.md#postregister) | **POST** /account_api/register | Register new account. Returns new account ID which is UUID.
[**postSignInWithLogin**](AccountApi.md#postsigninwithlogin) | **POST** /account_api/sign_in_with_login | Start new session with sign in with Apple or Google. Creates new account if


# **getAccountState**
> Account getAccountState()

Get current account state.

Get current account state.

### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure API key authorization: api_key
//defaultApiClient.getAuthentication<ApiKeyAuth>('api_key').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('api_key').apiKeyPrefix = 'Bearer';

final api_instance = AccountApi();

try {
    final result = api_instance.getAccountState();
    print(result);
} catch (e) {
    print('Exception when calling AccountApi->getAccountState: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**Account**](Account.md)

### Authorization

[api_key](../README.md#api_key)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **postAccountSetup**
> postAccountSetup(accountSetup)

Setup non-changeable user information during `initial setup` state.

Setup non-changeable user information during `initial setup` state.

### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure API key authorization: api_key
//defaultApiClient.getAuthentication<ApiKeyAuth>('api_key').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('api_key').apiKeyPrefix = 'Bearer';

final api_instance = AccountApi();
final accountSetup = AccountSetup(); // AccountSetup | 

try {
    api_instance.postAccountSetup(accountSetup);
} catch (e) {
    print('Exception when calling AccountApi->postAccountSetup: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **accountSetup** | [**AccountSetup**](AccountSetup.md)|  | 

### Return type

void (empty response body)

### Authorization

[api_key](../README.md#api_key)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **postCompleteSetup**
> postCompleteSetup()

Complete initial setup.

Complete initial setup.  Request to this handler will complete if client is in `initial setup`, setup information is set. 

### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure API key authorization: api_key
//defaultApiClient.getAuthentication<ApiKeyAuth>('api_key').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('api_key').apiKeyPrefix = 'Bearer';

final api_instance = AccountApi();

try {
    api_instance.postCompleteSetup();
} catch (e) {
    print('Exception when calling AccountApi->postCompleteSetup: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

void (empty response body)

### Authorization

[api_key](../README.md#api_key)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **postDelete**
> postDelete()

Delete account.

Delete account.

### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure API key authorization: api_key
//defaultApiClient.getAuthentication<ApiKeyAuth>('api_key').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('api_key').apiKeyPrefix = 'Bearer';

final api_instance = AccountApi();

try {
    api_instance.postDelete();
} catch (e) {
    print('Exception when calling AccountApi->postDelete: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

void (empty response body)

### Authorization

[api_key](../README.md#api_key)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **postLogin**
> LoginResult postLogin(accountIdLight)

Get new ApiKey.

Get new ApiKey.

### Example
```dart
import 'package:openapi/api.dart';

final api_instance = AccountApi();
final accountIdLight = AccountIdLight(); // AccountIdLight | 

try {
    final result = api_instance.postLogin(accountIdLight);
    print(result);
} catch (e) {
    print('Exception when calling AccountApi->postLogin: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **accountIdLight** | [**AccountIdLight**](AccountIdLight.md)|  | 

### Return type

[**LoginResult**](LoginResult.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **postRegister**
> AccountIdLight postRegister()

Register new account. Returns new account ID which is UUID.

Register new account. Returns new account ID which is UUID.

### Example
```dart
import 'package:openapi/api.dart';

final api_instance = AccountApi();

try {
    final result = api_instance.postRegister();
    print(result);
} catch (e) {
    print('Exception when calling AccountApi->postRegister: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**AccountIdLight**](AccountIdLight.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **postSignInWithLogin**
> LoginResult postSignInWithLogin(signInWithLoginInfo)

Start new session with sign in with Apple or Google. Creates new account if

Start new session with sign in with Apple or Google. Creates new account if it does not exists.

### Example
```dart
import 'package:openapi/api.dart';

final api_instance = AccountApi();
final signInWithLoginInfo = SignInWithLoginInfo(); // SignInWithLoginInfo | 

try {
    final result = api_instance.postSignInWithLogin(signInWithLoginInfo);
    print(result);
} catch (e) {
    print('Exception when calling AccountApi->postSignInWithLogin: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **signInWithLoginInfo** | [**SignInWithLoginInfo**](SignInWithLoginInfo.md)|  | 

### Return type

[**LoginResult**](LoginResult.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

