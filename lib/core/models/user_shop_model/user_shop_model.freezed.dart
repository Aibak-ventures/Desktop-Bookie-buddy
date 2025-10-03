// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_shop_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

UserShopModel _$UserShopModelFromJson(Map<String, dynamic> json) {
  return _UserShopModel.fromJson(json);
}

/// @nodoc
mixin _$UserShopModel {
  int get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get phone => throw _privateConstructorUsedError;
  String? get phone2 => throw _privateConstructorUsedError;
  String get address => throw _privateConstructorUsedError;
  @JsonKey(name: 'gst_number')
  String? get gstNumber => throw _privateConstructorUsedError;
  String? get image => throw _privateConstructorUsedError;
  String? get place => throw _privateConstructorUsedError;
  String? get email => throw _privateConstructorUsedError;
  String? get city => throw _privateConstructorUsedError;
  String? get state => throw _privateConstructorUsedError;
  String? get pincode => throw _privateConstructorUsedError;
  @JsonKey(name: 'terms_and_conditions')
  List<String> get termsAndConditions => throw _privateConstructorUsedError;

  /// Serializes this UserShopModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UserShopModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UserShopModelCopyWith<UserShopModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserShopModelCopyWith<$Res> {
  factory $UserShopModelCopyWith(
    UserShopModel value,
    $Res Function(UserShopModel) then,
  ) = _$UserShopModelCopyWithImpl<$Res, UserShopModel>;
  @useResult
  $Res call({
    int id,
    String name,
    String phone,
    String? phone2,
    String address,
    @JsonKey(name: 'gst_number') String? gstNumber,
    String? image,
    String? place,
    String? email,
    String? city,
    String? state,
    String? pincode,
    @JsonKey(name: 'terms_and_conditions') List<String> termsAndConditions,
  });
}

/// @nodoc
class _$UserShopModelCopyWithImpl<$Res, $Val extends UserShopModel>
    implements $UserShopModelCopyWith<$Res> {
  _$UserShopModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UserShopModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? phone = null,
    Object? phone2 = freezed,
    Object? address = null,
    Object? gstNumber = freezed,
    Object? image = freezed,
    Object? place = freezed,
    Object? email = freezed,
    Object? city = freezed,
    Object? state = freezed,
    Object? pincode = freezed,
    Object? termsAndConditions = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as int,
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            phone: null == phone
                ? _value.phone
                : phone // ignore: cast_nullable_to_non_nullable
                      as String,
            phone2: freezed == phone2
                ? _value.phone2
                : phone2 // ignore: cast_nullable_to_non_nullable
                      as String?,
            address: null == address
                ? _value.address
                : address // ignore: cast_nullable_to_non_nullable
                      as String,
            gstNumber: freezed == gstNumber
                ? _value.gstNumber
                : gstNumber // ignore: cast_nullable_to_non_nullable
                      as String?,
            image: freezed == image
                ? _value.image
                : image // ignore: cast_nullable_to_non_nullable
                      as String?,
            place: freezed == place
                ? _value.place
                : place // ignore: cast_nullable_to_non_nullable
                      as String?,
            email: freezed == email
                ? _value.email
                : email // ignore: cast_nullable_to_non_nullable
                      as String?,
            city: freezed == city
                ? _value.city
                : city // ignore: cast_nullable_to_non_nullable
                      as String?,
            state: freezed == state
                ? _value.state
                : state // ignore: cast_nullable_to_non_nullable
                      as String?,
            pincode: freezed == pincode
                ? _value.pincode
                : pincode // ignore: cast_nullable_to_non_nullable
                      as String?,
            termsAndConditions: null == termsAndConditions
                ? _value.termsAndConditions
                : termsAndConditions // ignore: cast_nullable_to_non_nullable
                      as List<String>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$UserShopModelImplCopyWith<$Res>
    implements $UserShopModelCopyWith<$Res> {
  factory _$$UserShopModelImplCopyWith(
    _$UserShopModelImpl value,
    $Res Function(_$UserShopModelImpl) then,
  ) = __$$UserShopModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int id,
    String name,
    String phone,
    String? phone2,
    String address,
    @JsonKey(name: 'gst_number') String? gstNumber,
    String? image,
    String? place,
    String? email,
    String? city,
    String? state,
    String? pincode,
    @JsonKey(name: 'terms_and_conditions') List<String> termsAndConditions,
  });
}

