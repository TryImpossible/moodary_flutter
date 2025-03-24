// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'l10n_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$L10nState {
  Locale get locale => throw _privateConstructorUsedError;
  List<Locale> get supportedLocales => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $L10nStateCopyWith<L10nState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $L10nStateCopyWith<$Res> {
  factory $L10nStateCopyWith(L10nState value, $Res Function(L10nState) then) =
      _$L10nStateCopyWithImpl<$Res, L10nState>;
  @useResult
  $Res call({Locale locale, List<Locale> supportedLocales});
}

/// @nodoc
class _$L10nStateCopyWithImpl<$Res, $Val extends L10nState>
    implements $L10nStateCopyWith<$Res> {
  _$L10nStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? locale = null,
    Object? supportedLocales = null,
  }) {
    return _then(_value.copyWith(
      locale: null == locale
          ? _value.locale
          : locale // ignore: cast_nullable_to_non_nullable
              as Locale,
      supportedLocales: null == supportedLocales
          ? _value.supportedLocales
          : supportedLocales // ignore: cast_nullable_to_non_nullable
              as List<Locale>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$L10nStateImplCopyWith<$Res>
    implements $L10nStateCopyWith<$Res> {
  factory _$$L10nStateImplCopyWith(
          _$L10nStateImpl value, $Res Function(_$L10nStateImpl) then) =
      __$$L10nStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Locale locale, List<Locale> supportedLocales});
}

/// @nodoc
class __$$L10nStateImplCopyWithImpl<$Res>
    extends _$L10nStateCopyWithImpl<$Res, _$L10nStateImpl>
    implements _$$L10nStateImplCopyWith<$Res> {
  __$$L10nStateImplCopyWithImpl(
      _$L10nStateImpl _value, $Res Function(_$L10nStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? locale = null,
    Object? supportedLocales = null,
  }) {
    return _then(_$L10nStateImpl(
      locale: null == locale
          ? _value.locale
          : locale // ignore: cast_nullable_to_non_nullable
              as Locale,
      supportedLocales: null == supportedLocales
          ? _value._supportedLocales
          : supportedLocales // ignore: cast_nullable_to_non_nullable
              as List<Locale>,
    ));
  }
}

/// @nodoc

class _$L10nStateImpl implements _L10nState {
  const _$L10nStateImpl(
      {required this.locale, required final List<Locale> supportedLocales})
      : _supportedLocales = supportedLocales;

  @override
  final Locale locale;
  final List<Locale> _supportedLocales;
  @override
  List<Locale> get supportedLocales {
    if (_supportedLocales is EqualUnmodifiableListView)
      return _supportedLocales;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_supportedLocales);
  }

  @override
  String toString() {
    return 'L10nState(locale: $locale, supportedLocales: $supportedLocales)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$L10nStateImpl &&
            (identical(other.locale, locale) || other.locale == locale) &&
            const DeepCollectionEquality()
                .equals(other._supportedLocales, _supportedLocales));
  }

  @override
  int get hashCode => Object.hash(runtimeType, locale,
      const DeepCollectionEquality().hash(_supportedLocales));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$L10nStateImplCopyWith<_$L10nStateImpl> get copyWith =>
      __$$L10nStateImplCopyWithImpl<_$L10nStateImpl>(this, _$identity);
}

abstract class _L10nState implements L10nState {
  const factory _L10nState(
      {required final Locale locale,
      required final List<Locale> supportedLocales}) = _$L10nStateImpl;

  @override
  Locale get locale;
  @override
  List<Locale> get supportedLocales;
  @override
  @JsonKey(ignore: true)
  _$$L10nStateImplCopyWith<_$L10nStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
