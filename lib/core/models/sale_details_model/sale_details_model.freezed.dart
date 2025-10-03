// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sale_details_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

SaleDetailsModel _$SaleDetailsModelFromJson(Map<String, dynamic> json) {
  return _SaleDetailsModel.fromJson(json);
}

/// @nodoc
mixin _$SaleDetailsModel {
  int get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'client')
  ClientModel get client => throw _privateConstructorUsedError;
  @JsonKey(name: 'address', defaultValue: '')
  String get address => throw _privateConstructorUsedError;
  @JsonKey(name: 'description')
  String get description => throw _privateConstructorUsedError;
  @JsonKey(name: 'sale_date')
  String get saleDate => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at', defaultValue: '')
  String get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'total_amount')
  int get totalAmount => throw _privateConstructorUsedError;
  @JsonKey(name: 'discount')
  int get discountAmount => throw _privateConstructorUsedError;
  @JsonKey(name: 'paid_amount')
  int get paidAmount => throw _privateConstructorUsedError;
  @JsonKey(name: 'shop_sale_id', defaultValue: '')
  String get invoiceId => throw _privateConstructorUsedError;
  @JsonKey(name: 'balance_due')
  int get balanceDueAmount => throw _privateConstructorUsedError;
  @JsonKey(name: 'items')
  List<ProductSaleInfoModel> get products => throw _privateConstructorUsedError;
  @JsonKey(
    name: 'method',
    fromJson: PaymentMethod.fromString,
    toJson: PaymentMethod.toJson,
    readValue: _paymentMethodReadValue,
  )
  PaymentMethod get paymentMethod => throw _privateConstructorUsedError;
  @JsonKey(name: 'staff_id')
  int? get staffId => throw _privateConstructorUsedError;
  @JsonKey(name: 'staff_name')
  String? get staffName => throw _privateConstructorUsedError;

  /// Serializes this SaleDetailsModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SaleDetailsModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SaleDetailsModelCopyWith<SaleDetailsModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SaleDetailsModelCopyWith<$Res> {
  factory $SaleDetailsModelCopyWith(
    SaleDetailsModel value,
    $Res Function(SaleDetailsModel) then,
  ) = _$SaleDetailsModelCopyWithImpl<$Res, SaleDetailsModel>;
  @useResult
  $Res call({
    int id,
    @JsonKey(name: 'client') ClientModel client,
    @JsonKey(name: 'address', defaultValue: '') String address,
    @JsonKey(name: 'description') String description,
    @JsonKey(name: 'sale_date') String saleDate,
    @JsonKey(name: 'created_at', defaultValue: '') String createdAt,
    @JsonKey(name: 'total_amount') int totalAmount,
    @JsonKey(name: 'discount') int discountAmount,
    @JsonKey(name: 'paid_amount') int paidAmount,
    @JsonKey(name: 'shop_sale_id', defaultValue: '') String invoiceId,
    @JsonKey(name: 'balance_due') int balanceDueAmount,
    @JsonKey(name: 'items') List<ProductSaleInfoModel> products,
    @JsonKey(
      name: 'method',
      fromJson: PaymentMethod.fromString,
      toJson: PaymentMethod.toJson,
      readValue: _paymentMethodReadValue,
    )
    PaymentMethod paymentMethod,
    @JsonKey(name: 'staff_id') int? staffId,
    @JsonKey(name: 'staff_name') String? staffName,
  });

  $ClientModelCopyWith<$Res> get client;
}

