// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_shop_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$UserShopEntity {

 int get id; String get name; String get phone; String? get phone2; String get address; String? get gstNumber; String? get image; String? get place; String? get email; String? get city; String? get state; String? get pincode; List<String> get termsAndConditions;
/// Create a copy of UserShopEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserShopEntityCopyWith<UserShopEntity> get copyWith => _$UserShopEntityCopyWithImpl<UserShopEntity>(this as UserShopEntity, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserShopEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.phone2, phone2) || other.phone2 == phone2)&&(identical(other.address, address) || other.address == address)&&(identical(other.gstNumber, gstNumber) || other.gstNumber == gstNumber)&&(identical(other.image, image) || other.image == image)&&(identical(other.place, place) || other.place == place)&&(identical(other.email, email) || other.email == email)&&(identical(other.city, city) || other.city == city)&&(identical(other.state, state) || other.state == state)&&(identical(other.pincode, pincode) || other.pincode == pincode)&&const DeepCollectionEquality().equals(other.termsAndConditions, termsAndConditions));
}


@override
int get hashCode => Object.hash(runtimeType,id,name,phone,phone2,address,gstNumber,image,place,email,city,state,pincode,const DeepCollectionEquality().hash(termsAndConditions));

@override
String toString() {
  return 'UserShopEntity(id: $id, name: $name, phone: $phone, phone2: $phone2, address: $address, gstNumber: $gstNumber, image: $image, place: $place, email: $email, city: $city, state: $state, pincode: $pincode, termsAndConditions: $termsAndConditions)';
}


}

/// @nodoc
abstract mixin class $UserShopEntityCopyWith<$Res>  {
  factory $UserShopEntityCopyWith(UserShopEntity value, $Res Function(UserShopEntity) _then) = _$UserShopEntityCopyWithImpl;
@useResult
$Res call({
 int id, String name, String phone, String? phone2, String address, String? gstNumber, String? image, String? place, String? email, String? city, String? state, String? pincode, List<String> termsAndConditions
});




}
/// @nodoc
class _$UserShopEntityCopyWithImpl<$Res>
    implements $UserShopEntityCopyWith<$Res> {
  _$UserShopEntityCopyWithImpl(this._self, this._then);

  final UserShopEntity _self;
  final $Res Function(UserShopEntity) _then;

/// Create a copy of UserShopEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? phone = null,Object? phone2 = freezed,Object? address = null,Object? gstNumber = freezed,Object? image = freezed,Object? place = freezed,Object? email = freezed,Object? city = freezed,Object? state = freezed,Object? pincode = freezed,Object? termsAndConditions = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,phone: null == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String,phone2: freezed == phone2 ? _self.phone2 : phone2 // ignore: cast_nullable_to_non_nullable
as String?,address: null == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String,gstNumber: freezed == gstNumber ? _self.gstNumber : gstNumber // ignore: cast_nullable_to_non_nullable
as String?,image: freezed == image ? _self.image : image // ignore: cast_nullable_to_non_nullable
as String?,place: freezed == place ? _self.place : place // ignore: cast_nullable_to_non_nullable
as String?,email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,city: freezed == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String?,state: freezed == state ? _self.state : state // ignore: cast_nullable_to_non_nullable
as String?,pincode: freezed == pincode ? _self.pincode : pincode // ignore: cast_nullable_to_non_nullable
as String?,termsAndConditions: null == termsAndConditions ? _self.termsAndConditions : termsAndConditions // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

}


/// Adds pattern-matching-related methods to [UserShopEntity].
extension UserShopEntityPatterns on UserShopEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UserShopEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UserShopEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UserShopEntity value)  $default,){
final _that = this;
switch (_that) {
case _UserShopEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UserShopEntity value)?  $default,){
final _that = this;
switch (_that) {
case _UserShopEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String name,  String phone,  String? phone2,  String address,  String? gstNumber,  String? image,  String? place,  String? email,  String? city,  String? state,  String? pincode,  List<String> termsAndConditions)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UserShopEntity() when $default != null:
return $default(_that.id,_that.name,_that.phone,_that.phone2,_that.address,_that.gstNumber,_that.image,_that.place,_that.email,_that.city,_that.state,_that.pincode,_that.termsAndConditions);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String name,  String phone,  String? phone2,  String address,  String? gstNumber,  String? image,  String? place,  String? email,  String? city,  String? state,  String? pincode,  List<String> termsAndConditions)  $default,) {final _that = this;
switch (_that) {
case _UserShopEntity():
return $default(_that.id,_that.name,_that.phone,_that.phone2,_that.address,_that.gstNumber,_that.image,_that.place,_that.email,_that.city,_that.state,_that.pincode,_that.termsAndConditions);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String name,  String phone,  String? phone2,  String address,  String? gstNumber,  String? image,  String? place,  String? email,  String? city,  String? state,  String? pincode,  List<String> termsAndConditions)?  $default,) {final _that = this;
switch (_that) {
case _UserShopEntity() when $default != null:
return $default(_that.id,_that.name,_that.phone,_that.phone2,_that.address,_that.gstNumber,_that.image,_that.place,_that.email,_that.city,_that.state,_that.pincode,_that.termsAndConditions);case _:
  return null;

}
}

}

