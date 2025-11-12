// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'rep_ranges.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$RepRanges {
  double get minPosition => throw _privateConstructorUsedError;
  double get maxPosition => throw _privateConstructorUsedError;

  /// Create a copy of RepRanges
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RepRangesCopyWith<RepRanges> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RepRangesCopyWith<$Res> {
  factory $RepRangesCopyWith(RepRanges value, $Res Function(RepRanges) then) =
      _$RepRangesCopyWithImpl<$Res, RepRanges>;
  @useResult
  $Res call({double minPosition, double maxPosition});
}

/// @nodoc
class _$RepRangesCopyWithImpl<$Res, $Val extends RepRanges>
    implements $RepRangesCopyWith<$Res> {
  _$RepRangesCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RepRanges
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? minPosition = null, Object? maxPosition = null}) {
    return _then(
      _value.copyWith(
            minPosition: null == minPosition
                ? _value.minPosition
                : minPosition // ignore: cast_nullable_to_non_nullable
                      as double,
            maxPosition: null == maxPosition
                ? _value.maxPosition
                : maxPosition // ignore: cast_nullable_to_non_nullable
                      as double,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$RepRangesImplCopyWith<$Res>
    implements $RepRangesCopyWith<$Res> {
  factory _$$RepRangesImplCopyWith(
    _$RepRangesImpl value,
    $Res Function(_$RepRangesImpl) then,
  ) = __$$RepRangesImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({double minPosition, double maxPosition});
}

/// @nodoc
class __$$RepRangesImplCopyWithImpl<$Res>
    extends _$RepRangesCopyWithImpl<$Res, _$RepRangesImpl>
    implements _$$RepRangesImplCopyWith<$Res> {
  __$$RepRangesImplCopyWithImpl(
    _$RepRangesImpl _value,
    $Res Function(_$RepRangesImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of RepRanges
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? minPosition = null, Object? maxPosition = null}) {
    return _then(
      _$RepRangesImpl(
        minPosition: null == minPosition
            ? _value.minPosition
            : minPosition // ignore: cast_nullable_to_non_nullable
                  as double,
        maxPosition: null == maxPosition
            ? _value.maxPosition
            : maxPosition // ignore: cast_nullable_to_non_nullable
                  as double,
      ),
    );
  }
}

/// @nodoc

class _$RepRangesImpl implements _RepRanges {
  const _$RepRangesImpl({required this.minPosition, required this.maxPosition});

  @override
  final double minPosition;
  @override
  final double maxPosition;

  @override
  String toString() {
    return 'RepRanges(minPosition: $minPosition, maxPosition: $maxPosition)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RepRangesImpl &&
            (identical(other.minPosition, minPosition) ||
                other.minPosition == minPosition) &&
            (identical(other.maxPosition, maxPosition) ||
                other.maxPosition == maxPosition));
  }

  @override
  int get hashCode => Object.hash(runtimeType, minPosition, maxPosition);

  /// Create a copy of RepRanges
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RepRangesImplCopyWith<_$RepRangesImpl> get copyWith =>
      __$$RepRangesImplCopyWithImpl<_$RepRangesImpl>(this, _$identity);
}

abstract class _RepRanges implements RepRanges {
  const factory _RepRanges({
    required final double minPosition,
    required final double maxPosition,
  }) = _$RepRangesImpl;

  @override
  double get minPosition;
  @override
  double get maxPosition;

  /// Create a copy of RepRanges
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RepRangesImplCopyWith<_$RepRangesImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
