// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'dashboard_custom_work_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$DashboardCustomWorkEntity {

 int get id; String get tailorName; String get pickupDate; CustomizationWorkStatus get status; String get products; String? get staffColor;
/// Create a copy of DashboardCustomWorkEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DashboardCustomWorkEntityCopyWith<DashboardCustomWorkEntity> get copyWith => _$DashboardCustomWorkEntityCopyWithImpl<DashboardCustomWorkEntity>(this as DashboardCustomWorkEntity, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DashboardCustomWorkEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.tailorName, tailorName) || other.tailorName == tailorName)&&(identical(other.pickupDate, pickupDate) || other.pickupDate == pickupDate)&&(identical(other.status, status) || other.status == status)&&(identical(other.products, products) || other.products == products)&&(identical(other.staffColor, staffColor) || other.staffColor == staffColor));
}


@override
int get hashCode => Object.hash(runtimeType,id,tailorName,pickupDate,status,products,staffColor);

@override
String toString() {
  return 'DashboardCustomWorkEntity(id: $id, tailorName: $tailorName, pickupDate: $pickupDate, status: $status, products: $products, staffColor: $staffColor)';
}


}

/// @nodoc
abstract mixin class $DashboardCustomWorkEntityCopyWith<$Res>  {
  factory $DashboardCustomWorkEntityCopyWith(DashboardCustomWorkEntity value, $Res Function(DashboardCustomWorkEntity) _then) = _$DashboardCustomWorkEntityCopyWithImpl;
@useResult
$Res call({
 int id, String tailorName, String pickupDate, CustomizationWorkStatus status, String products, String? staffColor
});




}
/// @nodoc
class _$DashboardCustomWorkEntityCopyWithImpl<$Res>
    implements $DashboardCustomWorkEntityCopyWith<$Res> {
  _$DashboardCustomWorkEntityCopyWithImpl(this._self, this._then);

  final DashboardCustomWorkEntity _self;
  final $Res Function(DashboardCustomWorkEntity) _then;

/// Create a copy of DashboardCustomWorkEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? tailorName = null,Object? pickupDate = null,Object? status = null,Object? products = null,Object? staffColor = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,tailorName: null == tailorName ? _self.tailorName : tailorName // ignore: cast_nullable_to_non_nullable
as String,pickupDate: null == pickupDate ? _self.pickupDate : pickupDate // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as CustomizationWorkStatus,products: null == products ? _self.products : products // ignore: cast_nullable_to_non_nullable
as String,staffColor: freezed == staffColor ? _self.staffColor : staffColor // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [DashboardCustomWorkEntity].
extension DashboardCustomWorkEntityPatterns on DashboardCustomWorkEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DashboardCustomWorkEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DashboardCustomWorkEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DashboardCustomWorkEntity value)  $default,){
final _that = this;
switch (_that) {
case _DashboardCustomWorkEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DashboardCustomWorkEntity value)?  $default,){
final _that = this;
switch (_that) {
case _DashboardCustomWorkEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String tailorName,  String pickupDate,  CustomizationWorkStatus status,  String products,  String? staffColor)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DashboardCustomWorkEntity() when $default != null:
return $default(_that.id,_that.tailorName,_that.pickupDate,_that.status,_that.products,_that.staffColor);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String tailorName,  String pickupDate,  CustomizationWorkStatus status,  String products,  String? staffColor)  $default,) {final _that = this;
switch (_that) {
case _DashboardCustomWorkEntity():
return $default(_that.id,_that.tailorName,_that.pickupDate,_that.status,_that.products,_that.staffColor);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String tailorName,  String pickupDate,  CustomizationWorkStatus status,  String products,  String? staffColor)?  $default,) {final _that = this;
switch (_that) {
case _DashboardCustomWorkEntity() when $default != null:
return $default(_that.id,_that.tailorName,_that.pickupDate,_that.status,_that.products,_that.staffColor);case _:
  return null;

}
}

}

/// @nodoc


class _DashboardCustomWorkEntity implements DashboardCustomWorkEntity {
  const _DashboardCustomWorkEntity({required this.id, required this.tailorName, required this.pickupDate, required this.status, required this.products, this.staffColor});
  

@override final  int id;
@override final  String tailorName;
@override final  String pickupDate;
@override final  CustomizationWorkStatus status;
@override final  String products;
@override final  String? staffColor;

/// Create a copy of DashboardCustomWorkEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DashboardCustomWorkEntityCopyWith<_DashboardCustomWorkEntity> get copyWith => __$DashboardCustomWorkEntityCopyWithImpl<_DashboardCustomWorkEntity>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DashboardCustomWorkEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.tailorName, tailorName) || other.tailorName == tailorName)&&(identical(other.pickupDate, pickupDate) || other.pickupDate == pickupDate)&&(identical(other.status, status) || other.status == status)&&(identical(other.products, products) || other.products == products)&&(identical(other.staffColor, staffColor) || other.staffColor == staffColor));
}


@override
int get hashCode => Object.hash(runtimeType,id,tailorName,pickupDate,status,products,staffColor);

@override
String toString() {
  return 'DashboardCustomWorkEntity(id: $id, tailorName: $tailorName, pickupDate: $pickupDate, status: $status, products: $products, staffColor: $staffColor)';
}


}

/// @nodoc
abstract mixin class _$DashboardCustomWorkEntityCopyWith<$Res> implements $DashboardCustomWorkEntityCopyWith<$Res> {
  factory _$DashboardCustomWorkEntityCopyWith(_DashboardCustomWorkEntity value, $Res Function(_DashboardCustomWorkEntity) _then) = __$DashboardCustomWorkEntityCopyWithImpl;
@override @useResult
$Res call({
 int id, String tailorName, String pickupDate, CustomizationWorkStatus status, String products, String? staffColor
});




}
/// @nodoc
class __$DashboardCustomWorkEntityCopyWithImpl<$Res>
    implements _$DashboardCustomWorkEntityCopyWith<$Res> {
  __$DashboardCustomWorkEntityCopyWithImpl(this._self, this._then);

  final _DashboardCustomWorkEntity _self;
  final $Res Function(_DashboardCustomWorkEntity) _then;

/// Create a copy of DashboardCustomWorkEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? tailorName = null,Object? pickupDate = null,Object? status = null,Object? products = null,Object? staffColor = freezed,}) {
  return _then(_DashboardCustomWorkEntity(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,tailorName: null == tailorName ? _self.tailorName : tailorName // ignore: cast_nullable_to_non_nullable
as String,pickupDate: null == pickupDate ? _self.pickupDate : pickupDate // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as CustomizationWorkStatus,products: null == products ? _self.products : products // ignore: cast_nullable_to_non_nullable
as String,staffColor: freezed == staffColor ? _self.staffColor : staffColor // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
