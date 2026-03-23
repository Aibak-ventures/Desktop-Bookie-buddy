// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'shop_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ShopEntity {

 int get id; String get name; String? get place; String get phone; String? get email; String get address; String? get pincode; String? get subscriptionStatus; String? get image;
/// Create a copy of ShopEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ShopEntityCopyWith<ShopEntity> get copyWith => _$ShopEntityCopyWithImpl<ShopEntity>(this as ShopEntity, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ShopEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.place, place) || other.place == place)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.email, email) || other.email == email)&&(identical(other.address, address) || other.address == address)&&(identical(other.pincode, pincode) || other.pincode == pincode)&&(identical(other.subscriptionStatus, subscriptionStatus) || other.subscriptionStatus == subscriptionStatus)&&(identical(other.image, image) || other.image == image));
}


@override
int get hashCode => Object.hash(runtimeType,id,name,place,phone,email,address,pincode,subscriptionStatus,image);

@override
String toString() {
  return 'ShopEntity(id: $id, name: $name, place: $place, phone: $phone, email: $email, address: $address, pincode: $pincode, subscriptionStatus: $subscriptionStatus, image: $image)';
}


}

/// @nodoc
abstract mixin class $ShopEntityCopyWith<$Res>  {
  factory $ShopEntityCopyWith(ShopEntity value, $Res Function(ShopEntity) _then) = _$ShopEntityCopyWithImpl;
@useResult
$Res call({
 int id, String name, String? place, String phone, String? email, String address, String? pincode, String? subscriptionStatus, String? image
});




}
/// @nodoc
class _$ShopEntityCopyWithImpl<$Res>
    implements $ShopEntityCopyWith<$Res> {
  _$ShopEntityCopyWithImpl(this._self, this._then);

  final ShopEntity _self;
  final $Res Function(ShopEntity) _then;

/// Create a copy of ShopEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? place = freezed,Object? phone = null,Object? email = freezed,Object? address = null,Object? pincode = freezed,Object? subscriptionStatus = freezed,Object? image = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,place: freezed == place ? _self.place : place // ignore: cast_nullable_to_non_nullable
as String?,phone: null == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String,email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,address: null == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String,pincode: freezed == pincode ? _self.pincode : pincode // ignore: cast_nullable_to_non_nullable
as String?,subscriptionStatus: freezed == subscriptionStatus ? _self.subscriptionStatus : subscriptionStatus // ignore: cast_nullable_to_non_nullable
as String?,image: freezed == image ? _self.image : image // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [ShopEntity].
extension ShopEntityPatterns on ShopEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ShopEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ShopEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ShopEntity value)  $default,){
final _that = this;
switch (_that) {
case _ShopEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ShopEntity value)?  $default,){
final _that = this;
switch (_that) {
case _ShopEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String name,  String? place,  String phone,  String? email,  String address,  String? pincode,  String? subscriptionStatus,  String? image)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ShopEntity() when $default != null:
return $default(_that.id,_that.name,_that.place,_that.phone,_that.email,_that.address,_that.pincode,_that.subscriptionStatus,_that.image);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String name,  String? place,  String phone,  String? email,  String address,  String? pincode,  String? subscriptionStatus,  String? image)  $default,) {final _that = this;
switch (_that) {
case _ShopEntity():
return $default(_that.id,_that.name,_that.place,_that.phone,_that.email,_that.address,_that.pincode,_that.subscriptionStatus,_that.image);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String name,  String? place,  String phone,  String? email,  String address,  String? pincode,  String? subscriptionStatus,  String? image)?  $default,) {final _that = this;
switch (_that) {
case _ShopEntity() when $default != null:
return $default(_that.id,_that.name,_that.place,_that.phone,_that.email,_that.address,_that.pincode,_that.subscriptionStatus,_that.image);case _:
  return null;

}
}

}

/// @nodoc


class _ShopEntity implements ShopEntity {
  const _ShopEntity({required this.id, required this.name, this.place, required this.phone, this.email, required this.address, this.pincode, this.subscriptionStatus, this.image});
  

@override final  int id;
@override final  String name;
@override final  String? place;
@override final  String phone;
@override final  String? email;
@override final  String address;
@override final  String? pincode;
@override final  String? subscriptionStatus;
@override final  String? image;

/// Create a copy of ShopEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ShopEntityCopyWith<_ShopEntity> get copyWith => __$ShopEntityCopyWithImpl<_ShopEntity>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ShopEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.place, place) || other.place == place)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.email, email) || other.email == email)&&(identical(other.address, address) || other.address == address)&&(identical(other.pincode, pincode) || other.pincode == pincode)&&(identical(other.subscriptionStatus, subscriptionStatus) || other.subscriptionStatus == subscriptionStatus)&&(identical(other.image, image) || other.image == image));
}


@override
int get hashCode => Object.hash(runtimeType,id,name,place,phone,email,address,pincode,subscriptionStatus,image);

@override
String toString() {
  return 'ShopEntity(id: $id, name: $name, place: $place, phone: $phone, email: $email, address: $address, pincode: $pincode, subscriptionStatus: $subscriptionStatus, image: $image)';
}


}

/// @nodoc
abstract mixin class _$ShopEntityCopyWith<$Res> implements $ShopEntityCopyWith<$Res> {
  factory _$ShopEntityCopyWith(_ShopEntity value, $Res Function(_ShopEntity) _then) = __$ShopEntityCopyWithImpl;
@override @useResult
$Res call({
 int id, String name, String? place, String phone, String? email, String address, String? pincode, String? subscriptionStatus, String? image
});




}
/// @nodoc
class __$ShopEntityCopyWithImpl<$Res>
    implements _$ShopEntityCopyWith<$Res> {
  __$ShopEntityCopyWithImpl(this._self, this._then);

  final _ShopEntity _self;
  final $Res Function(_ShopEntity) _then;

/// Create a copy of ShopEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? place = freezed,Object? phone = null,Object? email = freezed,Object? address = null,Object? pincode = freezed,Object? subscriptionStatus = freezed,Object? image = freezed,}) {
  return _then(_ShopEntity(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,place: freezed == place ? _self.place : place // ignore: cast_nullable_to_non_nullable
as String?,phone: null == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String,email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,address: null == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String,pincode: freezed == pincode ? _self.pincode : pincode // ignore: cast_nullable_to_non_nullable
as String?,subscriptionStatus: freezed == subscriptionStatus ? _self.subscriptionStatus : subscriptionStatus // ignore: cast_nullable_to_non_nullable
as String?,image: freezed == image ? _self.image : image // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
