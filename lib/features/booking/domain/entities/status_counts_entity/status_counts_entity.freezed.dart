// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'status_counts_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$StatusCountsEntity {

 int get completed; int get upcoming; int get returns; int get pending; int get notReturned; int get cancelled;
/// Create a copy of StatusCountsEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StatusCountsEntityCopyWith<StatusCountsEntity> get copyWith => _$StatusCountsEntityCopyWithImpl<StatusCountsEntity>(this as StatusCountsEntity, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StatusCountsEntity&&(identical(other.completed, completed) || other.completed == completed)&&(identical(other.upcoming, upcoming) || other.upcoming == upcoming)&&(identical(other.returns, returns) || other.returns == returns)&&(identical(other.pending, pending) || other.pending == pending)&&(identical(other.notReturned, notReturned) || other.notReturned == notReturned)&&(identical(other.cancelled, cancelled) || other.cancelled == cancelled));
}


@override
int get hashCode => Object.hash(runtimeType,completed,upcoming,returns,pending,notReturned,cancelled);

@override
String toString() {
  return 'StatusCountsEntity(completed: $completed, upcoming: $upcoming, returns: $returns, pending: $pending, notReturned: $notReturned, cancelled: $cancelled)';
}


}

/// @nodoc
abstract mixin class $StatusCountsEntityCopyWith<$Res>  {
  factory $StatusCountsEntityCopyWith(StatusCountsEntity value, $Res Function(StatusCountsEntity) _then) = _$StatusCountsEntityCopyWithImpl;
@useResult
$Res call({
 int completed, int upcoming, int returns, int pending, int notReturned, int cancelled
});




}
/// @nodoc
class _$StatusCountsEntityCopyWithImpl<$Res>
    implements $StatusCountsEntityCopyWith<$Res> {
  _$StatusCountsEntityCopyWithImpl(this._self, this._then);

  final StatusCountsEntity _self;
  final $Res Function(StatusCountsEntity) _then;

/// Create a copy of StatusCountsEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? completed = null,Object? upcoming = null,Object? returns = null,Object? pending = null,Object? notReturned = null,Object? cancelled = null,}) {
  return _then(_self.copyWith(
completed: null == completed ? _self.completed : completed // ignore: cast_nullable_to_non_nullable
as int,upcoming: null == upcoming ? _self.upcoming : upcoming // ignore: cast_nullable_to_non_nullable
as int,returns: null == returns ? _self.returns : returns // ignore: cast_nullable_to_non_nullable
as int,pending: null == pending ? _self.pending : pending // ignore: cast_nullable_to_non_nullable
as int,notReturned: null == notReturned ? _self.notReturned : notReturned // ignore: cast_nullable_to_non_nullable
as int,cancelled: null == cancelled ? _self.cancelled : cancelled // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [StatusCountsEntity].
extension StatusCountsEntityPatterns on StatusCountsEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _StatusCountsEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _StatusCountsEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _StatusCountsEntity value)  $default,){
final _that = this;
switch (_that) {
case _StatusCountsEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _StatusCountsEntity value)?  $default,){
final _that = this;
switch (_that) {
case _StatusCountsEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int completed,  int upcoming,  int returns,  int pending,  int notReturned,  int cancelled)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _StatusCountsEntity() when $default != null:
return $default(_that.completed,_that.upcoming,_that.returns,_that.pending,_that.notReturned,_that.cancelled);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int completed,  int upcoming,  int returns,  int pending,  int notReturned,  int cancelled)  $default,) {final _that = this;
switch (_that) {
case _StatusCountsEntity():
return $default(_that.completed,_that.upcoming,_that.returns,_that.pending,_that.notReturned,_that.cancelled);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int completed,  int upcoming,  int returns,  int pending,  int notReturned,  int cancelled)?  $default,) {final _that = this;
switch (_that) {
case _StatusCountsEntity() when $default != null:
return $default(_that.completed,_that.upcoming,_that.returns,_that.pending,_that.notReturned,_that.cancelled);case _:
  return null;

}
}

}

/// @nodoc


class _StatusCountsEntity implements StatusCountsEntity {
  const _StatusCountsEntity({this.completed = 0, this.upcoming = 0, this.returns = 0, this.pending = 0, this.notReturned = 0, this.cancelled = 0});
  

@override@JsonKey() final  int completed;
@override@JsonKey() final  int upcoming;
@override@JsonKey() final  int returns;
@override@JsonKey() final  int pending;
@override@JsonKey() final  int notReturned;
@override@JsonKey() final  int cancelled;

/// Create a copy of StatusCountsEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StatusCountsEntityCopyWith<_StatusCountsEntity> get copyWith => __$StatusCountsEntityCopyWithImpl<_StatusCountsEntity>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _StatusCountsEntity&&(identical(other.completed, completed) || other.completed == completed)&&(identical(other.upcoming, upcoming) || other.upcoming == upcoming)&&(identical(other.returns, returns) || other.returns == returns)&&(identical(other.pending, pending) || other.pending == pending)&&(identical(other.notReturned, notReturned) || other.notReturned == notReturned)&&(identical(other.cancelled, cancelled) || other.cancelled == cancelled));
}


@override
int get hashCode => Object.hash(runtimeType,completed,upcoming,returns,pending,notReturned,cancelled);

@override
String toString() {
  return 'StatusCountsEntity(completed: $completed, upcoming: $upcoming, returns: $returns, pending: $pending, notReturned: $notReturned, cancelled: $cancelled)';
}


}

/// @nodoc
abstract mixin class _$StatusCountsEntityCopyWith<$Res> implements $StatusCountsEntityCopyWith<$Res> {
  factory _$StatusCountsEntityCopyWith(_StatusCountsEntity value, $Res Function(_StatusCountsEntity) _then) = __$StatusCountsEntityCopyWithImpl;
@override @useResult
$Res call({
 int completed, int upcoming, int returns, int pending, int notReturned, int cancelled
});




}
/// @nodoc
class __$StatusCountsEntityCopyWithImpl<$Res>
    implements _$StatusCountsEntityCopyWith<$Res> {
  __$StatusCountsEntityCopyWithImpl(this._self, this._then);

  final _StatusCountsEntity _self;
  final $Res Function(_StatusCountsEntity) _then;

/// Create a copy of StatusCountsEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? completed = null,Object? upcoming = null,Object? returns = null,Object? pending = null,Object? notReturned = null,Object? cancelled = null,}) {
  return _then(_StatusCountsEntity(
completed: null == completed ? _self.completed : completed // ignore: cast_nullable_to_non_nullable
as int,upcoming: null == upcoming ? _self.upcoming : upcoming // ignore: cast_nullable_to_non_nullable
as int,returns: null == returns ? _self.returns : returns // ignore: cast_nullable_to_non_nullable
as int,pending: null == pending ? _self.pending : pending // ignore: cast_nullable_to_non_nullable
as int,notReturned: null == notReturned ? _self.notReturned : notReturned // ignore: cast_nullable_to_non_nullable
as int,cancelled: null == cancelled ? _self.cancelled : cancelled // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
