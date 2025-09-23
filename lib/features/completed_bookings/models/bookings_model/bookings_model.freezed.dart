// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'bookings_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

BookingsModel _$BookingsModelFromJson(Map<String, dynamic> json) {
  return _BookingsModel.fromJson(json);
}

/// @nodoc
mixin _$BookingsModel {
  int get id => throw _privateConstructorUsedError;
  String get customerName => throw _privateConstructorUsedError;
  String get customerPhone => throw _privateConstructorUsedError;
  String get bookingDate => throw _privateConstructorUsedError;
  String get bookingTime => throw _privateConstructorUsedError;
  String get serviceName => throw _privateConstructorUsedError;
  double get totalAmount => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  String get createdAt => throw _privateConstructorUsedError;
  String get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this BookingsModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of BookingsModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BookingsModelCopyWith<BookingsModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BookingsModelCopyWith<$Res> {
  factory $BookingsModelCopyWith(
          BookingsModel value, $Res Function(BookingsModel) then) =
      _$BookingsModelCopyWithImpl<$Res, BookingsModel>;
  @useResult
  $Res call(
      {int id,
      String customerName,
      String customerPhone,
      String bookingDate,
      String bookingTime,
      String serviceName,
      double totalAmount,
      String status,
      String createdAt,
      String updatedAt});
}

/// @nodoc
class _$BookingsModelCopyWithImpl<$Res, $Val extends BookingsModel>
    implements $BookingsModelCopyWith<$Res> {
  _$BookingsModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BookingsModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? customerName = null,
    Object? customerPhone = null,
    Object? bookingDate = null,
    Object? bookingTime = null,
    Object? serviceName = null,
    Object? totalAmount = null,
    Object? status = null,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      customerName: null == customerName
          ? _value.customerName
          : customerName // ignore: cast_nullable_to_non_nullable
              as String,
      customerPhone: null == customerPhone
          ? _value.customerPhone
          : customerPhone // ignore: cast_nullable_to_non_nullable
              as String,
      bookingDate: null == bookingDate
          ? _value.bookingDate
          : bookingDate // ignore: cast_nullable_to_non_nullable
              as String,
      bookingTime: null == bookingTime
          ? _value.bookingTime
          : bookingTime // ignore: cast_nullable_to_non_nullable
              as String,
      serviceName: null == serviceName
          ? _value.serviceName
          : serviceName // ignore: cast_nullable_to_non_nullable
              as String,
      totalAmount: null == totalAmount
          ? _value.totalAmount
          : totalAmount // ignore: cast_nullable_to_non_nullable
              as double,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$BookingsModelImplCopyWith<$Res>
    implements $BookingsModelCopyWith<$Res> {
  factory _$$BookingsModelImplCopyWith(
          _$BookingsModelImpl value, $Res Function(_$BookingsModelImpl) then) =
      __$$BookingsModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      String customerName,
      String customerPhone,
      String bookingDate,
      String bookingTime,
      String serviceName,
      double totalAmount,
      String status,
      String createdAt,
      String updatedAt});
}

