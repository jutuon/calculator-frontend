// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'account.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$AccountData {
  AccountIdLight? get accountId => throw _privateConstructorUsedError;
  ApiKey? get apiKey => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $AccountDataCopyWith<AccountData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AccountDataCopyWith<$Res> {
  factory $AccountDataCopyWith(
          AccountData value, $Res Function(AccountData) then) =
      _$AccountDataCopyWithImpl<$Res, AccountData>;
  @useResult
  $Res call({AccountIdLight? accountId, ApiKey? apiKey});
}

/// @nodoc
class _$AccountDataCopyWithImpl<$Res, $Val extends AccountData>
    implements $AccountDataCopyWith<$Res> {
  _$AccountDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? accountId = freezed,
    Object? apiKey = freezed,
  }) {
    return _then(_value.copyWith(
      accountId: freezed == accountId
          ? _value.accountId
          : accountId // ignore: cast_nullable_to_non_nullable
              as AccountIdLight?,
      apiKey: freezed == apiKey
          ? _value.apiKey
          : apiKey // ignore: cast_nullable_to_non_nullable
              as ApiKey?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_AccountDataCopyWith<$Res>
    implements $AccountDataCopyWith<$Res> {
  factory _$$_AccountDataCopyWith(
          _$_AccountData value, $Res Function(_$_AccountData) then) =
      __$$_AccountDataCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({AccountIdLight? accountId, ApiKey? apiKey});
}

/// @nodoc
class __$$_AccountDataCopyWithImpl<$Res>
    extends _$AccountDataCopyWithImpl<$Res, _$_AccountData>
    implements _$$_AccountDataCopyWith<$Res> {
  __$$_AccountDataCopyWithImpl(
      _$_AccountData _value, $Res Function(_$_AccountData) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? accountId = freezed,
    Object? apiKey = freezed,
  }) {
    return _then(_$_AccountData(
      accountId: freezed == accountId
          ? _value.accountId
          : accountId // ignore: cast_nullable_to_non_nullable
              as AccountIdLight?,
      apiKey: freezed == apiKey
          ? _value.apiKey
          : apiKey // ignore: cast_nullable_to_non_nullable
              as ApiKey?,
    ));
  }
}

/// @nodoc

class _$_AccountData with DiagnosticableTreeMixin implements _AccountData {
  _$_AccountData({this.accountId, this.apiKey});

  @override
  final AccountIdLight? accountId;
  @override
  final ApiKey? apiKey;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'AccountData(accountId: $accountId, apiKey: $apiKey)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'AccountData'))
      ..add(DiagnosticsProperty('accountId', accountId))
      ..add(DiagnosticsProperty('apiKey', apiKey));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_AccountData &&
            (identical(other.accountId, accountId) ||
                other.accountId == accountId) &&
            (identical(other.apiKey, apiKey) || other.apiKey == apiKey));
  }

  @override
  int get hashCode => Object.hash(runtimeType, accountId, apiKey);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_AccountDataCopyWith<_$_AccountData> get copyWith =>
      __$$_AccountDataCopyWithImpl<_$_AccountData>(this, _$identity);
}

abstract class _AccountData implements AccountData {
  factory _AccountData(
      {final AccountIdLight? accountId, final ApiKey? apiKey}) = _$_AccountData;

  @override
  AccountIdLight? get accountId;
  @override
  ApiKey? get apiKey;
  @override
  @JsonKey(ignore: true)
  _$$_AccountDataCopyWith<_$_AccountData> get copyWith =>
      throw _privateConstructorUsedError;
}
