// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'carousel_data_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CarouselDataModel {

@JsonKey(name: 'upcoming_count', defaultValue: 0) int get upComingCount;@JsonKey(name: 'completed_count', defaultValue: 0) int get completedCount;@JsonKey(name: 'expired_count', defaultValue: 0) int get expiredCount;
/// Create a copy of CarouselDataModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CarouselDataModelCopyWith<CarouselDataModel> get copyWith => _$CarouselDataModelCopyWithImpl<CarouselDataModel>(this as CarouselDataModel, _$identity);

  /// Serializes this CarouselDataModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CarouselDataModel&&(identical(other.upComingCount, upComingCount) || other.upComingCount == upComingCount)&&(identical(other.completedCount, completedCount) || other.completedCount == completedCount)&&(identical(other.expiredCount, expiredCount) || other.expiredCount == expiredCount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,upComingCount,completedCount,expiredCount);

@override
String toString() {
  return 'CarouselDataModel(upComingCount: $upComingCount, completedCount: $completedCount, expiredCount: $expiredCount)';
}


}

/// @nodoc
abstract mixin class $CarouselDataModelCopyWith<$Res>  {
  factory $CarouselDataModelCopyWith(CarouselDataModel value, $Res Function(CarouselDataModel) _then) = _$CarouselDataModelCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'upcoming_count', defaultValue: 0) int upComingCount,@JsonKey(name: 'completed_count', defaultValue: 0) int completedCount,@JsonKey(name: 'expired_count', defaultValue: 0) int expiredCount
});




}
/// @nodoc
class _$CarouselDataModelCopyWithImpl<$Res>
    implements $CarouselDataModelCopyWith<$Res> {
  _$CarouselDataModelCopyWithImpl(this._self, this._then);

  final CarouselDataModel _self;
  final $Res Function(CarouselDataModel) _then;

/// Create a copy of CarouselDataModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? upComingCount = null,Object? completedCount = null,Object? expiredCount = null,}) {
  return _then(_self.copyWith(
upComingCount: null == upComingCount ? _self.upComingCount : upComingCount // ignore: cast_nullable_to_non_nullable
as int,completedCount: null == completedCount ? _self.completedCount : completedCount // ignore: cast_nullable_to_non_nullable
as int,expiredCount: null == expiredCount ? _self.expiredCount : expiredCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [CarouselDataModel].
extension CarouselDataModelPatterns on CarouselDataModel {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CarouselDataModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CarouselDataModel() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CarouselDataModel value)  $default,){
final _that = this;
switch (_that) {
case _CarouselDataModel():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CarouselDataModel value)?  $default,){
final _that = this;
switch (_that) {
case _CarouselDataModel() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'upcoming_count', defaultValue: 0)  int upComingCount, @JsonKey(name: 'completed_count', defaultValue: 0)  int completedCount, @JsonKey(name: 'expired_count', defaultValue: 0)  int expiredCount)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CarouselDataModel() when $default != null:
return $default(_that.upComingCount,_that.completedCount,_that.expiredCount);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'upcoming_count', defaultValue: 0)  int upComingCount, @JsonKey(name: 'completed_count', defaultValue: 0)  int completedCount, @JsonKey(name: 'expired_count', defaultValue: 0)  int expiredCount)  $default,) {final _that = this;
switch (_that) {
case _CarouselDataModel():
return $default(_that.upComingCount,_that.completedCount,_that.expiredCount);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'upcoming_count', defaultValue: 0)  int upComingCount, @JsonKey(name: 'completed_count', defaultValue: 0)  int completedCount, @JsonKey(name: 'expired_count', defaultValue: 0)  int expiredCount)?  $default,) {final _that = this;
switch (_that) {
case _CarouselDataModel() when $default != null:
return $default(_that.upComingCount,_that.completedCount,_that.expiredCount);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CarouselDataModel implements CarouselDataModel {
   _CarouselDataModel({@JsonKey(name: 'upcoming_count', defaultValue: 0) required this.upComingCount, @JsonKey(name: 'completed_count', defaultValue: 0) required this.completedCount, @JsonKey(name: 'expired_count', defaultValue: 0) required this.expiredCount});
  factory _CarouselDataModel.fromJson(Map<String, dynamic> json) => _$CarouselDataModelFromJson(json);

@override@JsonKey(name: 'upcoming_count', defaultValue: 0) final  int upComingCount;
@override@JsonKey(name: 'completed_count', defaultValue: 0) final  int completedCount;
@override@JsonKey(name: 'expired_count', defaultValue: 0) final  int expiredCount;

/// Create a copy of CarouselDataModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CarouselDataModelCopyWith<_CarouselDataModel> get copyWith => __$CarouselDataModelCopyWithImpl<_CarouselDataModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CarouselDataModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CarouselDataModel&&(identical(other.upComingCount, upComingCount) || other.upComingCount == upComingCount)&&(identical(other.completedCount, completedCount) || other.completedCount == completedCount)&&(identical(other.expiredCount, expiredCount) || other.expiredCount == expiredCount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,upComingCount,completedCount,expiredCount);

@override
String toString() {
  return 'CarouselDataModel(upComingCount: $upComingCount, completedCount: $completedCount, expiredCount: $expiredCount)';
}


}

/// @nodoc
abstract mixin class _$CarouselDataModelCopyWith<$Res> implements $CarouselDataModelCopyWith<$Res> {
  factory _$CarouselDataModelCopyWith(_CarouselDataModel value, $Res Function(_CarouselDataModel) _then) = __$CarouselDataModelCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'upcoming_count', defaultValue: 0) int upComingCount,@JsonKey(name: 'completed_count', defaultValue: 0) int completedCount,@JsonKey(name: 'expired_count', defaultValue: 0) int expiredCount
});




}
/// @nodoc
class __$CarouselDataModelCopyWithImpl<$Res>
    implements _$CarouselDataModelCopyWith<$Res> {
  __$CarouselDataModelCopyWithImpl(this._self, this._then);

  final _CarouselDataModel _self;
  final $Res Function(_CarouselDataModel) _then;

/// Create a copy of CarouselDataModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? upComingCount = null,Object? completedCount = null,Object? expiredCount = null,}) {
  return _then(_CarouselDataModel(
upComingCount: null == upComingCount ? _self.upComingCount : upComingCount // ignore: cast_nullable_to_non_nullable
as int,completedCount: null == completedCount ? _self.completedCount : completedCount // ignore: cast_nullable_to_non_nullable
as int,expiredCount: null == expiredCount ? _self.expiredCount : expiredCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