/// @nodoc


class _UserShopEntity implements UserShopEntity {
  const _UserShopEntity({required this.id, required this.name, required this.phone, this.phone2, required this.address, this.gstNumber, this.image, this.place, this.email, this.city, this.state, this.pincode, required final  List<String> termsAndConditions}): _termsAndConditions = termsAndConditions;
  

@override final  int id;
@override final  String name;
@override final  String phone;
@override final  String? phone2;
@override final  String address;
@override final  String? gstNumber;
@override final  String? image;
@override final  String? place;
@override final  String? email;
@override final  String? city;
@override final  String? state;
@override final  String? pincode;
 final  List<String> _termsAndConditions;
@override List<String> get termsAndConditions {
  if (_termsAndConditions is EqualUnmodifiableListView) return _termsAndConditions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_termsAndConditions);
}


/// Create a copy of UserShopEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserShopEntityCopyWith<_UserShopEntity> get copyWith => __$UserShopEntityCopyWithImpl<_UserShopEntity>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserShopEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.phone2, phone2) || other.phone2 == phone2)&&(identical(other.address, address) || other.address == address)&&(identical(other.gstNumber, gstNumber) || other.gstNumber == gstNumber)&&(identical(other.image, image) || other.image == image)&&(identical(other.place, place) || other.place == place)&&(identical(other.email, email) || other.email == email)&&(identical(other.city, city) || other.city == city)&&(identical(other.state, state) || other.state == state)&&(identical(other.pincode, pincode) || other.pincode == pincode)&&const DeepCollectionEquality().equals(other._termsAndConditions, _termsAndConditions));
}


@override
int get hashCode => Object.hash(runtimeType,id,name,phone,phone2,address,gstNumber,image,place,email,city,state,pincode,const DeepCollectionEquality().hash(_termsAndConditions));

@override
String toString() {
  return 'UserShopEntity(id: $id, name: $name, phone: $phone, phone2: $phone2, address: $address, gstNumber: $gstNumber, image: $image, place: $place, email: $email, city: $city, state: $state, pincode: $pincode, termsAndConditions: $termsAndConditions)';
}


}

/// @nodoc
abstract mixin class _$UserShopEntityCopyWith<$Res> implements $UserShopEntityCopyWith<$Res> {
  factory _$UserShopEntityCopyWith(_UserShopEntity value, $Res Function(_UserShopEntity) _then) = __$UserShopEntityCopyWithImpl;
@override @useResult
$Res call({
 int id, String name, String phone, String? phone2, String address, String? gstNumber, String? image, String? place, String? email, String? city, String? state, String? pincode, List<String> termsAndConditions
});




}
/// @nodoc
class __$UserShopEntityCopyWithImpl<$Res>
    implements _$UserShopEntityCopyWith<$Res> {
  __$UserShopEntityCopyWithImpl(this._self, this._then);

  final _UserShopEntity _self;
  final $Res Function(_UserShopEntity) _then;

/// Create a copy of UserShopEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? phone = null,Object? phone2 = freezed,Object? address = null,Object? gstNumber = freezed,Object? image = freezed,Object? place = freezed,Object? email = freezed,Object? city = freezed,Object? state = freezed,Object? pincode = freezed,Object? termsAndConditions = null,}) {
  return _then(_UserShopEntity(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,phone: null == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String,phone2: freezed == phone2 ? _self.phone2 : phone2 // ignore: cast_nullable_to_non_nullable
as String?,address: null == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String,gstNumber: freezed == gstNumber ? _self.gstNumber : gstNumber // ignore: cast_nullable_to_non_nullable
as String?,image: freezed == image ? _self.image : image // ignore: cast_nullable_to_non_nullable
as String?,place: freezed == place ? _self.place : place // ignore: cast_nullable_to_non_nullable
as String?,email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,city: freezed == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String?,state: freezed == state ? _self.state : state // ignore: cast_nullable_to_non_nullable
as String?,pincode: freezed == pincode ? _self.pincode : pincode // ignore: cast_nullable_to_non_nullable
as String?,termsAndConditions: null == termsAndConditions ? _self._termsAndConditions : termsAndConditions // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}

// dart format on