/// @nodoc
class _$SaleDetailsModelCopyWithImpl<$Res, $Val extends SaleDetailsModel>
    implements $SaleDetailsModelCopyWith<$Res> {
  _$SaleDetailsModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SaleDetailsModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? client = null,
    Object? address = null,
    Object? description = null,
    Object? saleDate = null,
    Object? createdAt = null,
    Object? totalAmount = null,
    Object? discountAmount = null,
    Object? paidAmount = null,
    Object? invoiceId = null,
    Object? balanceDueAmount = null,
    Object? products = null,
    Object? paymentMethod = null,
    Object? staffId = freezed,
    Object? staffName = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as int,
            client: null == client
                ? _value.client
                : client // ignore: cast_nullable_to_non_nullable
                      as ClientModel,
            address: null == address
                ? _value.address
                : address // ignore: cast_nullable_to_non_nullable
                      as String,
            description: null == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String,
            saleDate: null == saleDate
                ? _value.saleDate
                : saleDate // ignore: cast_nullable_to_non_nullable
                      as String,
            createdAt: null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as String,
            totalAmount: null == totalAmount
                ? _value.totalAmount
                : totalAmount // ignore: cast_nullable_to_non_nullable
                      as int,
            discountAmount: null == discountAmount
                ? _value.discountAmount
                : discountAmount // ignore: cast_nullable_to_non_nullable
                      as int,
            paidAmount: null == paidAmount
                ? _value.paidAmount
                : paidAmount // ignore: cast_nullable_to_non_nullable
                      as int,
            invoiceId: null == invoiceId
                ? _value.invoiceId
                : invoiceId // ignore: cast_nullable_to_non_nullable
                      as String,
            balanceDueAmount: null == balanceDueAmount
                ? _value.balanceDueAmount
                : balanceDueAmount // ignore: cast_nullable_to_non_nullable
                      as int,
            products: null == products
                ? _value.products
                : products // ignore: cast_nullable_to_non_nullable
                      as List<ProductSaleInfoModel>,
            paymentMethod: null == paymentMethod
                ? _value.paymentMethod
                : paymentMethod // ignore: cast_nullable_to_non_nullable
                      as PaymentMethod,
            staffId: freezed == staffId
                ? _value.staffId
                : staffId // ignore: cast_nullable_to_non_nullable
                      as int?,
            staffName: freezed == staffName
                ? _value.staffName
                : staffName // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }

  /// Create a copy of SaleDetailsModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ClientModelCopyWith<$Res> get client {
    return $ClientModelCopyWith<$Res>(_value.client, (value) {
      return _then(_value.copyWith(client: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$SaleDetailsModelImplCopyWith<$Res>
    implements $SaleDetailsModelCopyWith<$Res> {
  factory _$$SaleDetailsModelImplCopyWith(
    _$SaleDetailsModelImpl value,
    $Res Function(_$SaleDetailsModelImpl) then,
  ) = __$$SaleDetailsModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int id,
    @JsonKey(name: 'client') ClientModel client,
    @JsonKey(name: 'address', defaultValue: '') String address,
    @JsonKey(name: 'description') String description,
    @JsonKey(name: 'sale_date') String saleDate,
    @JsonKey(name: 'created_at', defaultValue: '') String createdAt,
    @JsonKey(name: 'total_amount') int totalAmount,
    @JsonKey(name: 'discount') int discountAmount,
    @JsonKey(name: 'paid_amount') int paidAmount,
    @JsonKey(name: 'shop_sale_id', defaultValue: '') String invoiceId,
    @JsonKey(name: 'balance_due') int balanceDueAmount,
    @JsonKey(name: 'items') List<ProductSaleInfoModel> products,
    @JsonKey(
      name: 'method',
      fromJson: PaymentMethod.fromString,
      toJson: PaymentMethod.toJson,
      readValue: _paymentMethodReadValue,
    )
    PaymentMethod paymentMethod,
    @JsonKey(name: 'staff_id') int? staffId,
    @JsonKey(name: 'staff_name') String? staffName,
  });

  @override
  $ClientModelCopyWith<$Res> get client;
}

/// @nodoc
class __$$SaleDetailsModelImplCopyWithImpl<$Res>
    extends _$SaleDetailsModelCopyWithImpl<$Res, _$SaleDetailsModelImpl>
    implements _$$SaleDetailsModelImplCopyWith<$Res> {
  __$$SaleDetailsModelImplCopyWithImpl(
    _$SaleDetailsModelImpl _value,
    $Res Function(_$SaleDetailsModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SaleDetailsModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? client = null,
    Object? address = null,
    Object? description = null,
    Object? saleDate = null,
    Object? createdAt = null,
    Object? totalAmount = null,
    Object? discountAmount = null,
    Object? paidAmount = null,
    Object? invoiceId = null,
    Object? balanceDueAmount = null,
    Object? products = null,
    Object? paymentMethod = null,
    Object? staffId = freezed,
    Object? staffName = freezed,
  }) {
    return _then(
      _$SaleDetailsModelImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int,
        client: null == client
            ? _value.client
            : client // ignore: cast_nullable_to_non_nullable
                  as ClientModel,
        address: null == address
            ? _value.address
            : address // ignore: cast_nullable_to_non_nullable
                  as String,
        description: null == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String,
        saleDate: null == saleDate
            ? _value.saleDate
            : saleDate // ignore: cast_nullable_to_non_nullable
                  as String,
        createdAt: null == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as String,
        totalAmount: null == totalAmount
            ? _value.totalAmount
            : totalAmount // ignore: cast_nullable_to_non_nullable
                  as int,
        discountAmount: null == discountAmount
            ? _value.discountAmount
            : discountAmount // ignore: cast_nullable_to_non_nullable
                  as int,
        paidAmount: null == paidAmount
            ? _value.paidAmount
            : paidAmount // ignore: cast_nullable_to_non_nullable
                  as int,
        invoiceId: null == invoiceId
            ? _value.invoiceId
            : invoiceId // ignore: cast_nullable_to_non_nullable
                  as String,
        balanceDueAmount: null == balanceDueAmount
            ? _value.balanceDueAmount
            : balanceDueAmount // ignore: cast_nullable_to_non_nullable
                  as int,
        products: null == products
            ? _value._products
            : products // ignore: cast_nullable_to_non_nullable
                  as List<ProductSaleInfoModel>,
        paymentMethod: null == paymentMethod
            ? _value.paymentMethod
            : paymentMethod // ignore: cast_nullable_to_non_nullable
                  as PaymentMethod,
        staffId: freezed == staffId
            ? _value.staffId
            : staffId // ignore: cast_nullable_to_non_nullable
                  as int?,
        staffName: freezed == staffName
            ? _value.staffName
            : staffName // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$SaleDetailsModelImpl implements _SaleDetailsModel {
  const _$SaleDetailsModelImpl({
    required this.id,
    @JsonKey(name: 'client') required this.client,
    @JsonKey(name: 'address', defaultValue: '') required this.address,
    @JsonKey(name: 'description') required this.description,
    @JsonKey(name: 'sale_date') required this.saleDate,
    @JsonKey(name: 'created_at', defaultValue: '') required this.createdAt,
    @JsonKey(name: 'total_amount') required this.totalAmount,
    @JsonKey(name: 'discount') required this.discountAmount,
    @JsonKey(name: 'paid_amount') required this.paidAmount,
    @JsonKey(name: 'shop_sale_id', defaultValue: '') required this.invoiceId,
    @JsonKey(name: 'balance_due') required this.balanceDueAmount,
    @JsonKey(name: 'items') required final List<ProductSaleInfoModel> products,
    @JsonKey(
      name: 'method',
      fromJson: PaymentMethod.fromString,
      toJson: PaymentMethod.toJson,
      readValue: _paymentMethodReadValue,
    )
    this.paymentMethod = PaymentMethod.cash,
    @JsonKey(name: 'staff_id') this.staffId,
    @JsonKey(name: 'staff_name') this.staffName,
  }) : _products = products;

  factory _$SaleDetailsModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$SaleDetailsModelImplFromJson(json);

  @override
  final int id;
  @override
  @JsonKey(name: 'client')
  final ClientModel client;
  @override
  @JsonKey(name: 'address', defaultValue: '')
  final String address;
  @override
  @JsonKey(name: 'description')
  final String description;
  @override
  @JsonKey(name: 'sale_date')
  final String saleDate;
  @override
  @JsonKey(name: 'created_at', defaultValue: '')
  final String createdAt;
  @override
  @JsonKey(name: 'total_amount')
  final int totalAmount;
  @override
  @JsonKey(name: 'discount')
  final int discountAmount;
  @override
  @JsonKey(name: 'paid_amount')
  final int paidAmount;
  @override
  @JsonKey(name: 'shop_sale_id', defaultValue: '')
  final String invoiceId;
  @override
  @JsonKey(name: 'balance_due')
  final int balanceDueAmount;
  final List<ProductSaleInfoModel> _products;
  @override
  @JsonKey(name: 'items')
  List<ProductSaleInfoModel> get products {
    if (_products is EqualUnmodifiableListView) return _products;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_products);
  }

  @override
  @JsonKey(
    name: 'method',
    fromJson: PaymentMethod.fromString,
    toJson: PaymentMethod.toJson,
    readValue: _paymentMethodReadValue,
  )
  final PaymentMethod paymentMethod;
  @override
  @JsonKey(name: 'staff_id')
  final int? staffId;
  @override
  @JsonKey(name: 'staff_name')
  final String? staffName;

  @override
  String toString() {
    return 'SaleDetailsModel(id: $id, client: $client, address: $address, description: $description, saleDate: $saleDate, createdAt: $createdAt, totalAmount: $totalAmount, discountAmount: $discountAmount, paidAmount: $paidAmount, invoiceId: $invoiceId, balanceDueAmount: $balanceDueAmount, products: $products, paymentMethod: $paymentMethod, staffId: $staffId, staffName: $staffName)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SaleDetailsModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.client, client) || other.client == client) &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.saleDate, saleDate) ||
                other.saleDate == saleDate) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.totalAmount, totalAmount) ||
                other.totalAmount == totalAmount) &&
            (identical(other.discountAmount, discountAmount) ||
                other.discountAmount == discountAmount) &&
            (identical(other.paidAmount, paidAmount) ||
                other.paidAmount == paidAmount) &&
            (identical(other.invoiceId, invoiceId) ||
                other.invoiceId == invoiceId) &&
            (identical(other.balanceDueAmount, balanceDueAmount) ||
                other.balanceDueAmount == balanceDueAmount) &&
            const DeepCollectionEquality().equals(other._products, _products) &&
            (identical(other.paymentMethod, paymentMethod) ||
                other.paymentMethod == paymentMethod) &&
            (identical(other.staffId, staffId) || other.staffId == staffId) &&
            (identical(other.staffName, staffName) ||
                other.staffName == staffName));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    client,
    address,
    description,
    saleDate,
    createdAt,
    totalAmount,
    discountAmount,
    paidAmount,
    invoiceId,
    balanceDueAmount,
    const DeepCollectionEquality().hash(_products),
    paymentMethod,
    staffId,
    staffName,
  );

  /// Create a copy of SaleDetailsModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SaleDetailsModelImplCopyWith<_$SaleDetailsModelImpl> get copyWith =>
      __$$SaleDetailsModelImplCopyWithImpl<_$SaleDetailsModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$SaleDetailsModelImplToJson(this);
  }
}

