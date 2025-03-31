// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'theme_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ThemeState {
  bool get isFollowSystem => throw _privateConstructorUsedError;
  ThemeStyle get style => throw _privateConstructorUsedError;
  List<ThemeStyle> get supportedStyles => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ThemeStateCopyWith<ThemeState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ThemeStateCopyWith<$Res> {
  factory $ThemeStateCopyWith(
          ThemeState value, $Res Function(ThemeState) then) =
      _$ThemeStateCopyWithImpl<$Res, ThemeState>;
  @useResult
  $Res call(
      {bool isFollowSystem,
      ThemeStyle style,
      List<ThemeStyle> supportedStyles});
}

/// @nodoc
class _$ThemeStateCopyWithImpl<$Res, $Val extends ThemeState>
    implements $ThemeStateCopyWith<$Res> {
  _$ThemeStateCopyWithImpl(this._value, this._then);

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
abstract class _$$ThemeStateImplCopyWith<$Res>
    implements $ThemeStateCopyWith<$Res> {
  factory _$$ThemeStateImplCopyWith(
          _$ThemeStateImpl value, $Res Function(_$ThemeStateImpl) then) =
      __$$ThemeStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool isFollowSystem,
      ThemeStyle style,
      List<ThemeStyle> supportedStyles});
}

/// @nodoc
class __$$ThemeStateImplCopyWithImpl<$Res>
    extends _$ThemeStateCopyWithImpl<$Res, _$ThemeStateImpl>
    implements _$$ThemeStateImplCopyWith<$Res> {
  __$$ThemeStateImplCopyWithImpl(
      _$ThemeStateImpl _value, $Res Function(_$ThemeStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isFollowSystem = null,
    Object? style = null,
    Object? supportedStyles = null,
  }) {
    return _then(_$ThemeStateImpl(
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

class _$ThemeStateImpl extends _ThemeState {
  const _$ThemeStateImpl(
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
    return 'ThemeState(isFollowSystem: $isFollowSystem, style: $style, supportedStyles: $supportedStyles)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ThemeStateImpl &&
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
  _$$ThemeStateImplCopyWith<_$ThemeStateImpl> get copyWith =>
      __$$ThemeStateImplCopyWithImpl<_$ThemeStateImpl>(this, _$identity);
}

abstract class _ThemeState extends ThemeState {
  const factory _ThemeState(
      {required final bool isFollowSystem,
      required final ThemeStyle style,
      required final List<ThemeStyle> supportedStyles}) = _$ThemeStateImpl;
  const _ThemeState._() : super._();

  @override
  bool get isFollowSystem;
  @override
  ThemeStyle get style;
  @override
  List<ThemeStyle> get supportedStyles;
  @override
  @JsonKey(ignore: true)
  _$$ThemeStateImplCopyWith<_$ThemeStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
