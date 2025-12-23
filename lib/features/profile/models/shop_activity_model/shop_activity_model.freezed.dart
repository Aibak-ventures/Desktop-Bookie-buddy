// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'shop_activity_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ShopActivityModel _$ShopActivityModelFromJson(Map<String, dynamic> json) {
  return _ShopActivityModel.fromJson(json);
}

/// @nodoc
mixin _$ShopActivityModel {
  int get id => throw _privateConstructorUsedError;
  String get action => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;
  @JsonKey(name: 'user_name')
  String get userName => throw _privateConstructorUsedError;
  @JsonKey(name: 'user_id')
  int get userId => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  String get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'booking_id')
  int? get bookingId => throw _privateConstructorUsedError;
  @JsonKey(name: 'sale_id')
  int? get saleId => throw _privateConstructorUsedError;
  @JsonKey(name: 'client_id')
  int? get clientId => throw _privateConstructorUsedError;
  @JsonKey(name: 'product_id')
  int? get productId => throw _privateConstructorUsedError;
  @JsonKey(name: 'expense_id')
  int? get expenseId => throw _privateConstructorUsedError;
  Map<String, dynamic> get metadata => throw _privateConstructorUsedError;

  /// Serializes this ShopActivityModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ShopActivityModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ShopActivityModelCopyWith<ShopActivityModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ShopActivityModelCopyWith<$Res> {
  factory $ShopActivityModelCopyWith(
          ShopActivityModel value, $Res Function(ShopActivityModel) then) =
      _$ShopActivityModelCopyWithImpl<$Res, ShopActivityModel>;
  @useResult
  $Res call(
      {int id,
      String action,
      String message,
      @JsonKey(name: 'user_name') String userName,
      @JsonKey(name: 'user_id') int userId,
      @JsonKey(name: 'created_at') String createdAt,
      @JsonKey(name: 'booking_id') int? bookingId,
      @JsonKey(name: 'sale_id') int? saleId,
      @JsonKey(name: 'client_id') int? clientId,
      @JsonKey(name: 'product_id') int? productId,
      @JsonKey(name: 'expense_id') int? expenseId,
      Map<String, dynamic> metadata});
}

/// @nodoc
class _$ShopActivityModelCopyWithImpl<$Res, $Val extends ShopActivityModel>
    implements $ShopActivityModelCopyWith<$Res> {
  _$ShopActivityModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ShopActivityModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? action = null,
    Object? message = null,
    Object? userName = null,
    Object? userId = null,
    Object? createdAt = null,
    Object? bookingId = freezed,
    Object? saleId = freezed,
    Object? clientId = freezed,
    Object? productId = freezed,
    Object? expenseId = freezed,
    Object? metadata = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      action: null == action
          ? _value.action
          : action // ignore: cast_nullable_to_non_nullable
              as String,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      userName: null == userName
          ? _value.userName
          : userName // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as int,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String,
      bookingId: freezed == bookingId
          ? _value.bookingId
          : bookingId // ignore: cast_nullable_to_non_nullable
              as int?,
      saleId: freezed == saleId
          ? _value.saleId
          : saleId // ignore: cast_nullable_to_non_nullable
              as int?,
      clientId: freezed == clientId
          ? _value.clientId
          : clientId // ignore: cast_nullable_to_non_nullable
              as int?,
      productId: freezed == productId
          ? _value.productId
          : productId // ignore: cast_nullable_to_non_nullable
              as int?,
      expenseId: freezed == expenseId
          ? _value.expenseId
          : expenseId // ignore: cast_nullable_to_non_nullable
              as int?,
      metadata: null == metadata
          ? _value.metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ShopActivityModelImplCopyWith<$Res>
    implements $ShopActivityModelCopyWith<$Res> {
  factory _$$ShopActivityModelImplCopyWith(_$ShopActivityModelImpl value,
          $Res Function(_$ShopActivityModelImpl) then) =
      __$$ShopActivityModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      String action,
      String message,
      @JsonKey(name: 'user_name') String userName,
      @JsonKey(name: 'user_id') int userId,
      @JsonKey(name: 'created_at') String createdAt,
      @JsonKey(name: 'booking_id') int? bookingId,
      @JsonKey(name: 'sale_id') int? saleId,
      @JsonKey(name: 'client_id') int? clientId,
      @JsonKey(name: 'product_id') int? productId,
      @JsonKey(name: 'expense_id') int? expenseId,
      Map<String, dynamic> metadata});
}