abstract class _SaleDetailsModel implements SaleDetailsModel {
  const factory _SaleDetailsModel({
    required final int id,
    @JsonKey(name: 'client') required final ClientModel client,
    @JsonKey(name: 'address', defaultValue: '') required final String address,
    @JsonKey(name: 'description') required final String description,
    @JsonKey(name: 'sale_date') required final String saleDate,
    @JsonKey(name: 'created_at', defaultValue: '')
    required final String createdAt,
    @JsonKey(name: 'total_amount') required final int totalAmount,
    @JsonKey(name: 'discount') required final int discountAmount,
    @JsonKey(name: 'paid_amount') required final int paidAmount,
    @JsonKey(name: 'shop_sale_id', defaultValue: '')
    required final String invoiceId,
    @JsonKey(name: 'balance_due') required final int balanceDueAmount,
    @JsonKey(name: 'items') required final List<ProductSaleInfoModel> products,
    @JsonKey(
      name: 'method',
      fromJson: PaymentMethod.fromString,
      toJson: PaymentMethod.toJson,
      readValue: _paymentMethodReadValue,
    )
    final PaymentMethod paymentMethod,
    @JsonKey(name: 'staff_id') final int? staffId,
    @JsonKey(name: 'staff_name') final String? staffName,
  }) = _$SaleDetailsModelImpl;

