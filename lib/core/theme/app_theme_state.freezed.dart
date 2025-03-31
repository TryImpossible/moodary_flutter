// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'app_theme_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$AppThemeState {
  bool get isFollowSystem => throw _privateConstructorUsedError;
  ThemeStyle get style => throw _privateConstructorUsedError;
  List<ThemeStyle> get supportedStyles => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $AppThemeStateCopyWith<AppThemeState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AppThemeStateCopyWith<$Res> {
  factory $AppThemeStateCopyWith(
          AppThemeState value, $Res Function(AppThemeState) then) =
      _$AppThemeStateCopyWithImpl<$Res, AppThemeState>;
  @useResult
  $Res call(
      {bool isFollowSystem,
      ThemeStyle style,
      List<ThemeStyle> supportedStyles});
}

/// @nodoc
class _$AppThemeStateCopyWithImpl<$Res, $Val extends AppThemeState>
    implements $AppThemeStateCopyWith<$Res> {
  _$AppThemeStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isFollowSystem = null,
    Object? style = null,
    Object? supportedStyles = null,
  }) {
    return _then(_value.copyWith(
      isFollowSystem: null == isFollowSystem
          ? _value.isFollowSystem
          : isFollowSystem // ignore: cast_nullable_to_non_nullable
              as bool,
      style: null == style
          ? _value.style
          : style // ignore: cast_nullable_to_non_nullable
              as ThemeStyle,
      supportedStyles: null == supportedStyles
          ? _value.supportedStyles
          : supportedStyles // ignore: cast_nullable_to_non_nullable
              as List<ThemeStyle>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AppThemeStateImplCopyWith<$Res>
    implements $AppThemeStateCopyWith<$Res> {
  factory _$$AppThemeStateImplCopyWith(
          _$AppThemeStateImpl value, $Res Function(_$AppThemeStateImpl) then) =
      __$$AppThemeStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool isFollowSystem,
      ThemeStyle style,
      List<ThemeStyle> supportedStyles});
}

/// @nodoc
class __$$AppThemeStateImplCopyWithImpl<$Res>
    extends _$AppThemeStateCopyWithImpl<$Res, _$AppThemeStateImpl>
    implements _$$AppThemeStateImplCopyWith<$Res> {
  __$$AppThemeStateImplCopyWithImpl(
      _$AppThemeStateImpl _value, $Res Function(_$AppThemeStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isFollowSystem = null,
    Object? style = null,
    Object? supportedStyles = null,
  }) {
    return _then(_$AppThemeStateImpl(
      isFollowSystem: null == isFollowSystem
          ? _value.isFollowSystem
          : isFollowSystem // ignore: cast_nullable_to_non_nullable
              as bool,
      style: null == style
          ? _value.style
          : style // ignore: cast_nullable_to_non_nullable
              as ThemeStyle,
      supportedStyles: null == supportedStyles
          ? _value._supportedStyles
          : supportedStyles // ignore: cast_nullable_to_non_nullable
              as List<ThemeStyle>,
    ));
  }
}

/// @nodoc

class _$AppThemeStateImpl extends _AppThemeState {
  const _$AppThemeStateImpl(
      {required this.isFollowSystem,
      required this.style,
      required final List<ThemeStyle> supportedStyles})
      : _supportedStyles = supportedStyles,
        super._();

  @override
  final bool isFollowSystem;
  @override
  final ThemeStyle style;
  final List<ThemeStyle> _supportedStyles;
  @override
  List<ThemeStyle> get supportedStyles {
    if (_supportedStyles is EqualUnmodifiableListView) return _supportedStyles;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_supportedStyles);
  }

  @override
  String toString() {
    return 'AppThemeState(isFollowSystem: $isFollowSystem, style: $style, supportedStyles: $supportedStyles)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AppThemeStateImpl &&
            (identical(other.isFollowSystem, isFollowSystem) ||
                other.isFollowSystem == isFollowSystem) &&
            (identical(other.style, style) || other.style == style) &&
            const DeepCollectionEquality()
                .equals(other._supportedStyles, _supportedStyles));
  }

  @override
  int get hashCode => Object.hash(runtimeType, isFollowSystem, style,
      const DeepCollectionEquality().hash(_supportedStyles));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AppThemeStateImplCopyWith<_$AppThemeStateImpl> get copyWith =>
      __$$AppThemeStateImplCopyWithImpl<_$AppThemeStateImpl>(this, _$identity);
}

abstract class _AppThemeState extends AppThemeState {
  const factory _AppThemeState(
      {required final bool isFollowSystem,
      required final ThemeStyle style,
      required final List<ThemeStyle> supportedStyles}) = _$AppThemeStateImpl;
  const _AppThemeState._() : super._();

  @override
  bool get isFollowSystem;
  @override
  ThemeStyle get style;
  @override
  List<ThemeStyle> get supportedStyles;
  @override
  @JsonKey(ignore: true)
  _$$AppThemeStateImplCopyWith<_$AppThemeStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