/// @nodoc
class __$$BookingsModelImplCopyWithImpl<$Res>
    extends _$BookingsModelCopyWithImpl<$Res, _$BookingsModelImpl>
    implements _$$BookingsModelImplCopyWith<$Res> {
  __$$BookingsModelImplCopyWithImpl(
      _$BookingsModelImpl _value, $Res Function(_$BookingsModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of BookingsModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? customerName = null,
    Object? customerPhone = null,
    Object? bookingDate = null,
    Object? bookingTime = null,
    Object? serviceName = null,
    Object? totalAmount = null,
    Object? status = null,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(_$BookingsModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      customerName: null == customerName
          ? _value.customerName
          : customerName // ignore: cast_nullable_to_non_nullable
              as String,
      customerPhone: null == customerPhone
          ? _value.customerPhone
          : customerPhone // ignore: cast_nullable_to_non_nullable
              as String,
      bookingDate: null == bookingDate
          ? _value.bookingDate
          : bookingDate // ignore: cast_nullable_to_non_nullable
              as String,
      bookingTime: null == bookingTime
          ? _value.bookingTime
          : bookingTime // ignore: cast_nullable_to_non_nullable
              as String,
      serviceName: null == serviceName
          ? _value.serviceName
          : serviceName // ignore: cast_nullable_to_non_nullable
              as String,
      totalAmount: null == totalAmount
          ? _value.totalAmount
          : totalAmount // ignore: cast_nullable_to_non_nullable
              as double,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$BookingsModelImpl implements _BookingsModel {
  const _$BookingsModelImpl(
      {required this.id,
      required this.customerName,
      required this.customerPhone,
      required this.bookingDate,
      required this.bookingTime,
      required this.serviceName,
      required this.totalAmount,
      required this.status,
      required this.createdAt,
      required this.updatedAt});

  factory _$BookingsModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$BookingsModelImplFromJson(json);

  @override
  final int id;
  @override
  final String customerName;
  @override
  final String customerPhone;
  @override
  final String bookingDate;
  @override
  final String bookingTime;
  @override
  final String serviceName;
  @override
  final double totalAmount;
  @override
  final String status;
  @override
  final String createdAt;
  @override
  final String updatedAt;

  @override
  String toString() {
    return 'BookingsModel(id: $id, customerName: $customerName, customerPhone: $customerPhone, bookingDate: $bookingDate, bookingTime: $bookingTime, serviceName: $serviceName, totalAmount: $totalAmount, status: $status, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BookingsModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.customerName, customerName) ||
                other.customerName == customerName) &&
            (identical(other.customerPhone, customerPhone) ||
                other.customerPhone == customerPhone) &&
            (identical(other.bookingDate, bookingDate) ||
                other.bookingDate == bookingDate) &&
            (identical(other.bookingTime, bookingTime) ||
                other.bookingTime == bookingTime) &&
            (identical(other.serviceName, serviceName) ||
                other.serviceName == serviceName) &&
            (identical(other.totalAmount, totalAmount) ||
                other.totalAmount == totalAmount) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      customerName,
      customerPhone,
      bookingDate,
      bookingTime,
      serviceName,
      totalAmount,
      status,
      createdAt,
      updatedAt);

  /// Create a copy of BookingsModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BookingsModelImplCopyWith<_$BookingsModelImpl> get copyWith =>
      __$$BookingsModelImplCopyWithImpl<_$BookingsModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BookingsModelImplToJson(
      this,
    );
  }
}

abstract class _BookingsModel implements BookingsModel {
  const factory _BookingsModel(
      {required final int id,
      required final String customerName,
      required final String customerPhone,
      required final String bookingDate,
      required final String bookingTime,
      required final String serviceName,
      required final double totalAmount,
      required final String status,
      required final String createdAt,
      required final String updatedAt}) = _$BookingsModelImpl;

  factory _BookingsModel.fromJson(Map<String, dynamic> json) =
      _$BookingsModelImpl.fromJson;

  @override
  int get id;
  @override
  String get customerName;
  @override
  String get customerPhone;
  @override
  String get bookingDate;
  @override
  String get bookingTime;
  @override
  String get serviceName;
  @override
  double get totalAmount;
  @override
  String get status;
  @override
  String get createdAt;
  @override
  String get updatedAt;

  /// Create a copy of BookingsModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BookingsModelImplCopyWith<_$BookingsModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

BookingsResponse _$BookingsResponseFromJson(Map<String, dynamic> json) {
  return _BookingsResponse.fromJson(json);
}

/// @nodoc
mixin _$BookingsResponse {
  List<BookingsModel> get data => throw _privateConstructorUsedError;
  Map<String, dynamic> get pagination => throw _privateConstructorUsedError;

  /// Serializes this BookingsResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of BookingsResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BookingsResponseCopyWith<BookingsResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BookingsResponseCopyWith<$Res> {
  factory $BookingsResponseCopyWith(
          BookingsResponse value, $Res Function(BookingsResponse) then) =
      _$BookingsResponseCopyWithImpl<$Res, BookingsResponse>;
  @useResult
  $Res call({List<BookingsModel> data, Map<String, dynamic> pagination});
}

/// @nodoc
class _$BookingsResponseCopyWithImpl<$Res, $Val extends BookingsResponse>
    implements $BookingsResponseCopyWith<$Res> {
  _$BookingsResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BookingsResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = null,
    Object? pagination = null,
  }) {
    return _then(_value.copyWith(
      data: null == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as List<BookingsModel>,
      pagination: null == pagination
          ? _value.pagination
          : pagination // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$BookingsResponseImplCopyWith<$Res>
    implements $BookingsResponseCopyWith<$Res> {
  factory _$$BookingsResponseImplCopyWith(_$BookingsResponseImpl value,
          $Res Function(_$BookingsResponseImpl) then) =
      __$$BookingsResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<BookingsModel> data, Map<String, dynamic> pagination});
}

/// @nodoc
class __$$BookingsResponseImplCopyWithImpl<$Res>
    extends _$BookingsResponseCopyWithImpl<$Res, _$BookingsResponseImpl>
    implements _$$BookingsResponseImplCopyWith<$Res> {
  __$$BookingsResponseImplCopyWithImpl(_$BookingsResponseImpl _value,
      $Res Function(_$BookingsResponseImpl) _then)
      : super(_value, _then);

  /// Create a copy of BookingsResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = null,
    Object? pagination = null,
  }) {
    return _then(_$BookingsResponseImpl(
      data: null == data
          ? _value._data
          : data // ignore: cast_nullable_to_non_nullable
              as List<BookingsModel>,
      pagination: null == pagination
          ? _value._pagination
          : pagination // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$BookingsResponseImpl implements _BookingsResponse {
  const _$BookingsResponseImpl(
      {required final List<BookingsModel> data,
      required final Map<String, dynamic> pagination})
      : _data = data,
        _pagination = pagination;

  factory _$BookingsResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$BookingsResponseImplFromJson(json);

  final List<BookingsModel> _data;
  @override
  List<BookingsModel> get data {
    if (_data is EqualUnmodifiableListView) return _data;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_data);
  }

  final Map<String, dynamic> _pagination;
  @override
  Map<String, dynamic> get pagination {
    if (_pagination is EqualUnmodifiableMapView) return _pagination;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_pagination);
  }

  @override
  String toString() {
    return 'BookingsResponse(data: $data, pagination: $pagination)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BookingsResponseImpl &&
            const DeepCollectionEquality().equals(other._data, _data) &&
            const DeepCollectionEquality()
                .equals(other._pagination, _pagination));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_data),
      const DeepCollectionEquality().hash(_pagination));

  /// Create a copy of BookingsResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BookingsResponseImplCopyWith<_$BookingsResponseImpl> get copyWith =>
      __$$BookingsResponseImplCopyWithImpl<_$BookingsResponseImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BookingsResponseImplToJson(
      this,
    );
  }
}

abstract class _BookingsResponse implements BookingsResponse {
  const factory _BookingsResponse(
      {required final List<BookingsModel> data,
      required final Map<String, dynamic> pagination}) = _$BookingsResponseImpl;

  factory _BookingsResponse.fromJson(Map<String, dynamic> json) =
      _$BookingsResponseImpl.fromJson;

  @override
  List<BookingsModel> get data;
  @override
  Map<String, dynamic> get pagination;

  /// Create a copy of BookingsResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BookingsResponseImplCopyWith<_$BookingsResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
