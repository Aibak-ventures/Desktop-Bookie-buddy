// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_shop_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$UserShopModel {

 int get id; String get name; String get phone; String? get phone2; String get address;@JsonKey(name: 'gst_number') String? get gstNumber; String? get image; String? get place; String? get email; String? get city; String? get state; String? get pincode;@JsonKey(name: 'terms_and_conditions') List<String> get termsAndConditions;
/// Create a copy of UserShopModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserShopModelCopyWith<UserShopModel> get copyWith => _$UserShopModelCopyWithImpl<UserShopModel>(this as UserShopModel, _$identity);

  /// Serializes this UserShopModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserShopModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.phone2, phone2) || other.phone2 == phone2)&&(identical(other.address, address) || other.address == address)&&(identical(other.gstNumber, gstNumber) || other.gstNumber == gstNumber)&&(identical(other.image, image) || other.image == image)&&(identical(other.place, place) || other.place == place)&&(identical(other.email, email) || other.email == email)&&(identical(other.city, city) || other.city == city)&&(identical(other.state, state) || other.state == state)&&(identical(other.pincode, pincode) || other.pincode == pincode)&&const DeepCollectionEquality().equals(other.termsAndConditions, termsAndConditions));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,phone,phone2,address,gstNumber,image,place,email,city,state,pincode,const DeepCollectionEquality().hash(termsAndConditions));

@override
String toString() {
  return 'UserShopModel(id: $id, name: $name, phone: $phone, phone2: $phone2, address: $address, gstNumber: $gstNumber, image: $image, place: $place, email: $email, city: $city, state: $state, pincode: $pincode, termsAndConditions: $termsAndConditions)';
}


}