/// @nodoc
class __$$UserShopModelImplCopyWithImpl<$Res>
    extends _$UserShopModelCopyWithImpl<$Res, _$UserShopModelImpl>
    implements _$$UserShopModelImplCopyWith<$Res> {
  __$$UserShopModelImplCopyWithImpl(
    _$UserShopModelImpl _value,
    $Res Function(_$UserShopModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of UserShopModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? phone = null,
    Object? phone2 = freezed,
    Object? address = null,
    Object? gstNumber = freezed,
    Object? image = freezed,
    Object? place = freezed,
    Object? email = freezed,
    Object? city = freezed,
    Object? state = freezed,
    Object? pincode = freezed,
    Object? termsAndConditions = null,
  }) {
    return _then(
      _$UserShopModelImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        phone: null == phone
            ? _value.phone
            : phone // ignore: cast_nullable_to_non_nullable
                  as String,
        phone2: freezed == phone2
            ? _value.phone2
            : phone2 // ignore: cast_nullable_to_non_nullable
                  as String?,
        address: null == address
            ? _value.address
            : address // ignore: cast_nullable_to_non_nullable
                  as String,
        gstNumber: freezed == gstNumber
            ? _value.gstNumber
            : gstNumber // ignore: cast_nullable_to_non_nullable
                  as String?,
        image: freezed == image
            ? _value.image
            : image // ignore: cast_nullable_to_non_nullable
                  as String?,
        place: freezed == place
            ? _value.place
            : place // ignore: cast_nullable_to_non_nullable
                  as String?,
        email: freezed == email
            ? _value.email
            : email // ignore: cast_nullable_to_non_nullable
                  as String?,
        city: freezed == city
            ? _value.city
            : city // ignore: cast_nullable_to_non_nullable
                  as String?,
        state: freezed == state
            ? _value.state
            : state // ignore: cast_nullable_to_non_nullable
                  as String?,
        pincode: freezed == pincode
            ? _value.pincode
            : pincode // ignore: cast_nullable_to_non_nullable
                  as String?,
        termsAndConditions: null == termsAndConditions
            ? _value._termsAndConditions
            : termsAndConditions // ignore: cast_nullable_to_non_nullable
                  as List<String>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$UserShopModelImpl implements _UserShopModel {
  const _$UserShopModelImpl({
    required this.id,
    required this.name,
    required this.phone,
    this.phone2,
    required this.address,
    @JsonKey(name: 'gst_number') this.gstNumber,
    this.image,
    this.place,
    this.email,
    this.city,
    this.state,
    this.pincode,
    @JsonKey(name: 'terms_and_conditions')
    final List<String> termsAndConditions = const [
      'No refund will be given after Booking cancellation.',
      'Any damages must be paid by the customer',
      'Confirm your Pickup and return dates properly.',
      'Make sure all your needs are clear before booking.',
      'Security deposit (if applicable) will be refunded after return.',
      'Products should be returned on the exact return date, without any damages.',
    ],
  }) : _termsAndConditions = termsAndConditions;

  factory _$UserShopModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserShopModelImplFromJson(json);

  @override
  final int id;
  @override
  final String name;
  @override
  final String phone;
  @override
  final String? phone2;
  @override
  final String address;
  @override
  @JsonKey(name: 'gst_number')
  final String? gstNumber;
  @override
  final String? image;
  @override
  final String? place;
  @override
  final String? email;
  @override
  final String? city;
  @override
  final String? state;
  @override
  final String? pincode;
  final List<String> _termsAndConditions;
  @override
  @JsonKey(name: 'terms_and_conditions')
  List<String> get termsAndConditions {
    if (_termsAndConditions is EqualUnmodifiableListView)
      return _termsAndConditions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_termsAndConditions);
  }

  @override
  String toString() {
    return 'UserShopModel(id: $id, name: $name, phone: $phone, phone2: $phone2, address: $address, gstNumber: $gstNumber, image: $image, place: $place, email: $email, city: $city, state: $state, pincode: $pincode, termsAndConditions: $termsAndConditions)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserShopModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.phone, phone) || other.phone == phone) &&
            (identical(other.phone2, phone2) || other.phone2 == phone2) &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.gstNumber, gstNumber) ||
                other.gstNumber == gstNumber) &&
            (identical(other.image, image) || other.image == image) &&
            (identical(other.place, place) || other.place == place) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.city, city) || other.city == city) &&
            (identical(other.state, state) || other.state == state) &&
            (identical(other.pincode, pincode) || other.pincode == pincode) &&
            const DeepCollectionEquality().equals(
              other._termsAndConditions,
              _termsAndConditions,
            ));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    name,
    phone,
    phone2,
    address,
    gstNumber,
    image,
    place,
    email,
    city,
    state,
    pincode,
    const DeepCollectionEquality().hash(_termsAndConditions),
  );

  /// Create a copy of UserShopModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserShopModelImplCopyWith<_$UserShopModelImpl> get copyWith =>
      __$$UserShopModelImplCopyWithImpl<_$UserShopModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserShopModelImplToJson(this);
  }
}

abstract class _UserShopModel implements UserShopModel {
  const factory _UserShopModel({
    required final int id,
    required final String name,
    required final String phone,
    final String? phone2,
    required final String address,
    @JsonKey(name: 'gst_number') final String? gstNumber,
    final String? image,
    final String? place,
    final String? email,
    final String? city,
    final String? state,
    final String? pincode,
    @JsonKey(name: 'terms_and_conditions')
    final List<String> termsAndConditions,
  }) = _$UserShopModelImpl;

  factory _UserShopModel.fromJson(Map<String, dynamic> json) =
      _$UserShopModelImpl.fromJson;

  @override
  int get id;
  @override
  String get name;
  @override
  String get phone;
  @override
  String? get phone2;
  @override
  String get address;
  @override
  @JsonKey(name: 'gst_number')
  String? get gstNumber;
  @override
  String? get image;
  @override
  String? get place;
  @override
  String? get email;
  @override
  String? get city;
  @override
  String? get state;
  @override
  String? get pincode;
  @override
  @JsonKey(name: 'terms_and_conditions')
  List<String> get termsAndConditions;

  /// Create a copy of UserShopModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserShopModelImplCopyWith<_$UserShopModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
