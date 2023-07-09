// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'calculator.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$CalculatorData {
  String? get state => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $CalculatorDataCopyWith<CalculatorData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CalculatorDataCopyWith<$Res> {
  factory $CalculatorDataCopyWith(
          CalculatorData value, $Res Function(CalculatorData) then) =
      _$CalculatorDataCopyWithImpl<$Res, CalculatorData>;
  @useResult
  $Res call({String? state});
}

/// @nodoc
class _$CalculatorDataCopyWithImpl<$Res, $Val extends CalculatorData>
    implements $CalculatorDataCopyWith<$Res> {
  _$CalculatorDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? state = freezed,
  }) {
    return _then(_value.copyWith(
      state: freezed == state
          ? _value.state
          : state // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_CalculatorDataCopyWith<$Res>
    implements $CalculatorDataCopyWith<$Res> {
  factory _$$_CalculatorDataCopyWith(
          _$_CalculatorData value, $Res Function(_$_CalculatorData) then) =
      __$$_CalculatorDataCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? state});
}

/// @nodoc
class __$$_CalculatorDataCopyWithImpl<$Res>
    extends _$CalculatorDataCopyWithImpl<$Res, _$_CalculatorData>
    implements _$$_CalculatorDataCopyWith<$Res> {
  __$$_CalculatorDataCopyWithImpl(
      _$_CalculatorData _value, $Res Function(_$_CalculatorData) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? state = freezed,
  }) {
    return _then(_$_CalculatorData(
      state: freezed == state
          ? _value.state
          : state // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$_CalculatorData
    with DiagnosticableTreeMixin
    implements _CalculatorData {
  _$_CalculatorData({this.state});

  @override
  final String? state;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'CalculatorData(state: $state)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'CalculatorData'))
      ..add(DiagnosticsProperty('state', state));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_CalculatorData &&
            (identical(other.state, state) || other.state == state));
  }

  @override
  int get hashCode => Object.hash(runtimeType, state);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_CalculatorDataCopyWith<_$_CalculatorData> get copyWith =>
      __$$_CalculatorDataCopyWithImpl<_$_CalculatorData>(this, _$identity);
}

abstract class _CalculatorData implements CalculatorData {
  factory _CalculatorData({final String? state}) = _$_CalculatorData;

  @override
  String? get state;
  @override
  @JsonKey(ignore: true)
  _$$_CalculatorDataCopyWith<_$_CalculatorData> get copyWith =>
      throw _privateConstructorUsedError;
}
