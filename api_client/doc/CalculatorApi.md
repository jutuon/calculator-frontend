# openapi.api.CalculatorApi

## Load the API package
```dart
import 'package:openapi/api.dart';
```

All URIs are relative to *http://localhost*

Method | HTTP request | Description
------------- | ------------- | -------------
[**getCalculatorState**](CalculatorApi.md#getcalculatorstate) | **GET** /calculator_api/state | Get account's current calculator state.
[**postCalculatorState**](CalculatorApi.md#postcalculatorstate) | **POST** /calculator_api/state | Update calculator state.


# **getCalculatorState**
> CalculatorState getCalculatorState()

Get account's current calculator state.

Get account's current calculator state. 

### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure API key authorization: api_key
//defaultApiClient.getAuthentication<ApiKeyAuth>('api_key').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('api_key').apiKeyPrefix = 'Bearer';

final api_instance = CalculatorApi();

try {
    final result = api_instance.getCalculatorState();
    print(result);
} catch (e) {
    print('Exception when calling CalculatorApi->getCalculatorState: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**CalculatorState**](CalculatorState.md)

### Authorization

[api_key](../README.md#api_key)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **postCalculatorState**
> postCalculatorState(calculatorState)

Update calculator state.

Update calculator state.

### Example
```dart
import 'package:openapi/api.dart';
// TODO Configure API key authorization: api_key
//defaultApiClient.getAuthentication<ApiKeyAuth>('api_key').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('api_key').apiKeyPrefix = 'Bearer';

final api_instance = CalculatorApi();
final calculatorState = CalculatorState(); // CalculatorState | 

try {
    api_instance.postCalculatorState(calculatorState);
} catch (e) {
    print('Exception when calling CalculatorApi->postCalculatorState: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **calculatorState** | [**CalculatorState**](CalculatorState.md)|  | 

### Return type

void (empty response body)

### Authorization

[api_key](../README.md#api_key)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