/// @nodoc
class __$$ShopActivityModelImplCopyWithImpl<$Res>
    extends _$ShopActivityModelCopyWithImpl<$Res, _$ShopActivityModelImpl>
    implements _$$ShopActivityModelImplCopyWith<$Res> {
  __$$ShopActivityModelImplCopyWithImpl(_$ShopActivityModelImpl _value,
      $Res Function(_$ShopActivityModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of ShopActivityModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? action = null,
    Object? message = null,
    Object? userName = null,
    Object? userId = null,
    Object? createdAt = null,
    Object? bookingId = freezed,
    Object? saleId = freezed,
    Object? clientId = freezed,
    Object? productId = freezed,
    Object? expenseId = freezed,
    Object? metadata = null,
  }) {
    return _then(_$ShopActivityModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      action: null == action
          ? _value.action
          : action // ignore: cast_nullable_to_non_nullable
              as String,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      userName: null == userName
          ? _value.userName
          : userName // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as int,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String,
      bookingId: freezed == bookingId
          ? _value.bookingId
          : bookingId // ignore: cast_nullable_to_non_nullable
              as int?,
      saleId: freezed == saleId
          ? _value.saleId
          : saleId // ignore: cast_nullable_to_non_nullable
              as int?,
      clientId: freezed == clientId
          ? _value.clientId
          : clientId // ignore: cast_nullable_to_non_nullable
              as int?,
      productId: freezed == productId
          ? _value.productId
          : productId // ignore: cast_nullable_to_non_nullable
              as int?,
      expenseId: freezed == expenseId
          ? _value.expenseId
          : expenseId // ignore: cast_nullable_to_non_nullable
              as int?,
      metadata: null == metadata
          ? _value._metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ShopActivityModelImpl implements _ShopActivityModel {
  const _$ShopActivityModelImpl(
      {required this.id,
      required this.action,
      required this.message,
      @JsonKey(name: 'user_name') required this.userName,
      @JsonKey(name: 'user_id') required this.userId,
      @JsonKey(name: 'created_at') required this.createdAt,
      @JsonKey(name: 'booking_id') this.bookingId,
      @JsonKey(name: 'sale_id') this.saleId,
      @JsonKey(name: 'client_id') this.clientId,
      @JsonKey(name: 'product_id') this.productId,
      @JsonKey(name: 'expense_id') this.expenseId,
      final Map<String, dynamic> metadata = const {}})
      : _metadata = metadata;

  factory _$ShopActivityModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$ShopActivityModelImplFromJson(json);

  @override
  final int id;
  @override
  final String action;
  @override
  final String message;
  @override
  @JsonKey(name: 'user_name')
  final String userName;
  @override
  @JsonKey(name: 'user_id')
  final int userId;
  @override
  @JsonKey(name: 'created_at')
  final String createdAt;
  @override
  @JsonKey(name: 'booking_id')
  final int? bookingId;
  @override
  @JsonKey(name: 'sale_id')
  final int? saleId;
  @override
  @JsonKey(name: 'client_id')
  final int? clientId;
  @override
  @JsonKey(name: 'product_id')
  final int? productId;
  @override
  @JsonKey(name: 'expense_id')
  final int? expenseId;
  final Map<String, dynamic> _metadata;
  @override
  @JsonKey()
  Map<String, dynamic> get metadata {
    if (_metadata is EqualUnmodifiableMapView) return _metadata;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_metadata);
  }

  @override
  String toString() {
    return 'ShopActivityModel(id: $id, action: $action, message: $message, userName: $userName, userId: $userId, createdAt: $createdAt, bookingId: $bookingId, saleId: $saleId, clientId: $clientId, productId: $productId, expenseId: $expenseId, metadata: $metadata)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ShopActivityModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.action, action) || other.action == action) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.userName, userName) ||
                other.userName == userName) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.bookingId, bookingId) ||
                other.bookingId == bookingId) &&
            (identical(other.saleId, saleId) || other.saleId == saleId) &&
            (identical(other.clientId, clientId) ||
                other.clientId == clientId) &&
            (identical(other.productId, productId) ||
                other.productId == productId) &&
            (identical(other.expenseId, expenseId) ||
                other.expenseId == expenseId) &&
            const DeepCollectionEquality().equals(other._metadata, _metadata));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      action,
      message,
      userName,
      userId,
      createdAt,
      bookingId,
      saleId,
      clientId,
      productId,
      expenseId,
      const DeepCollectionEquality().hash(_metadata));

  /// Create a copy of ShopActivityModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ShopActivityModelImplCopyWith<_$ShopActivityModelImpl> get copyWith =>
      __$$ShopActivityModelImplCopyWithImpl<_$ShopActivityModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ShopActivityModelImplToJson(
      this,
    );
  }
}

abstract class _ShopActivityModel implements ShopActivityModel {
  const factory _ShopActivityModel(
      {required final int id,
      required final String action,
      required final String message,
      @JsonKey(name: 'user_name') required final String userName,
      @JsonKey(name: 'user_id') required final int userId,
      @JsonKey(name: 'created_at') required final String createdAt,
      @JsonKey(name: 'booking_id') final int? bookingId,
      @JsonKey(name: 'sale_id') final int? saleId,
      @JsonKey(name: 'client_id') final int? clientId,
      @JsonKey(name: 'product_id') final int? productId,
      @JsonKey(name: 'expense_id') final int? expenseId,
      final Map<String, dynamic> metadata}) = _$ShopActivityModelImpl;

  factory _ShopActivityModel.fromJson(Map<String, dynamic> json) =
      _$ShopActivityModelImpl.fromJson;

  @override
  int get id;
  @override
  String get action;
  @override
  String get message;
  @override
  @JsonKey(name: 'user_name')
  String get userName;
  @override
  @JsonKey(name: 'user_id')
  int get userId;
  @override
  @JsonKey(name: 'created_at')
  String get createdAt;
  @override
  @JsonKey(name: 'booking_id')
  int? get bookingId;
  @override
  @JsonKey(name: 'sale_id')
  int? get saleId;
  @override
  @JsonKey(name: 'client_id')
  int? get clientId;
  @override
  @JsonKey(name: 'product_id')
  int? get productId;
  @override
  @JsonKey(name: 'expense_id')
  int? get expenseId;
  @override
  Map<String, dynamic> get metadata;

  /// Create a copy of ShopActivityModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ShopActivityModelImplCopyWith<_$ShopActivityModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
