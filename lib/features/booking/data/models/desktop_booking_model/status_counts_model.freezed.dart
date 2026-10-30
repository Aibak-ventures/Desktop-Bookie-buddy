// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'status_counts_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$StatusCountsModel {

 Map<BookingListFilter, int> get counts;
/// Create a copy of StatusCountsModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StatusCountsModelCopyWith<StatusCountsModel> get copyWith => _$StatusCountsModelCopyWithImpl<StatusCountsModel>(this as StatusCountsModel, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as StatusCountsModel;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StatusCountsModel&&const DeepCollectionEquality().equals(other.counts, _this.counts));
}


@override
int get hashCode {
  final _this = this as StatusCountsModel;
  return Object.hash(runtimeType,const DeepCollectionEquality().hash(_this.counts));
}

@override
String toString() {
  final _this = this as StatusCountsModel;
  return 'StatusCountsModel(counts: ${_this.counts})';
}


}

/// @nodoc
abstract mixin class $StatusCountsModelCopyWith<$Res>  {
  factory $StatusCountsModelCopyWith(StatusCountsModel value, $Res Function(StatusCountsModel) _then) = _$StatusCountsModelCopyWithImpl;
@useResult
$Res call({
 Map<BookingListFilter, int> counts
});




}
/// @nodoc
class _$StatusCountsModelCopyWithImpl<$Res>
    implements $StatusCountsModelCopyWith<$Res> {
  _$StatusCountsModelCopyWithImpl(this._self, this._then);

  final StatusCountsModel _self;
  final $Res Function(StatusCountsModel) _then;

/// Create a copy of StatusCountsModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? counts = null,}) {
  return _then(StatusCountsModel(
counts: null == counts ? _self.counts : counts // ignore: cast_nullable_to_non_nullable
as Map<BookingListFilter, int>,
  ));
}

}


/// Adds pattern-matching-related methods to [StatusCountsModel].
extension StatusCountsModelPatterns on StatusCountsModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _StatusCountsModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _StatusCountsModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _StatusCountsModel value)  $default,){
final _that = this;
switch (_that) {
case _StatusCountsModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _StatusCountsModel value)?  $default,){
final _that = this;
switch (_that) {
case _StatusCountsModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Map<BookingListFilter, int> counts)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _StatusCountsModel() when $default != null:
return $default(_that.counts);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Map<BookingListFilter, int> counts)  $default,) {final _that = this;
switch (_that) {
case _StatusCountsModel():
return $default(_that.counts);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Map<BookingListFilter, int> counts)?  $default,) {final _that = this;
switch (_that) {
case _StatusCountsModel() when $default != null:
return $default(_that.counts);case _:
  return null;

}
}

}

/// @nodoc


class _StatusCountsModel implements StatusCountsModel {
  const _StatusCountsModel({ Map<BookingListFilter, int> counts = const <BookingListFilter, int>{}}): _counts = counts;
  

 final  Map<BookingListFilter, int> _counts;
@override@JsonKey() Map<BookingListFilter, int> get counts {
  if (_counts is EqualUnmodifiableMapView) return _counts;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_counts);
}


/// Create a copy of StatusCountsModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StatusCountsModelCopyWith<_StatusCountsModel> get copyWith => __$StatusCountsModelCopyWithImpl<_StatusCountsModel>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _StatusCountsModel&&const DeepCollectionEquality().equals(other.counts, _counts));
}


@override
int get hashCode {
    return Object.hash(runtimeType,const DeepCollectionEquality().hash(_counts));
}

@override
String toString() {
    return 'StatusCountsModel(counts: $counts)';
}


}

/// @nodoc
abstract mixin class _$StatusCountsModelCopyWith<$Res> implements $StatusCountsModelCopyWith<$Res> {
  factory _$StatusCountsModelCopyWith(_StatusCountsModel value, $Res Function(_StatusCountsModel) _then) = __$StatusCountsModelCopyWithImpl;
@override @useResult
$Res call({
 Map<BookingListFilter, int> counts
});




}
/// @nodoc
class __$StatusCountsModelCopyWithImpl<$Res>
    implements _$StatusCountsModelCopyWith<$Res> {
  __$StatusCountsModelCopyWithImpl(this._self, this._then);

  final _StatusCountsModel _self;
  final $Res Function(_StatusCountsModel) _then;

/// Create a copy of StatusCountsModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? counts = null,}) {
  return _then(_StatusCountsModel(
counts: null == counts ? _self._counts : counts // ignore: cast_nullable_to_non_nullable
as Map<BookingListFilter, int>,
  ));
}


}

// dart format on