/// @nodoc
abstract mixin class $UserShopModelCopyWith<$Res>  {
  factory $UserShopModelCopyWith(UserShopModel value, $Res Function(UserShopModel) _then) = _$UserShopModelCopyWithImpl;
@useResult
$Res call({
 int id, String name, String phone, String? phone2, String address,@JsonKey(name: 'gst_number') String? gstNumber, String? image, String? place, String? email, String? city, String? state, String? pincode,@JsonKey(name: 'terms_and_conditions') List<String> termsAndConditions
});




}
/// @nodoc
class _$UserShopModelCopyWithImpl<$Res>
    implements $UserShopModelCopyWith<$Res> {
  _$UserShopModelCopyWithImpl(this._self, this._then);

  final UserShopModel _self;
  final $Res Function(UserShopModel) _then;

/// Create a copy of UserShopModel
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


/// Adds pattern-matching-related methods to [UserShopModel].
extension UserShopModelPatterns on UserShopModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UserShopModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UserShopModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UserShopModel value)  $default,){
final _that = this;
switch (_that) {
case _UserShopModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UserShopModel value)?  $default,){
final _that = this;
switch (_that) {
case _UserShopModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String name,  String phone,  String? phone2,  String address, @JsonKey(name: 'gst_number')  String? gstNumber,  String? image,  String? place,  String? email,  String? city,  String? state,  String? pincode, @JsonKey(name: 'terms_and_conditions')  List<String> termsAndConditions)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UserShopModel() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String name,  String phone,  String? phone2,  String address, @JsonKey(name: 'gst_number')  String? gstNumber,  String? image,  String? place,  String? email,  String? city,  String? state,  String? pincode, @JsonKey(name: 'terms_and_conditions')  List<String> termsAndConditions)  $default,) {final _that = this;
switch (_that) {
case _UserShopModel():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String name,  String phone,  String? phone2,  String address, @JsonKey(name: 'gst_number')  String? gstNumber,  String? image,  String? place,  String? email,  String? city,  String? state,  String? pincode, @JsonKey(name: 'terms_and_conditions')  List<String> termsAndConditions)?  $default,) {final _that = this;
switch (_that) {
case _UserShopModel() when $default != null:
return $default(_that.id,_that.name,_that.phone,_that.phone2,_that.address,_that.gstNumber,_that.image,_that.place,_that.email,_that.city,_that.state,_that.pincode,_that.termsAndConditions);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _UserShopModel implements UserShopModel {
  const _UserShopModel({required this.id, required this.name, required this.phone, this.phone2, required this.address, @JsonKey(name: 'gst_number') this.gstNumber, this.image, this.place, this.email, this.city, this.state, this.pincode, @JsonKey(name: 'terms_and_conditions') final  List<String> termsAndConditions = const ['No refund will be given after Booking cancellation.', 'Any damages must be paid by the customer', 'Confirm your Pickup and return dates properly.', 'Make sure all your needs are clear before booking.', 'Security deposit (if applicable) will be refunded after return.', 'Products should be returned on the exact return date, without any damages.']}): _termsAndConditions = termsAndConditions;
  factory _UserShopModel.fromJson(Map<String, dynamic> json) => _$UserShopModelFromJson(json);

@override final  int id;
@override final  String name;
@override final  String phone;
@override final  String? phone2;
@override final  String address;
@override@JsonKey(name: 'gst_number') final  String? gstNumber;
@override final  String? image;
@override final  String? place;
@override final  String? email;
@override final  String? city;
@override final  String? state;
@override final  String? pincode;
 final  List<String> _termsAndConditions;
@override@JsonKey(name: 'terms_and_conditions') List<String> get termsAndConditions {
  if (_termsAndConditions is EqualUnmodifiableListView) return _termsAndConditions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_termsAndConditions);
}


/// Create a copy of UserShopModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserShopModelCopyWith<_UserShopModel> get copyWith => __$UserShopModelCopyWithImpl<_UserShopModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UserShopModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserShopModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.phone2, phone2) || other.phone2 == phone2)&&(identical(other.address, address) || other.address == address)&&(identical(other.gstNumber, gstNumber) || other.gstNumber == gstNumber)&&(identical(other.image, image) || other.image == image)&&(identical(other.place, place) || other.place == place)&&(identical(other.email, email) || other.email == email)&&(identical(other.city, city) || other.city == city)&&(identical(other.state, state) || other.state == state)&&(identical(other.pincode, pincode) || other.pincode == pincode)&&const DeepCollectionEquality().equals(other._termsAndConditions, _termsAndConditions));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,phone,phone2,address,gstNumber,image,place,email,city,state,pincode,const DeepCollectionEquality().hash(_termsAndConditions));

@override
String toString() {
  return 'UserShopModel(id: $id, name: $name, phone: $phone, phone2: $phone2, address: $address, gstNumber: $gstNumber, image: $image, place: $place, email: $email, city: $city, state: $state, pincode: $pincode, termsAndConditions: $termsAndConditions)';
}


}

/// @nodoc
abstract mixin class _$UserShopModelCopyWith<$Res> implements $UserShopModelCopyWith<$Res> {
  factory _$UserShopModelCopyWith(_UserShopModel value, $Res Function(_UserShopModel) _then) = __$UserShopModelCopyWithImpl;
@override @useResult
$Res call({
 int id, String name, String phone, String? phone2, String address,@JsonKey(name: 'gst_number') String? gstNumber, String? image, String? place, String? email, String? city, String? state, String? pincode,@JsonKey(name: 'terms_and_conditions') List<String> termsAndConditions
});




}
/// @nodoc
class __$UserShopModelCopyWithImpl<$Res>
    implements _$UserShopModelCopyWith<$Res> {
  __$UserShopModelCopyWithImpl(this._self, this._then);

  final _UserShopModel _self;
  final $Res Function(_UserShopModel) _then;

/// Create a copy of UserShopModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? phone = null,Object? phone2 = freezed,Object? address = null,Object? gstNumber = freezed,Object? image = freezed,Object? place = freezed,Object? email = freezed,Object? city = freezed,Object? state = freezed,Object? pincode = freezed,Object? termsAndConditions = null,}) {
  return _then(_UserShopModel(
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