  factory _SaleDetailsModel.fromJson(Map<String, dynamic> json) =
      _$SaleDetailsModelImpl.fromJson;

  @override
  int get id;
  @override
  @JsonKey(name: 'client')
  ClientModel get client;
  @override
  @JsonKey(name: 'address', defaultValue: '')
  String get address;
  @override
  @JsonKey(name: 'description')
  String get description;
  @override
  @JsonKey(name: 'sale_date')
  String get saleDate;
  @override
  @JsonKey(name: 'created_at', defaultValue: '')
  String get createdAt;
  @override
  @JsonKey(name: 'total_amount')
  int get totalAmount;
  @override
  @JsonKey(name: 'discount')
  int get discountAmount;
  @override
  @JsonKey(name: 'paid_amount')
  int get paidAmount;
  @override
  @JsonKey(name: 'shop_sale_id', defaultValue: '')
  String get invoiceId;
  @override
  @JsonKey(name: 'balance_due')
  int get balanceDueAmount;
  @override
  @JsonKey(name: 'items')
  List<ProductSaleInfoModel> get products;
  @override
  @JsonKey(
    name: 'method',
    fromJson: PaymentMethod.fromString,
    toJson: PaymentMethod.toJson,
    readValue: _paymentMethodReadValue,
  )
  PaymentMethod get paymentMethod;
  @override
  @JsonKey(name: 'staff_id')
  int? get staffId;
  @override
  @JsonKey(name: 'staff_name')
  String? get staffName;

