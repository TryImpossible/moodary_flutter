// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'app_l10n_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$AppL10nState {
  bool get isFollowSystem => throw _privateConstructorUsedError;
  Locale? get locale => throw _privateConstructorUsedError;
  List<Locale> get supportedLocales => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $AppL10nStateCopyWith<AppL10nState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AppL10nStateCopyWith<$Res> {
  factory $AppL10nStateCopyWith(
          AppL10nState value, $Res Function(AppL10nState) then) =
      _$AppL10nStateCopyWithImpl<$Res, AppL10nState>;
  @useResult
  $Res call(
      {bool isFollowSystem, Locale? locale, List<Locale> supportedLocales});
}

/// @nodoc
class _$AppL10nStateCopyWithImpl<$Res, $Val extends AppL10nState>
    implements $AppL10nStateCopyWith<$Res> {
  _$AppL10nStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isFollowSystem = null,
    Object? locale = freezed,
    Object? supportedLocales = null,
  }) {
    return _then(_value.copyWith(
      isFollowSystem: null == isFollowSystem
          ? _value.isFollowSystem
          : isFollowSystem // ignore: cast_nullable_to_non_nullable
              as bool,
      locale: freezed == locale
          ? _value.locale
          : locale // ignore: cast_nullable_to_non_nullable
              as Locale?,
      supportedLocales: null == supportedLocales
          ? _value.supportedLocales
          : supportedLocales // ignore: cast_nullable_to_non_nullable
              as List<Locale>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AppL10nStateImplCopyWith<$Res>
    implements $AppL10nStateCopyWith<$Res> {
  factory _$$AppL10nStateImplCopyWith(
          _$AppL10nStateImpl value, $Res Function(_$AppL10nStateImpl) then) =
      __$$AppL10nStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool isFollowSystem, Locale? locale, List<Locale> supportedLocales});
}

/// @nodoc
class __$$AppL10nStateImplCopyWithImpl<$Res>
    extends _$AppL10nStateCopyWithImpl<$Res, _$AppL10nStateImpl>
    implements _$$AppL10nStateImplCopyWith<$Res> {
  __$$AppL10nStateImplCopyWithImpl(
      _$AppL10nStateImpl _value, $Res Function(_$AppL10nStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isFollowSystem = null,
    Object? locale = freezed,
    Object? supportedLocales = null,
  }) {
    return _then(_$AppL10nStateImpl(
      isFollowSystem: null == isFollowSystem
          ? _value.isFollowSystem
          : isFollowSystem // ignore: cast_nullable_to_non_nullable
              as bool,
      locale: freezed == locale
          ? _value.locale
          : locale // ignore: cast_nullable_to_non_nullable
              as Locale?,
      supportedLocales: null == supportedLocales
          ? _value._supportedLocales
          : supportedLocales // ignore: cast_nullable_to_non_nullable
              as List<Locale>,
    ));
  }
}

/// @nodoc

class _$AppL10nStateImpl implements _AppL10nState {
  const _$AppL10nStateImpl(
      {required this.isFollowSystem,
      required this.locale,
      required final List<Locale> supportedLocales})
      : _supportedLocales = supportedLocales;

  @override
  final bool isFollowSystem;
  @override
  final Locale? locale;
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
    return 'AppL10nState(isFollowSystem: $isFollowSystem, locale: $locale, supportedLocales: $supportedLocales)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AppL10nStateImpl &&
            (identical(other.isFollowSystem, isFollowSystem) ||
                other.isFollowSystem == isFollowSystem) &&
            (identical(other.locale, locale) || other.locale == locale) &&
            const DeepCollectionEquality()
                .equals(other._supportedLocales, _supportedLocales));
  }

  @override
  int get hashCode => Object.hash(runtimeType, isFollowSystem, locale,
      const DeepCollectionEquality().hash(_supportedLocales));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AppL10nStateImplCopyWith<_$AppL10nStateImpl> get copyWith =>
      __$$AppL10nStateImplCopyWithImpl<_$AppL10nStateImpl>(this, _$identity);
}

abstract class _AppL10nState implements AppL10nState {
  const factory _AppL10nState(
      {required final bool isFollowSystem,
      required final Locale? locale,
      required final List<Locale> supportedLocales}) = _$AppL10nStateImpl;

  @override
  bool get isFollowSystem;
  @override
  Locale? get locale;
  @override
  List<Locale> get supportedLocales;
  @override
  @JsonKey(ignore: true)
  _$$AppL10nStateImplCopyWith<_$AppL10nStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
