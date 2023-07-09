# calculator-frontend
Pocket calculator app frontend with server side calculation result storage.

## Update server API bindings

1. Install node version manager (nvm) <https://github.com/nvm-sh/nvm>
2. Install latest node LTS with nvm. For example `nvm install 18`
3. Install openapi-generator from npm. `npm install @openapitools/openapi-generator-cli -g`
4. Start backend in debug mode.
5. Generate bindings
```
openapi-generator-cli generate -i http://localhost:3000/api-doc/calculator_api.json -g dart -o api_client
```

## Update generated code (freezed library)

```
dart run build_runner build
```

# Update localizations

flutter gen-l10n

### After git clone

1. Create lib/secrets.dart

```dart
String signInWithGoogleBackendClientId() {
    return "HELLO";
}

String signInWithGoogleIosClientId() {
    return "HELLO";
}
```

2. Add server certificate to

assets_not_in_git/server_root.crt

3. flutter gen-l10n