  /// Create a copy of SaleDetailsModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SaleDetailsModelImplCopyWith<_$SaleDetailsModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ProductSaleInfoModel _$ProductSaleInfoModelFromJson(Map<String, dynamic> json) {
  return _ProductSaleInfoModel.fromJson(json);
}

/// @nodoc
mixin _$ProductSaleInfoModel {
  @JsonKey(name: 'id')
  int get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'product_id')
  int get productId => throw _privateConstructorUsedError;
  @JsonKey(name: 'variant_id')
  int get variantId => throw _privateConstructorUsedError;
  @JsonKey(name: 'product_name')
  String get name => throw _privateConstructorUsedError;
  @JsonKey(name: 'variant')
  String? get variantAttribute => throw _privateConstructorUsedError;
  @JsonKey(name: 'quantity')
  int get quantity => throw _privateConstructorUsedError;
  @JsonKey(name: 'price')
  int get price => throw _privateConstructorUsedError;
  @JsonKey(name: 'subtotal')
  int get subtotal => throw _privateConstructorUsedError;
  @JsonKey(name: 'thumbnail')
  String? get image => throw _privateConstructorUsedError;
  @JsonKey(name: 'color')
  String? get color => throw _privateConstructorUsedError;
  @JsonKey(name: 'category')
  String? get category => throw _privateConstructorUsedError;
  @JsonKey(name: 'model')
  String? get model => throw _privateConstructorUsedError;
  @JsonKey(name: 'main_category_name', fromJson: MainServiceType.fromString)
  MainServiceType? get mainServiceType => throw _privateConstructorUsedError;

  /// Serializes this ProductSaleInfoModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ProductSaleInfoModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ProductSaleInfoModelCopyWith<ProductSaleInfoModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProductSaleInfoModelCopyWith<$Res> {
  factory $ProductSaleInfoModelCopyWith(
    ProductSaleInfoModel value,
    $Res Function(ProductSaleInfoModel) then,
  ) = _$ProductSaleInfoModelCopyWithImpl<$Res, ProductSaleInfoModel>;
  @useResult
  $Res call({
    @JsonKey(name: 'id') int id,
    @JsonKey(name: 'product_id') int productId,
    @JsonKey(name: 'variant_id') int variantId,
    @JsonKey(name: 'product_name') String name,
    @JsonKey(name: 'variant') String? variantAttribute,
    @JsonKey(name: 'quantity') int quantity,
    @JsonKey(name: 'price') int price,
    @JsonKey(name: 'subtotal') int subtotal,
    @JsonKey(name: 'thumbnail') String? image,
    @JsonKey(name: 'color') String? color,
    @JsonKey(name: 'category') String? category,
    @JsonKey(name: 'model') String? model,
    @JsonKey(name: 'main_category_name', fromJson: MainServiceType.fromString)
    MainServiceType? mainServiceType,
  });
}

