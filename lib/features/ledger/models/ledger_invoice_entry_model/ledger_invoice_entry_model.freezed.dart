// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ledger_invoice_entry_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

LedgerInvoiceEntryModel _$LedgerInvoiceEntryModelFromJson(
  Map<String, dynamic> json,
) {
  return _LedgerInvoiceEntryModel.fromJson(json);
}

/// @nodoc
mixin _$LedgerInvoiceEntryModel {
  @JsonKey(name: 'type', fromJson: LedgerType.fromString)
  LedgerType get type => throw _privateConstructorUsedError;
  String get date => throw _privateConstructorUsedError;
  @JsonKey(name: 'user', defaultValue: 'Unknown')
  String get user => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  int get amount => throw _privateConstructorUsedError;
  @JsonKey(name: 'items', defaultValue: const <String>[])
  List<String> get products => throw _privateConstructorUsedError;

  /// Serializes this LedgerInvoiceEntryModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of LedgerInvoiceEntryModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $LedgerInvoiceEntryModelCopyWith<LedgerInvoiceEntryModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LedgerInvoiceEntryModelCopyWith<$Res> {
  factory $LedgerInvoiceEntryModelCopyWith(
    LedgerInvoiceEntryModel value,
    $Res Function(LedgerInvoiceEntryModel) then,
  ) = _$LedgerInvoiceEntryModelCopyWithImpl<$Res, LedgerInvoiceEntryModel>;
  @useResult
  $Res call({
    @JsonKey(name: 'type', fromJson: LedgerType.fromString) LedgerType type,
    String date,
    @JsonKey(name: 'user', defaultValue: 'Unknown') String user,
    String description,
    int amount,
    @JsonKey(name: 'items', defaultValue: const <String>[])
    List<String> products,
  });
}

/// @nodoc
class _$LedgerInvoiceEntryModelCopyWithImpl<
  $Res,
  $Val extends LedgerInvoiceEntryModel
>
    implements $LedgerInvoiceEntryModelCopyWith<$Res> {
  _$LedgerInvoiceEntryModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of LedgerInvoiceEntryModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? date = null,
    Object? user = null,
    Object? description = null,
    Object? amount = null,
    Object? products = null,
  }) {
    return _then(
      _value.copyWith(
            type: null == type
                ? _value.type
                : type // ignore: cast_nullable_to_non_nullable
                      as LedgerType,
            date: null == date
                ? _value.date
                : date // ignore: cast_nullable_to_non_nullable
                      as String,
            user: null == user
                ? _value.user
                : user // ignore: cast_nullable_to_non_nullable
                      as String,
            description: null == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String,
            amount: null == amount
                ? _value.amount
                : amount // ignore: cast_nullable_to_non_nullable
                      as int,
            products: null == products
                ? _value.products
                : products // ignore: cast_nullable_to_non_nullable
                      as List<String>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$LedgerInvoiceEntryModelImplCopyWith<$Res>
    implements $LedgerInvoiceEntryModelCopyWith<$Res> {
  factory _$$LedgerInvoiceEntryModelImplCopyWith(
    _$LedgerInvoiceEntryModelImpl value,
    $Res Function(_$LedgerInvoiceEntryModelImpl) then,
  ) = __$$LedgerInvoiceEntryModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'type', fromJson: LedgerType.fromString) LedgerType type,
    String date,
    @JsonKey(name: 'user', defaultValue: 'Unknown') String user,
    String description,
    int amount,
    @JsonKey(name: 'items', defaultValue: const <String>[])
    List<String> products,
  });
}

