// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'product_attributes_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ProductAttributesModel {

@JsonKey(name: 'pollution_expiry') String? get pollutionExpiryDate;@JsonKey(name: 'insurance_expiry') String? get insuranceExpiryDate;@JsonKey(name: 'permit_expiry') String? get fitnessExpiryDate;@JsonKey(name: 'transport_permit_expiry') String? get permitDate;@JsonKey(name: 'registration_number') String? get registrationNumber;
/// Create a copy of ProductAttributesModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProductAttributesModelCopyWith<ProductAttributesModel> get copyWith => _$ProductAttributesModelCopyWithImpl<ProductAttributesModel>(this as ProductAttributesModel, _$identity);

  /// Serializes this ProductAttributesModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProductAttributesModel&&(identical(other.pollutionExpiryDate, pollutionExpiryDate) || other.pollutionExpiryDate == pollutionExpiryDate)&&(identical(other.insuranceExpiryDate, insuranceExpiryDate) || other.insuranceExpiryDate == insuranceExpiryDate)&&(identical(other.fitnessExpiryDate, fitnessExpiryDate) || other.fitnessExpiryDate == fitnessExpiryDate)&&(identical(other.permitDate, permitDate) || other.permitDate == permitDate)&&(identical(other.registrationNumber, registrationNumber) || other.registrationNumber == registrationNumber));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,pollutionExpiryDate,insuranceExpiryDate,fitnessExpiryDate,permitDate,registrationNumber);

@override
String toString() {
  return 'ProductAttributesModel(pollutionExpiryDate: $pollutionExpiryDate, insuranceExpiryDate: $insuranceExpiryDate, fitnessExpiryDate: $fitnessExpiryDate, permitDate: $permitDate, registrationNumber: $registrationNumber)';
}


}