/// @nodoc
class _$ProductSaleInfoModelCopyWithImpl<
  $Res,
  $Val extends ProductSaleInfoModel
>
    implements $ProductSaleInfoModelCopyWith<$Res> {
  _$ProductSaleInfoModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ProductSaleInfoModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? productId = null,
    Object? variantId = null,
    Object? name = null,
    Object? variantAttribute = freezed,
    Object? quantity = null,
    Object? price = null,
    Object? subtotal = null,
    Object? image = freezed,
    Object? color = freezed,
    Object? category = freezed,
    Object? model = freezed,
    Object? mainServiceType = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as int,
            productId: null == productId
                ? _value.productId
                : productId // ignore: cast_nullable_to_non_nullable
                      as int,
            variantId: null == variantId
                ? _value.variantId
                : variantId // ignore: cast_nullable_to_non_nullable
                      as int,
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            variantAttribute: freezed == variantAttribute
                ? _value.variantAttribute
                : variantAttribute // ignore: cast_nullable_to_non_nullable
                      as String?,
            quantity: null == quantity
                ? _value.quantity
                : quantity // ignore: cast_nullable_to_non_nullable
                      as int,
            price: null == price
                ? _value.price
                : price // ignore: cast_nullable_to_non_nullable
                      as int,
            subtotal: null == subtotal
                ? _value.subtotal
                : subtotal // ignore: cast_nullable_to_non_nullable
                      as int,
            image: freezed == image
                ? _value.image
                : image // ignore: cast_nullable_to_non_nullable
                      as String?,
            color: freezed == color
                ? _value.color
                : color // ignore: cast_nullable_to_non_nullable
                      as String?,
            category: freezed == category
                ? _value.category
                : category // ignore: cast_nullable_to_non_nullable
                      as String?,
            model: freezed == model
                ? _value.model
                : model // ignore: cast_nullable_to_non_nullable
                      as String?,
            mainServiceType: freezed == mainServiceType
                ? _value.mainServiceType
                : mainServiceType // ignore: cast_nullable_to_non_nullable
                      as MainServiceType?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ProductSaleInfoModelImplCopyWith<$Res>
    implements $ProductSaleInfoModelCopyWith<$Res> {
  factory _$$ProductSaleInfoModelImplCopyWith(
    _$ProductSaleInfoModelImpl value,
    $Res Function(_$ProductSaleInfoModelImpl) then,
  ) = __$$ProductSaleInfoModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'id') int id,
    @JsonKey(name: 'product_id') int productId,
    @JsonKey(name: 'variant_id') int variantId,
    @JsonKey(name: 'product_name') String name,
    @JsonKey(name: 'variant') String? variantAttribute,
    @JsonKey(name: 'quantity') int quantity,
    @JsonKey(name: 'price') int price,
    @JsonKey(name: 'subtotal') int subtotal,
    @JsonKey(name: 'thumbnail') String? image,
    @JsonKey(name: 'color') String? color,
    @JsonKey(name: 'category') String? category,
    @JsonKey(name: 'model') String? model,
    @JsonKey(name: 'main_category_name', fromJson: MainServiceType.fromString)
    MainServiceType? mainServiceType,
  });
}