/// @nodoc
class __$$LedgerInvoiceEntryModelImplCopyWithImpl<$Res>
    extends
        _$LedgerInvoiceEntryModelCopyWithImpl<
          $Res,
          _$LedgerInvoiceEntryModelImpl
        >
    implements _$$LedgerInvoiceEntryModelImplCopyWith<$Res> {
  __$$LedgerInvoiceEntryModelImplCopyWithImpl(
    _$LedgerInvoiceEntryModelImpl _value,
    $Res Function(_$LedgerInvoiceEntryModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of LedgerInvoiceEntryModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? date = null,
    Object? user = null,
    Object? description = null,
    Object? amount = null,
    Object? products = null,
  }) {
    return _then(
      _$LedgerInvoiceEntryModelImpl(
        type: null == type
            ? _value.type
            : type // ignore: cast_nullable_to_non_nullable
                  as LedgerType,
        date: null == date
            ? _value.date
            : date // ignore: cast_nullable_to_non_nullable
                  as String,
        user: null == user
            ? _value.user
            : user // ignore: cast_nullable_to_non_nullable
                  as String,
        description: null == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String,
        amount: null == amount
            ? _value.amount
            : amount // ignore: cast_nullable_to_non_nullable
                  as int,
        products: null == products
            ? _value._products
            : products // ignore: cast_nullable_to_non_nullable
                  as List<String>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$LedgerInvoiceEntryModelImpl implements _LedgerInvoiceEntryModel {
  const _$LedgerInvoiceEntryModelImpl({
    @JsonKey(name: 'type', fromJson: LedgerType.fromString) required this.type,
    required this.date,
    @JsonKey(name: 'user', defaultValue: 'Unknown') required this.user,
    required this.description,
    required this.amount,
    @JsonKey(name: 'items', defaultValue: const <String>[])
    required final List<String> products,
  }) : _products = products;

  factory _$LedgerInvoiceEntryModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$LedgerInvoiceEntryModelImplFromJson(json);

  @override
  @JsonKey(name: 'type', fromJson: LedgerType.fromString)
  final LedgerType type;
  @override
  final String date;
  @override
  @JsonKey(name: 'user', defaultValue: 'Unknown')
  final String user;
  @override
  final String description;
  @override
  final int amount;
  final List<String> _products;
  @override
  @JsonKey(name: 'items', defaultValue: const <String>[])
  List<String> get products {
    if (_products is EqualUnmodifiableListView) return _products;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_products);
  }

  @override
  String toString() {
    return 'LedgerInvoiceEntryModel(type: $type, date: $date, user: $user, description: $description, amount: $amount, products: $products)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LedgerInvoiceEntryModelImpl &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.user, user) || other.user == user) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            const DeepCollectionEquality().equals(other._products, _products));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    type,
    date,
    user,
    description,
    amount,
    const DeepCollectionEquality().hash(_products),
  );

  /// Create a copy of LedgerInvoiceEntryModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LedgerInvoiceEntryModelImplCopyWith<_$LedgerInvoiceEntryModelImpl>
  get copyWith =>
      __$$LedgerInvoiceEntryModelImplCopyWithImpl<
        _$LedgerInvoiceEntryModelImpl
      >(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$LedgerInvoiceEntryModelImplToJson(this);
  }
}

abstract class _LedgerInvoiceEntryModel implements LedgerInvoiceEntryModel {
  const factory _LedgerInvoiceEntryModel({
    @JsonKey(name: 'type', fromJson: LedgerType.fromString)
    required final LedgerType type,
    required final String date,
    @JsonKey(name: 'user', defaultValue: 'Unknown') required final String user,
    required final String description,
    required final int amount,
    @JsonKey(name: 'items', defaultValue: const <String>[])
    required final List<String> products,
  }) = _$LedgerInvoiceEntryModelImpl;

  factory _LedgerInvoiceEntryModel.fromJson(Map<String, dynamic> json) =
      _$LedgerInvoiceEntryModelImpl.fromJson;

  @override
  @JsonKey(name: 'type', fromJson: LedgerType.fromString)
  LedgerType get type;
  @override
  String get date;
  @override
  @JsonKey(name: 'user', defaultValue: 'Unknown')
  String get user;
  @override
  String get description;
  @override
  int get amount;
  @override
  @JsonKey(name: 'items', defaultValue: const <String>[])
  List<String> get products;

  /// Create a copy of LedgerInvoiceEntryModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LedgerInvoiceEntryModelImplCopyWith<_$LedgerInvoiceEntryModelImpl>
  get copyWith => throw _privateConstructorUsedError;
}