/// @nodoc
abstract mixin class $ProductAttributesModelCopyWith<$Res>  {
  factory $ProductAttributesModelCopyWith(ProductAttributesModel value, $Res Function(ProductAttributesModel) _then) = _$ProductAttributesModelCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'pollution_expiry') String? pollutionExpiryDate,@JsonKey(name: 'insurance_expiry') String? insuranceExpiryDate,@JsonKey(name: 'permit_expiry') String? fitnessExpiryDate,@JsonKey(name: 'transport_permit_expiry') String? permitDate,@JsonKey(name: 'registration_number') String? registrationNumber
});




}
/// @nodoc
class _$ProductAttributesModelCopyWithImpl<$Res>
    implements $ProductAttributesModelCopyWith<$Res> {
  _$ProductAttributesModelCopyWithImpl(this._self, this._then);

  final ProductAttributesModel _self;
  final $Res Function(ProductAttributesModel) _then;

/// Create a copy of ProductAttributesModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? pollutionExpiryDate = freezed,Object? insuranceExpiryDate = freezed,Object? fitnessExpiryDate = freezed,Object? permitDate = freezed,Object? registrationNumber = freezed,}) {
  return _then(_self.copyWith(
pollutionExpiryDate: freezed == pollutionExpiryDate ? _self.pollutionExpiryDate : pollutionExpiryDate // ignore: cast_nullable_to_non_nullable
as String?,insuranceExpiryDate: freezed == insuranceExpiryDate ? _self.insuranceExpiryDate : insuranceExpiryDate // ignore: cast_nullable_to_non_nullable
as String?,fitnessExpiryDate: freezed == fitnessExpiryDate ? _self.fitnessExpiryDate : fitnessExpiryDate // ignore: cast_nullable_to_non_nullable
as String?,permitDate: freezed == permitDate ? _self.permitDate : permitDate // ignore: cast_nullable_to_non_nullable
as String?,registrationNumber: freezed == registrationNumber ? _self.registrationNumber : registrationNumber // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [ProductAttributesModel].
extension ProductAttributesModelPatterns on ProductAttributesModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ProductAttributesModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ProductAttributesModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ProductAttributesModel value)  $default,){
final _that = this;
switch (_that) {
case _ProductAttributesModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ProductAttributesModel value)?  $default,){
final _that = this;
switch (_that) {
case _ProductAttributesModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'pollution_expiry')  String? pollutionExpiryDate, @JsonKey(name: 'insurance_expiry')  String? insuranceExpiryDate, @JsonKey(name: 'permit_expiry')  String? fitnessExpiryDate, @JsonKey(name: 'transport_permit_expiry')  String? permitDate, @JsonKey(name: 'registration_number')  String? registrationNumber)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ProductAttributesModel() when $default != null:
return $default(_that.pollutionExpiryDate,_that.insuranceExpiryDate,_that.fitnessExpiryDate,_that.permitDate,_that.registrationNumber);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'pollution_expiry')  String? pollutionExpiryDate, @JsonKey(name: 'insurance_expiry')  String? insuranceExpiryDate, @JsonKey(name: 'permit_expiry')  String? fitnessExpiryDate, @JsonKey(name: 'transport_permit_expiry')  String? permitDate, @JsonKey(name: 'registration_number')  String? registrationNumber)  $default,) {final _that = this;
switch (_that) {
case _ProductAttributesModel():
return $default(_that.pollutionExpiryDate,_that.insuranceExpiryDate,_that.fitnessExpiryDate,_that.permitDate,_that.registrationNumber);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'pollution_expiry')  String? pollutionExpiryDate, @JsonKey(name: 'insurance_expiry')  String? insuranceExpiryDate, @JsonKey(name: 'permit_expiry')  String? fitnessExpiryDate, @JsonKey(name: 'transport_permit_expiry')  String? permitDate, @JsonKey(name: 'registration_number')  String? registrationNumber)?  $default,) {final _that = this;
switch (_that) {
case _ProductAttributesModel() when $default != null:
return $default(_that.pollutionExpiryDate,_that.insuranceExpiryDate,_that.fitnessExpiryDate,_that.permitDate,_that.registrationNumber);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable(includeIfNull: false)
class _ProductAttributesModel implements ProductAttributesModel {
  const _ProductAttributesModel({@JsonKey(name: 'pollution_expiry') this.pollutionExpiryDate, @JsonKey(name: 'insurance_expiry') this.insuranceExpiryDate, @JsonKey(name: 'permit_expiry') this.fitnessExpiryDate, @JsonKey(name: 'transport_permit_expiry') this.permitDate, @JsonKey(name: 'registration_number') this.registrationNumber});
  factory _ProductAttributesModel.fromJson(Map<String, dynamic> json) => _$ProductAttributesModelFromJson(json);

@override@JsonKey(name: 'pollution_expiry') final  String? pollutionExpiryDate;
@override@JsonKey(name: 'insurance_expiry') final  String? insuranceExpiryDate;
@override@JsonKey(name: 'permit_expiry') final  String? fitnessExpiryDate;
@override@JsonKey(name: 'transport_permit_expiry') final  String? permitDate;
@override@JsonKey(name: 'registration_number') final  String? registrationNumber;

/// Create a copy of ProductAttributesModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProductAttributesModelCopyWith<_ProductAttributesModel> get copyWith => __$ProductAttributesModelCopyWithImpl<_ProductAttributesModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ProductAttributesModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProductAttributesModel&&(identical(other.pollutionExpiryDate, pollutionExpiryDate) || other.pollutionExpiryDate == pollutionExpiryDate)&&(identical(other.insuranceExpiryDate, insuranceExpiryDate) || other.insuranceExpiryDate == insuranceExpiryDate)&&(identical(other.fitnessExpiryDate, fitnessExpiryDate) || other.fitnessExpiryDate == fitnessExpiryDate)&&(identical(other.permitDate, permitDate) || other.permitDate == permitDate)&&(identical(other.registrationNumber, registrationNumber) || other.registrationNumber == registrationNumber));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,pollutionExpiryDate,insuranceExpiryDate,fitnessExpiryDate,permitDate,registrationNumber);

@override
String toString() {
  return 'ProductAttributesModel(pollutionExpiryDate: $pollutionExpiryDate, insuranceExpiryDate: $insuranceExpiryDate, fitnessExpiryDate: $fitnessExpiryDate, permitDate: $permitDate, registrationNumber: $registrationNumber)';
}


}

/// @nodoc
abstract mixin class _$ProductAttributesModelCopyWith<$Res> implements $ProductAttributesModelCopyWith<$Res> {
  factory _$ProductAttributesModelCopyWith(_ProductAttributesModel value, $Res Function(_ProductAttributesModel) _then) = __$ProductAttributesModelCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'pollution_expiry') String? pollutionExpiryDate,@JsonKey(name: 'insurance_expiry') String? insuranceExpiryDate,@JsonKey(name: 'permit_expiry') String? fitnessExpiryDate,@JsonKey(name: 'transport_permit_expiry') String? permitDate,@JsonKey(name: 'registration_number') String? registrationNumber
});




}
/// @nodoc
class __$ProductAttributesModelCopyWithImpl<$Res>
    implements _$ProductAttributesModelCopyWith<$Res> {
  __$ProductAttributesModelCopyWithImpl(this._self, this._then);

  final _ProductAttributesModel _self;
  final $Res Function(_ProductAttributesModel) _then;

/// Create a copy of ProductAttributesModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? pollutionExpiryDate = freezed,Object? insuranceExpiryDate = freezed,Object? fitnessExpiryDate = freezed,Object? permitDate = freezed,Object? registrationNumber = freezed,}) {
  return _then(_ProductAttributesModel(
pollutionExpiryDate: freezed == pollutionExpiryDate ? _self.pollutionExpiryDate : pollutionExpiryDate // ignore: cast_nullable_to_non_nullable
as String?,insuranceExpiryDate: freezed == insuranceExpiryDate ? _self.insuranceExpiryDate : insuranceExpiryDate // ignore: cast_nullable_to_non_nullable
as String?,fitnessExpiryDate: freezed == fitnessExpiryDate ? _self.fitnessExpiryDate : fitnessExpiryDate // ignore: cast_nullable_to_non_nullable
as String?,permitDate: freezed == permitDate ? _self.permitDate : permitDate // ignore: cast_nullable_to_non_nullable
as String?,registrationNumber: freezed == registrationNumber ? _self.registrationNumber : registrationNumber // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