/// @nodoc
class __$$ProductSaleInfoModelImplCopyWithImpl<$Res>
    extends _$ProductSaleInfoModelCopyWithImpl<$Res, _$ProductSaleInfoModelImpl>
    implements _$$ProductSaleInfoModelImplCopyWith<$Res> {
  __$$ProductSaleInfoModelImplCopyWithImpl(
    _$ProductSaleInfoModelImpl _value,
    $Res Function(_$ProductSaleInfoModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ProductSaleInfoModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? productId = null,
    Object? variantId = null,
    Object? name = null,
    Object? variantAttribute = freezed,
    Object? quantity = null,
    Object? price = null,
    Object? subtotal = null,
    Object? image = freezed,
    Object? color = freezed,
    Object? category = freezed,
    Object? model = freezed,
    Object? mainServiceType = freezed,
  }) {
    return _then(
      _$ProductSaleInfoModelImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int,
        productId: null == productId
            ? _value.productId
            : productId // ignore: cast_nullable_to_non_nullable
                  as int,
        variantId: null == variantId
            ? _value.variantId
            : variantId // ignore: cast_nullable_to_non_nullable
                  as int,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        variantAttribute: freezed == variantAttribute
            ? _value.variantAttribute
            : variantAttribute // ignore: cast_nullable_to_non_nullable
                  as String?,
        quantity: null == quantity
            ? _value.quantity
            : quantity // ignore: cast_nullable_to_non_nullable
                  as int,
        price: null == price
            ? _value.price
            : price // ignore: cast_nullable_to_non_nullable
                  as int,
        subtotal: null == subtotal
            ? _value.subtotal
            : subtotal // ignore: cast_nullable_to_non_nullable
                  as int,
        image: freezed == image
            ? _value.image
            : image // ignore: cast_nullable_to_non_nullable
                  as String?,
        color: freezed == color
            ? _value.color
            : color // ignore: cast_nullable_to_non_nullable
                  as String?,
        category: freezed == category
            ? _value.category
            : category // ignore: cast_nullable_to_non_nullable
                  as String?,
        model: freezed == model
            ? _value.model
            : model // ignore: cast_nullable_to_non_nullable
                  as String?,
        mainServiceType: freezed == mainServiceType
            ? _value.mainServiceType
            : mainServiceType // ignore: cast_nullable_to_non_nullable
                  as MainServiceType?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ProductSaleInfoModelImpl implements _ProductSaleInfoModel {
  const _$ProductSaleInfoModelImpl({
    @JsonKey(name: 'id') required this.id,
    @JsonKey(name: 'product_id') required this.productId,
    @JsonKey(name: 'variant_id') required this.variantId,
    @JsonKey(name: 'product_name') required this.name,
    @JsonKey(name: 'variant') this.variantAttribute,
    @JsonKey(name: 'quantity') required this.quantity,
    @JsonKey(name: 'price') required this.price,
    @JsonKey(name: 'subtotal') required this.subtotal,
    @JsonKey(name: 'thumbnail') this.image,
    @JsonKey(name: 'color') this.color,
    @JsonKey(name: 'category') this.category,
    @JsonKey(name: 'model') this.model,
    @JsonKey(name: 'main_category_name', fromJson: MainServiceType.fromString)
    this.mainServiceType,
  });

  factory _$ProductSaleInfoModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$ProductSaleInfoModelImplFromJson(json);

  @override
  @JsonKey(name: 'id')
  final int id;
  @override
  @JsonKey(name: 'product_id')
  final int productId;
  @override
  @JsonKey(name: 'variant_id')
  final int variantId;
  @override
  @JsonKey(name: 'product_name')
  final String name;
  @override
  @JsonKey(name: 'variant')
  final String? variantAttribute;
  @override
  @JsonKey(name: 'quantity')
  final int quantity;
  @override
  @JsonKey(name: 'price')
  final int price;
  @override
  @JsonKey(name: 'subtotal')
  final int subtotal;
  @override
  @JsonKey(name: 'thumbnail')
  final String? image;
  @override
  @JsonKey(name: 'color')
  final String? color;
  @override
  @JsonKey(name: 'category')
  final String? category;
  @override
  @JsonKey(name: 'model')
  final String? model;
  @override
  @JsonKey(name: 'main_category_name', fromJson: MainServiceType.fromString)
  final MainServiceType? mainServiceType;

  @override
  String toString() {
    return 'ProductSaleInfoModel(id: $id, productId: $productId, variantId: $variantId, name: $name, variantAttribute: $variantAttribute, quantity: $quantity, price: $price, subtotal: $subtotal, image: $image, color: $color, category: $category, model: $model, mainServiceType: $mainServiceType)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProductSaleInfoModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.productId, productId) ||
                other.productId == productId) &&
            (identical(other.variantId, variantId) ||
                other.variantId == variantId) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.variantAttribute, variantAttribute) ||
                other.variantAttribute == variantAttribute) &&
            (identical(other.quantity, quantity) ||
                other.quantity == quantity) &&
            (identical(other.price, price) || other.price == price) &&
            (identical(other.subtotal, subtotal) ||
                other.subtotal == subtotal) &&
            (identical(other.image, image) || other.image == image) &&
            (identical(other.color, color) || other.color == color) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.model, model) || other.model == model) &&
            (identical(other.mainServiceType, mainServiceType) ||
                other.mainServiceType == mainServiceType));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    productId,
    variantId,
    name,
    variantAttribute,
    quantity,
    price,
    subtotal,
    image,
    color,
    category,
    model,
    mainServiceType,
  );

  /// Create a copy of ProductSaleInfoModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ProductSaleInfoModelImplCopyWith<_$ProductSaleInfoModelImpl>
  get copyWith =>
      __$$ProductSaleInfoModelImplCopyWithImpl<_$ProductSaleInfoModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$ProductSaleInfoModelImplToJson(this);
  }
}

