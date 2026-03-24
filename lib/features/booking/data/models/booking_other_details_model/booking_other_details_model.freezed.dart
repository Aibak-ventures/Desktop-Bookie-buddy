// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'booking_other_details_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$BookingOtherDetailsModel {

@JsonKey(name: 'location_start') String? get locationStart;@JsonKey(name: 'location_from') String? get locationFrom;@JsonKey(name: 'location_to') String? get locationTo;@JsonKey(name: 'end') String? get end;
/// Create a copy of BookingOtherDetailsModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BookingOtherDetailsModelCopyWith<BookingOtherDetailsModel> get copyWith => _$BookingOtherDetailsModelCopyWithImpl<BookingOtherDetailsModel>(this as BookingOtherDetailsModel, _$identity);

  /// Serializes this BookingOtherDetailsModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BookingOtherDetailsModel&&(identical(other.locationStart, locationStart) || other.locationStart == locationStart)&&(identical(other.locationFrom, locationFrom) || other.locationFrom == locationFrom)&&(identical(other.locationTo, locationTo) || other.locationTo == locationTo)&&(identical(other.end, end) || other.end == end));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,locationStart,locationFrom,locationTo,end);

@override
String toString() {
  return 'BookingOtherDetailsModel(locationStart: $locationStart, locationFrom: $locationFrom, locationTo: $locationTo, end: $end)';
}


}

/// @nodoc
abstract mixin class $BookingOtherDetailsModelCopyWith<$Res>  {
  factory $BookingOtherDetailsModelCopyWith(BookingOtherDetailsModel value, $Res Function(BookingOtherDetailsModel) _then) = _$BookingOtherDetailsModelCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'location_start') String? locationStart,@JsonKey(name: 'location_from') String? locationFrom,@JsonKey(name: 'location_to') String? locationTo,@JsonKey(name: 'end') String? end
});




}
/// @nodoc
class _$BookingOtherDetailsModelCopyWithImpl<$Res>
    implements $BookingOtherDetailsModelCopyWith<$Res> {
  _$BookingOtherDetailsModelCopyWithImpl(this._self, this._then);

  final BookingOtherDetailsModel _self;
  final $Res Function(BookingOtherDetailsModel) _then;

/// Create a copy of BookingOtherDetailsModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? locationStart = freezed,Object? locationFrom = freezed,Object? locationTo = freezed,Object? end = freezed,}) {
  return _then(_self.copyWith(
locationStart: freezed == locationStart ? _self.locationStart : locationStart // ignore: cast_nullable_to_non_nullable
as String?,locationFrom: freezed == locationFrom ? _self.locationFrom : locationFrom // ignore: cast_nullable_to_non_nullable
as String?,locationTo: freezed == locationTo ? _self.locationTo : locationTo // ignore: cast_nullable_to_non_nullable
as String?,end: freezed == end ? _self.end : end // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [BookingOtherDetailsModel].
extension BookingOtherDetailsModelPatterns on BookingOtherDetailsModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BookingOtherDetailsModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BookingOtherDetailsModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BookingOtherDetailsModel value)  $default,){
final _that = this;
switch (_that) {
case _BookingOtherDetailsModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BookingOtherDetailsModel value)?  $default,){
final _that = this;
switch (_that) {
case _BookingOtherDetailsModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'location_start')  String? locationStart, @JsonKey(name: 'location_from')  String? locationFrom, @JsonKey(name: 'location_to')  String? locationTo, @JsonKey(name: 'end')  String? end)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BookingOtherDetailsModel() when $default != null:
return $default(_that.locationStart,_that.locationFrom,_that.locationTo,_that.end);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'location_start')  String? locationStart, @JsonKey(name: 'location_from')  String? locationFrom, @JsonKey(name: 'location_to')  String? locationTo, @JsonKey(name: 'end')  String? end)  $default,) {final _that = this;
switch (_that) {
case _BookingOtherDetailsModel():
return $default(_that.locationStart,_that.locationFrom,_that.locationTo,_that.end);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'location_start')  String? locationStart, @JsonKey(name: 'location_from')  String? locationFrom, @JsonKey(name: 'location_to')  String? locationTo, @JsonKey(name: 'end')  String? end)?  $default,) {final _that = this;
switch (_that) {
case _BookingOtherDetailsModel() when $default != null:
return $default(_that.locationStart,_that.locationFrom,_that.locationTo,_that.end);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake, includeIfNull: false, createToJson: true)
class _BookingOtherDetailsModel implements BookingOtherDetailsModel {
  const _BookingOtherDetailsModel({@JsonKey(name: 'location_start') this.locationStart, @JsonKey(name: 'location_from') this.locationFrom, @JsonKey(name: 'location_to') this.locationTo, @JsonKey(name: 'end') this.end});
  factory _BookingOtherDetailsModel.fromJson(Map<String, dynamic> json) => _$BookingOtherDetailsModelFromJson(json);

@override@JsonKey(name: 'location_start') final  String? locationStart;
@override@JsonKey(name: 'location_from') final  String? locationFrom;
@override@JsonKey(name: 'location_to') final  String? locationTo;
@override@JsonKey(name: 'end') final  String? end;

/// Create a copy of BookingOtherDetailsModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BookingOtherDetailsModelCopyWith<_BookingOtherDetailsModel> get copyWith => __$BookingOtherDetailsModelCopyWithImpl<_BookingOtherDetailsModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$BookingOtherDetailsModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BookingOtherDetailsModel&&(identical(other.locationStart, locationStart) || other.locationStart == locationStart)&&(identical(other.locationFrom, locationFrom) || other.locationFrom == locationFrom)&&(identical(other.locationTo, locationTo) || other.locationTo == locationTo)&&(identical(other.end, end) || other.end == end));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,locationStart,locationFrom,locationTo,end);

@override
String toString() {
  return 'BookingOtherDetailsModel(locationStart: $locationStart, locationFrom: $locationFrom, locationTo: $locationTo, end: $end)';
}


}

/// @nodoc
abstract mixin class _$BookingOtherDetailsModelCopyWith<$Res> implements $BookingOtherDetailsModelCopyWith<$Res> {
  factory _$BookingOtherDetailsModelCopyWith(_BookingOtherDetailsModel value, $Res Function(_BookingOtherDetailsModel) _then) = __$BookingOtherDetailsModelCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'location_start') String? locationStart,@JsonKey(name: 'location_from') String? locationFrom,@JsonKey(name: 'location_to') String? locationTo,@JsonKey(name: 'end') String? end
});




}
/// @nodoc
class __$BookingOtherDetailsModelCopyWithImpl<$Res>
    implements _$BookingOtherDetailsModelCopyWith<$Res> {
  __$BookingOtherDetailsModelCopyWithImpl(this._self, this._then);

  final _BookingOtherDetailsModel _self;
  final $Res Function(_BookingOtherDetailsModel) _then;

/// Create a copy of BookingOtherDetailsModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? locationStart = freezed,Object? locationFrom = freezed,Object? locationTo = freezed,Object? end = freezed,}) {
  return _then(_BookingOtherDetailsModel(
locationStart: freezed == locationStart ? _self.locationStart : locationStart // ignore: cast_nullable_to_non_nullable
as String?,locationFrom: freezed == locationFrom ? _self.locationFrom : locationFrom // ignore: cast_nullable_to_non_nullable
as String?,locationTo: freezed == locationTo ? _self.locationTo : locationTo // ignore: cast_nullable_to_non_nullable
as String?,end: freezed == end ? _self.end : end // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