abstract class _ProductSaleInfoModel implements ProductSaleInfoModel {
  const factory _ProductSaleInfoModel({
    @JsonKey(name: 'id') required final int id,
    @JsonKey(name: 'product_id') required final int productId,
    @JsonKey(name: 'variant_id') required final int variantId,
    @JsonKey(name: 'product_name') required final String name,
    @JsonKey(name: 'variant') final String? variantAttribute,
    @JsonKey(name: 'quantity') required final int quantity,
    @JsonKey(name: 'price') required final int price,
    @JsonKey(name: 'subtotal') required final int subtotal,
    @JsonKey(name: 'thumbnail') final String? image,
    @JsonKey(name: 'color') final String? color,
    @JsonKey(name: 'category') final String? category,
    @JsonKey(name: 'model') final String? model,
    @JsonKey(name: 'main_category_name', fromJson: MainServiceType.fromString)
    final MainServiceType? mainServiceType,
  }) = _$ProductSaleInfoModelImpl;

  factory _ProductSaleInfoModel.fromJson(Map<String, dynamic> json) =
      _$ProductSaleInfoModelImpl.fromJson;

  @override
  @JsonKey(name: 'id')
  int get id;
  @override
  @JsonKey(name: 'product_id')
  int get productId;
  @override
  @JsonKey(name: 'variant_id')
  int get variantId;
  @override
  @JsonKey(name: 'product_name')
  String get name;
  @override
  @JsonKey(name: 'variant')
  String? get variantAttribute;
  @override
  @JsonKey(name: 'quantity')
  int get quantity;
  @override
  @JsonKey(name: 'price')
  int get price;
  @override
  @JsonKey(name: 'subtotal')
  int get subtotal;
  @override
  @JsonKey(name: 'thumbnail')
  String? get image;
  @override
  @JsonKey(name: 'color')
  String? get color;
  @override
  @JsonKey(name: 'category')
  String? get category;
  @override
  @JsonKey(name: 'model')
  String? get model;
  @override
  @JsonKey(name: 'main_category_name', fromJson: MainServiceType.fromString)
  MainServiceType? get mainServiceType;

  /// Create a copy of ProductSaleInfoModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ProductSaleInfoModelImplCopyWith<_$ProductSaleInfoModelImpl>
  get copyWith => throw _privateConstructorUsedError;
}
