// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'product_info_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ProductInfoEvent {
  int get productId => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int productId) loadProductInfo,
    required TResult Function(int productId, int? variantId) deleteProduct,
    required TResult Function(int productId, int variantId,
            String? updatedAttribute, int? updatedStock)
        updateVariant,
    required TResult Function(int productId, String attribute, int stock)
        addProductVariant,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int productId)? loadProductInfo,
    TResult? Function(int productId, int? variantId)? deleteProduct,
    TResult? Function(int productId, int variantId, String? updatedAttribute,
            int? updatedStock)?
        updateVariant,
    TResult? Function(int productId, String attribute, int stock)?
        addProductVariant,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int productId)? loadProductInfo,
    TResult Function(int productId, int? variantId)? deleteProduct,
    TResult Function(int productId, int variantId, String? updatedAttribute,
            int? updatedStock)?
        updateVariant,
    TResult Function(int productId, String attribute, int stock)?
        addProductVariant,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadProductInfo value) loadProductInfo,
    required TResult Function(_DeleteProduct value) deleteProduct,
    required TResult Function(_UpdateVariant value) updateVariant,
    required TResult Function(_AddProductVariants value) addProductVariant,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadProductInfo value)? loadProductInfo,
    TResult? Function(_DeleteProduct value)? deleteProduct,
    TResult? Function(_UpdateVariant value)? updateVariant,
    TResult? Function(_AddProductVariants value)? addProductVariant,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadProductInfo value)? loadProductInfo,
    TResult Function(_DeleteProduct value)? deleteProduct,
    TResult Function(_UpdateVariant value)? updateVariant,
    TResult Function(_AddProductVariants value)? addProductVariant,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  /// Create a copy of ProductInfoEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ProductInfoEventCopyWith<ProductInfoEvent> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProductInfoEventCopyWith<$Res> {
  factory $ProductInfoEventCopyWith(
          ProductInfoEvent value, $Res Function(ProductInfoEvent) then) =
      _$ProductInfoEventCopyWithImpl<$Res, ProductInfoEvent>;
  @useResult
  $Res call({int productId});
}

/// @nodoc
class _$ProductInfoEventCopyWithImpl<$Res, $Val extends ProductInfoEvent>
    implements $ProductInfoEventCopyWith<$Res> {
  _$ProductInfoEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ProductInfoEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? productId = null,
  }) {
    return _then(_value.copyWith(
      productId: null == productId
          ? _value.productId
          : productId // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$LoadProductInfoImplCopyWith<$Res>
    implements $ProductInfoEventCopyWith<$Res> {
  factory _$$LoadProductInfoImplCopyWith(_$LoadProductInfoImpl value,
          $Res Function(_$LoadProductInfoImpl) then) =
      __$$LoadProductInfoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int productId});
}

/// @nodoc
class __$$LoadProductInfoImplCopyWithImpl<$Res>
    extends _$ProductInfoEventCopyWithImpl<$Res, _$LoadProductInfoImpl>
    implements _$$LoadProductInfoImplCopyWith<$Res> {
  __$$LoadProductInfoImplCopyWithImpl(
      _$LoadProductInfoImpl _value, $Res Function(_$LoadProductInfoImpl) _then)
      : super(_value, _then);

  /// Create a copy of ProductInfoEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? productId = null,
  }) {
    return _then(_$LoadProductInfoImpl(
      null == productId
          ? _value.productId
          : productId // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$LoadProductInfoImpl implements _LoadProductInfo {
  const _$LoadProductInfoImpl(this.productId);

  @override
  final int productId;

  @override
  String toString() {
    return 'ProductInfoEvent.loadProductInfo(productId: $productId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadProductInfoImpl &&
            (identical(other.productId, productId) ||
                other.productId == productId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, productId);

  /// Create a copy of ProductInfoEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LoadProductInfoImplCopyWith<_$LoadProductInfoImpl> get copyWith =>
      __$$LoadProductInfoImplCopyWithImpl<_$LoadProductInfoImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int productId) loadProductInfo,
    required TResult Function(int productId, int? variantId) deleteProduct,
    required TResult Function(int productId, int variantId,
            String? updatedAttribute, int? updatedStock)
        updateVariant,
    required TResult Function(int productId, String attribute, int stock)
        addProductVariant,
  }) {
    return loadProductInfo(productId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int productId)? loadProductInfo,
    TResult? Function(int productId, int? variantId)? deleteProduct,
    TResult? Function(int productId, int variantId, String? updatedAttribute,
            int? updatedStock)?
        updateVariant,
    TResult? Function(int productId, String attribute, int stock)?
        addProductVariant,
  }) {
    return loadProductInfo?.call(productId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int productId)? loadProductInfo,
    TResult Function(int productId, int? variantId)? deleteProduct,
    TResult Function(int productId, int variantId, String? updatedAttribute,
            int? updatedStock)?
        updateVariant,
    TResult Function(int productId, String attribute, int stock)?
        addProductVariant,
    required TResult orElse(),
  }) {
    if (loadProductInfo != null) {
      return loadProductInfo(productId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadProductInfo value) loadProductInfo,
    required TResult Function(_DeleteProduct value) deleteProduct,
    required TResult Function(_UpdateVariant value) updateVariant,
    required TResult Function(_AddProductVariants value) addProductVariant,
  }) {
    return loadProductInfo(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadProductInfo value)? loadProductInfo,
    TResult? Function(_DeleteProduct value)? deleteProduct,
    TResult? Function(_UpdateVariant value)? updateVariant,
    TResult? Function(_AddProductVariants value)? addProductVariant,
  }) {
    return loadProductInfo?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadProductInfo value)? loadProductInfo,
    TResult Function(_DeleteProduct value)? deleteProduct,
    TResult Function(_UpdateVariant value)? updateVariant,
    TResult Function(_AddProductVariants value)? addProductVariant,
    required TResult orElse(),
  }) {
    if (loadProductInfo != null) {
      return loadProductInfo(this);
    }
    return orElse();
  }
}

abstract class _LoadProductInfo implements ProductInfoEvent {
  const factory _LoadProductInfo(final int productId) = _$LoadProductInfoImpl;

  @override
  int get productId;

  /// Create a copy of ProductInfoEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LoadProductInfoImplCopyWith<_$LoadProductInfoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$DeleteProductImplCopyWith<$Res>
    implements $ProductInfoEventCopyWith<$Res> {
  factory _$$DeleteProductImplCopyWith(
          _$DeleteProductImpl value, $Res Function(_$DeleteProductImpl) then) =
      __$$DeleteProductImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int productId, int? variantId});
}

/// @nodoc
class __$$DeleteProductImplCopyWithImpl<$Res>
    extends _$ProductInfoEventCopyWithImpl<$Res, _$DeleteProductImpl>
    implements _$$DeleteProductImplCopyWith<$Res> {
  __$$DeleteProductImplCopyWithImpl(
      _$DeleteProductImpl _value, $Res Function(_$DeleteProductImpl) _then)
      : super(_value, _then);

  /// Create a copy of ProductInfoEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? productId = null,
    Object? variantId = freezed,
  }) {
    return _then(_$DeleteProductImpl(
      productId: null == productId
          ? _value.productId
          : productId // ignore: cast_nullable_to_non_nullable
              as int,
      variantId: freezed == variantId
          ? _value.variantId
          : variantId // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc

class _$DeleteProductImpl implements _DeleteProduct {
  const _$DeleteProductImpl({required this.productId, this.variantId});

  @override
  final int productId;
  @override
  final int? variantId;

  @override
  String toString() {
    return 'ProductInfoEvent.deleteProduct(productId: $productId, variantId: $variantId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DeleteProductImpl &&
            (identical(other.productId, productId) ||
                other.productId == productId) &&
            (identical(other.variantId, variantId) ||
                other.variantId == variantId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, productId, variantId);

  /// Create a copy of ProductInfoEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DeleteProductImplCopyWith<_$DeleteProductImpl> get copyWith =>
      __$$DeleteProductImplCopyWithImpl<_$DeleteProductImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int productId) loadProductInfo,
    required TResult Function(int productId, int? variantId) deleteProduct,
    required TResult Function(int productId, int variantId,
            String? updatedAttribute, int? updatedStock)
        updateVariant,
    required TResult Function(int productId, String attribute, int stock)
        addProductVariant,
  }) {
    return deleteProduct(productId, variantId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int productId)? loadProductInfo,
    TResult? Function(int productId, int? variantId)? deleteProduct,
    TResult? Function(int productId, int variantId, String? updatedAttribute,
            int? updatedStock)?
        updateVariant,
    TResult? Function(int productId, String attribute, int stock)?
        addProductVariant,
  }) {
    return deleteProduct?.call(productId, variantId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int productId)? loadProductInfo,
    TResult Function(int productId, int? variantId)? deleteProduct,
    TResult Function(int productId, int variantId, String? updatedAttribute,
            int? updatedStock)?
        updateVariant,
    TResult Function(int productId, String attribute, int stock)?
        addProductVariant,
    required TResult orElse(),
  }) {
    if (deleteProduct != null) {
      return deleteProduct(productId, variantId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadProductInfo value) loadProductInfo,
    required TResult Function(_DeleteProduct value) deleteProduct,
    required TResult Function(_UpdateVariant value) updateVariant,
    required TResult Function(_AddProductVariants value) addProductVariant,
  }) {
    return deleteProduct(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadProductInfo value)? loadProductInfo,
    TResult? Function(_DeleteProduct value)? deleteProduct,
    TResult? Function(_UpdateVariant value)? updateVariant,
    TResult? Function(_AddProductVariants value)? addProductVariant,
  }) {
    return deleteProduct?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadProductInfo value)? loadProductInfo,
    TResult Function(_DeleteProduct value)? deleteProduct,
    TResult Function(_UpdateVariant value)? updateVariant,
    TResult Function(_AddProductVariants value)? addProductVariant,
    required TResult orElse(),
  }) {
    if (deleteProduct != null) {
      return deleteProduct(this);
    }
    return orElse();
  }
}

abstract class _DeleteProduct implements ProductInfoEvent {
  const factory _DeleteProduct(
      {required final int productId,
      final int? variantId}) = _$DeleteProductImpl;

  @override
  int get productId;
  int? get variantId;

  /// Create a copy of ProductInfoEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DeleteProductImplCopyWith<_$DeleteProductImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$UpdateVariantImplCopyWith<$Res>
    implements $ProductInfoEventCopyWith<$Res> {
  factory _$$UpdateVariantImplCopyWith(
          _$UpdateVariantImpl value, $Res Function(_$UpdateVariantImpl) then) =
      __$$UpdateVariantImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int productId,
      int variantId,
      String? updatedAttribute,
      int? updatedStock});
}

/// @nodoc
class __$$UpdateVariantImplCopyWithImpl<$Res>
    extends _$ProductInfoEventCopyWithImpl<$Res, _$UpdateVariantImpl>
    implements _$$UpdateVariantImplCopyWith<$Res> {
  __$$UpdateVariantImplCopyWithImpl(
      _$UpdateVariantImpl _value, $Res Function(_$UpdateVariantImpl) _then)
      : super(_value, _then);

  /// Create a copy of ProductInfoEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? productId = null,
    Object? variantId = null,
    Object? updatedAttribute = freezed,
    Object? updatedStock = freezed,
  }) {
    return _then(_$UpdateVariantImpl(
      productId: null == productId
          ? _value.productId
          : productId // ignore: cast_nullable_to_non_nullable
              as int,
      variantId: null == variantId
          ? _value.variantId
          : variantId // ignore: cast_nullable_to_non_nullable
              as int,
      updatedAttribute: freezed == updatedAttribute
          ? _value.updatedAttribute
          : updatedAttribute // ignore: cast_nullable_to_non_nullable
              as String?,
      updatedStock: freezed == updatedStock
          ? _value.updatedStock
          : updatedStock // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc

class _$UpdateVariantImpl implements _UpdateVariant {
  const _$UpdateVariantImpl(
      {required this.productId,
      required this.variantId,
      required this.updatedAttribute,
      required this.updatedStock});

  @override
  final int productId;
  @override
  final int variantId;
  @override
  final String? updatedAttribute;
  @override
  final int? updatedStock;

  @override
  String toString() {
    return 'ProductInfoEvent.updateVariant(productId: $productId, variantId: $variantId, updatedAttribute: $updatedAttribute, updatedStock: $updatedStock)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UpdateVariantImpl &&
            (identical(other.productId, productId) ||
                other.productId == productId) &&
            (identical(other.variantId, variantId) ||
                other.variantId == variantId) &&
            (identical(other.updatedAttribute, updatedAttribute) ||
                other.updatedAttribute == updatedAttribute) &&
            (identical(other.updatedStock, updatedStock) ||
                other.updatedStock == updatedStock));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, productId, variantId, updatedAttribute, updatedStock);

  /// Create a copy of ProductInfoEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UpdateVariantImplCopyWith<_$UpdateVariantImpl> get copyWith =>
      __$$UpdateVariantImplCopyWithImpl<_$UpdateVariantImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int productId) loadProductInfo,
    required TResult Function(int productId, int? variantId) deleteProduct,
    required TResult Function(int productId, int variantId,
            String? updatedAttribute, int? updatedStock)
        updateVariant,
    required TResult Function(int productId, String attribute, int stock)
        addProductVariant,
  }) {
    return updateVariant(productId, variantId, updatedAttribute, updatedStock);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int productId)? loadProductInfo,
    TResult? Function(int productId, int? variantId)? deleteProduct,
    TResult? Function(int productId, int variantId, String? updatedAttribute,
            int? updatedStock)?
        updateVariant,
    TResult? Function(int productId, String attribute, int stock)?
        addProductVariant,
  }) {
    return updateVariant?.call(
        productId, variantId, updatedAttribute, updatedStock);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int productId)? loadProductInfo,
    TResult Function(int productId, int? variantId)? deleteProduct,
    TResult Function(int productId, int variantId, String? updatedAttribute,
            int? updatedStock)?
        updateVariant,
    TResult Function(int productId, String attribute, int stock)?
        addProductVariant,
    required TResult orElse(),
  }) {
    if (updateVariant != null) {
      return updateVariant(
          productId, variantId, updatedAttribute, updatedStock);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadProductInfo value) loadProductInfo,
    required TResult Function(_DeleteProduct value) deleteProduct,
    required TResult Function(_UpdateVariant value) updateVariant,
    required TResult Function(_AddProductVariants value) addProductVariant,
  }) {
    return updateVariant(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadProductInfo value)? loadProductInfo,
    TResult? Function(_DeleteProduct value)? deleteProduct,
    TResult? Function(_UpdateVariant value)? updateVariant,
    TResult? Function(_AddProductVariants value)? addProductVariant,
  }) {
    return updateVariant?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadProductInfo value)? loadProductInfo,
    TResult Function(_DeleteProduct value)? deleteProduct,
    TResult Function(_UpdateVariant value)? updateVariant,
    TResult Function(_AddProductVariants value)? addProductVariant,
    required TResult orElse(),
  }) {
    if (updateVariant != null) {
      return updateVariant(this);
    }
    return orElse();
  }
}

abstract class _UpdateVariant implements ProductInfoEvent {
  const factory _UpdateVariant(
      {required final int productId,
      required final int variantId,
      required final String? updatedAttribute,
      required final int? updatedStock}) = _$UpdateVariantImpl;

  @override
  int get productId;
  int get variantId;
  String? get updatedAttribute;
  int? get updatedStock;

  /// Create a copy of ProductInfoEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UpdateVariantImplCopyWith<_$UpdateVariantImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$AddProductVariantsImplCopyWith<$Res>
    implements $ProductInfoEventCopyWith<$Res> {
  factory _$$AddProductVariantsImplCopyWith(_$AddProductVariantsImpl value,
          $Res Function(_$AddProductVariantsImpl) then) =
      __$$AddProductVariantsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int productId, String attribute, int stock});
}

/// @nodoc
class __$$AddProductVariantsImplCopyWithImpl<$Res>
    extends _$ProductInfoEventCopyWithImpl<$Res, _$AddProductVariantsImpl>
    implements _$$AddProductVariantsImplCopyWith<$Res> {
  __$$AddProductVariantsImplCopyWithImpl(_$AddProductVariantsImpl _value,
      $Res Function(_$AddProductVariantsImpl) _then)
      : super(_value, _then);

  /// Create a copy of ProductInfoEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? productId = null,
    Object? attribute = null,
    Object? stock = null,
  }) {
    return _then(_$AddProductVariantsImpl(
      productId: null == productId
          ? _value.productId
          : productId // ignore: cast_nullable_to_non_nullable
              as int,
      attribute: null == attribute
          ? _value.attribute
          : attribute // ignore: cast_nullable_to_non_nullable
              as String,
      stock: null == stock
          ? _value.stock
          : stock // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$AddProductVariantsImpl implements _AddProductVariants {
  const _$AddProductVariantsImpl(
      {required this.productId, required this.attribute, required this.stock});

  @override
  final int productId;
  @override
  final String attribute;
  @override
  final int stock;

  @override
  String toString() {
    return 'ProductInfoEvent.addProductVariant(productId: $productId, attribute: $attribute, stock: $stock)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AddProductVariantsImpl &&
            (identical(other.productId, productId) ||
                other.productId == productId) &&
            (identical(other.attribute, attribute) ||
                other.attribute == attribute) &&
            (identical(other.stock, stock) || other.stock == stock));
  }

  @override
  int get hashCode => Object.hash(runtimeType, productId, attribute, stock);

  /// Create a copy of ProductInfoEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AddProductVariantsImplCopyWith<_$AddProductVariantsImpl> get copyWith =>
      __$$AddProductVariantsImplCopyWithImpl<_$AddProductVariantsImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int productId) loadProductInfo,
    required TResult Function(int productId, int? variantId) deleteProduct,
    required TResult Function(int productId, int variantId,
            String? updatedAttribute, int? updatedStock)
        updateVariant,
    required TResult Function(int productId, String attribute, int stock)
        addProductVariant,
  }) {
    return addProductVariant(productId, attribute, stock);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int productId)? loadProductInfo,
    TResult? Function(int productId, int? variantId)? deleteProduct,
    TResult? Function(int productId, int variantId, String? updatedAttribute,
            int? updatedStock)?
        updateVariant,
    TResult? Function(int productId, String attribute, int stock)?
        addProductVariant,
  }) {
    return addProductVariant?.call(productId, attribute, stock);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int productId)? loadProductInfo,
    TResult Function(int productId, int? variantId)? deleteProduct,
    TResult Function(int productId, int variantId, String? updatedAttribute,
            int? updatedStock)?
        updateVariant,
    TResult Function(int productId, String attribute, int stock)?
        addProductVariant,
    required TResult orElse(),
  }) {
    if (addProductVariant != null) {
      return addProductVariant(productId, attribute, stock);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadProductInfo value) loadProductInfo,
    required TResult Function(_DeleteProduct value) deleteProduct,
    required TResult Function(_UpdateVariant value) updateVariant,
    required TResult Function(_AddProductVariants value) addProductVariant,
  }) {
    return addProductVariant(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_LoadProductInfo value)? loadProductInfo,
    TResult? Function(_DeleteProduct value)? deleteProduct,
    TResult? Function(_UpdateVariant value)? updateVariant,
    TResult? Function(_AddProductVariants value)? addProductVariant,
  }) {
    return addProductVariant?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadProductInfo value)? loadProductInfo,
    TResult Function(_DeleteProduct value)? deleteProduct,
    TResult Function(_UpdateVariant value)? updateVariant,
    TResult Function(_AddProductVariants value)? addProductVariant,
    required TResult orElse(),
  }) {
    if (addProductVariant != null) {
      return addProductVariant(this);
    }
    return orElse();
  }
}

abstract class _AddProductVariants implements ProductInfoEvent {
  const factory _AddProductVariants(
      {required final int productId,
      required final String attribute,
      required final int stock}) = _$AddProductVariantsImpl;

  @override
  int get productId;
  String get attribute;
  int get stock;

  /// Create a copy of ProductInfoEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AddProductVariantsImplCopyWith<_$AddProductVariantsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$ProductInfoState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(ProductModel productInfo) loaded,
    required TResult Function(String error) error,
    required TResult Function(String message) failure,
    required TResult Function(String message, bool needPop) success,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(ProductModel productInfo)? loaded,
    TResult? Function(String error)? error,
    TResult? Function(String message)? failure,
    TResult? Function(String message, bool needPop)? success,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(ProductModel productInfo)? loaded,
    TResult Function(String error)? error,
    TResult Function(String message)? failure,
    TResult Function(String message, bool needPop)? success,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Loading value) loading,
    required TResult Function(_Loaded value) loaded,
    required TResult Function(_Error value) error,
    required TResult Function(_Failure value) failure,
    required TResult Function(_Success value) success,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Loaded value)? loaded,
    TResult? Function(_Error value)? error,
    TResult? Function(_Failure value)? failure,
    TResult? Function(_Success value)? success,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Loading value)? loading,
    TResult Function(_Loaded value)? loaded,
    TResult Function(_Error value)? error,
    TResult Function(_Failure value)? failure,
    TResult Function(_Success value)? success,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProductInfoStateCopyWith<$Res> {
  factory $ProductInfoStateCopyWith(
          ProductInfoState value, $Res Function(ProductInfoState) then) =
      _$ProductInfoStateCopyWithImpl<$Res, ProductInfoState>;
}

/// @nodoc
class _$ProductInfoStateCopyWithImpl<$Res, $Val extends ProductInfoState>
    implements $ProductInfoStateCopyWith<$Res> {
  _$ProductInfoStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ProductInfoState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$LoadingImplCopyWith<$Res> {
  factory _$$LoadingImplCopyWith(
          _$LoadingImpl value, $Res Function(_$LoadingImpl) then) =
      __$$LoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$LoadingImplCopyWithImpl<$Res>
    extends _$ProductInfoStateCopyWithImpl<$Res, _$LoadingImpl>
    implements _$$LoadingImplCopyWith<$Res> {
  __$$LoadingImplCopyWithImpl(
      _$LoadingImpl _value, $Res Function(_$LoadingImpl) _then)
      : super(_value, _then);

  /// Create a copy of ProductInfoState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$LoadingImpl implements _Loading {
  const _$LoadingImpl();

  @override
  String toString() {
    return 'ProductInfoState.loading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$LoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(ProductModel productInfo) loaded,
    required TResult Function(String error) error,
    required TResult Function(String message) failure,
    required TResult Function(String message, bool needPop) success,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(ProductModel productInfo)? loaded,
    TResult? Function(String error)? error,
    TResult? Function(String message)? failure,
    TResult? Function(String message, bool needPop)? success,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(ProductModel productInfo)? loaded,
    TResult Function(String error)? error,
    TResult Function(String message)? failure,
    TResult Function(String message, bool needPop)? success,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Loading value) loading,
    required TResult Function(_Loaded value) loaded,
    required TResult Function(_Error value) error,
    required TResult Function(_Failure value) failure,
    required TResult Function(_Success value) success,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Loaded value)? loaded,
    TResult? Function(_Error value)? error,
    TResult? Function(_Failure value)? failure,
    TResult? Function(_Success value)? success,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Loading value)? loading,
    TResult Function(_Loaded value)? loaded,
    TResult Function(_Error value)? error,
    TResult Function(_Failure value)? failure,
    TResult Function(_Success value)? success,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class _Loading implements ProductInfoState {
  const factory _Loading() = _$LoadingImpl;
}

/// @nodoc
abstract class _$$LoadedImplCopyWith<$Res> {
  factory _$$LoadedImplCopyWith(
          _$LoadedImpl value, $Res Function(_$LoadedImpl) then) =
      __$$LoadedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({ProductModel productInfo});

  $ProductModelCopyWith<$Res> get productInfo;
}

/// @nodoc
class __$$LoadedImplCopyWithImpl<$Res>
    extends _$ProductInfoStateCopyWithImpl<$Res, _$LoadedImpl>
    implements _$$LoadedImplCopyWith<$Res> {
  __$$LoadedImplCopyWithImpl(
      _$LoadedImpl _value, $Res Function(_$LoadedImpl) _then)
      : super(_value, _then);

  /// Create a copy of ProductInfoState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? productInfo = null,
  }) {
    return _then(_$LoadedImpl(
      null == productInfo
          ? _value.productInfo
          : productInfo // ignore: cast_nullable_to_non_nullable
              as ProductModel,
    ));
  }

  /// Create a copy of ProductInfoState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ProductModelCopyWith<$Res> get productInfo {
    return $ProductModelCopyWith<$Res>(_value.productInfo, (value) {
      return _then(_value.copyWith(productInfo: value));
    });
  }
}

/// @nodoc

class _$LoadedImpl implements _Loaded {
  const _$LoadedImpl(this.productInfo);

  @override
  final ProductModel productInfo;

  @override
  String toString() {
    return 'ProductInfoState.loaded(productInfo: $productInfo)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadedImpl &&
            (identical(other.productInfo, productInfo) ||
                other.productInfo == productInfo));
  }

  @override
  int get hashCode => Object.hash(runtimeType, productInfo);

  /// Create a copy of ProductInfoState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LoadedImplCopyWith<_$LoadedImpl> get copyWith =>
      __$$LoadedImplCopyWithImpl<_$LoadedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(ProductModel productInfo) loaded,
    required TResult Function(String error) error,
    required TResult Function(String message) failure,
    required TResult Function(String message, bool needPop) success,
  }) {
    return loaded(productInfo);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(ProductModel productInfo)? loaded,
    TResult? Function(String error)? error,
    TResult? Function(String message)? failure,
    TResult? Function(String message, bool needPop)? success,
  }) {
    return loaded?.call(productInfo);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(ProductModel productInfo)? loaded,
    TResult Function(String error)? error,
    TResult Function(String message)? failure,
    TResult Function(String message, bool needPop)? success,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(productInfo);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Loading value) loading,
    required TResult Function(_Loaded value) loaded,
    required TResult Function(_Error value) error,
    required TResult Function(_Failure value) failure,
    required TResult Function(_Success value) success,
  }) {
    return loaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Loaded value)? loaded,
    TResult? Function(_Error value)? error,
    TResult? Function(_Failure value)? failure,
    TResult? Function(_Success value)? success,
  }) {
    return loaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Loading value)? loading,
    TResult Function(_Loaded value)? loaded,
    TResult Function(_Error value)? error,
    TResult Function(_Failure value)? failure,
    TResult Function(_Success value)? success,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(this);
    }
    return orElse();
  }
}

abstract class _Loaded implements ProductInfoState {
  const factory _Loaded(final ProductModel productInfo) = _$LoadedImpl;

  ProductModel get productInfo;

  /// Create a copy of ProductInfoState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LoadedImplCopyWith<_$LoadedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ErrorImplCopyWith<$Res> {
  factory _$$ErrorImplCopyWith(
          _$ErrorImpl value, $Res Function(_$ErrorImpl) then) =
      __$$ErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String error});
}

/// @nodoc
class __$$ErrorImplCopyWithImpl<$Res>
    extends _$ProductInfoStateCopyWithImpl<$Res, _$ErrorImpl>
    implements _$$ErrorImplCopyWith<$Res> {
  __$$ErrorImplCopyWithImpl(
      _$ErrorImpl _value, $Res Function(_$ErrorImpl) _then)
      : super(_value, _then);

  /// Create a copy of ProductInfoState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? error = null,
  }) {
    return _then(_$ErrorImpl(
      null == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$ErrorImpl implements _Error {
  const _$ErrorImpl(this.error);

  @override
  final String error;

  @override
  String toString() {
    return 'ProductInfoState.error(error: $error)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ErrorImpl &&
            (identical(other.error, error) || other.error == error));
  }

  @override
  int get hashCode => Object.hash(runtimeType, error);

  /// Create a copy of ProductInfoState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ErrorImplCopyWith<_$ErrorImpl> get copyWith =>
      __$$ErrorImplCopyWithImpl<_$ErrorImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(ProductModel productInfo) loaded,
    required TResult Function(String error) error,
    required TResult Function(String message) failure,
    required TResult Function(String message, bool needPop) success,
  }) {
    return error(this.error);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(ProductModel productInfo)? loaded,
    TResult? Function(String error)? error,
    TResult? Function(String message)? failure,
    TResult? Function(String message, bool needPop)? success,
  }) {
    return error?.call(this.error);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(ProductModel productInfo)? loaded,
    TResult Function(String error)? error,
    TResult Function(String message)? failure,
    TResult Function(String message, bool needPop)? success,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this.error);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Loading value) loading,
    required TResult Function(_Loaded value) loaded,
    required TResult Function(_Error value) error,
    required TResult Function(_Failure value) failure,
    required TResult Function(_Success value) success,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Loaded value)? loaded,
    TResult? Function(_Error value)? error,
    TResult? Function(_Failure value)? failure,
    TResult? Function(_Success value)? success,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Loading value)? loading,
    TResult Function(_Loaded value)? loaded,
    TResult Function(_Error value)? error,
    TResult Function(_Failure value)? failure,
    TResult Function(_Success value)? success,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class _Error implements ProductInfoState {
  const factory _Error(final String error) = _$ErrorImpl;

  String get error;

  /// Create a copy of ProductInfoState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ErrorImplCopyWith<_$ErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$FailureImplCopyWith<$Res> {
  factory _$$FailureImplCopyWith(
          _$FailureImpl value, $Res Function(_$FailureImpl) then) =
      __$$FailureImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$FailureImplCopyWithImpl<$Res>
    extends _$ProductInfoStateCopyWithImpl<$Res, _$FailureImpl>
    implements _$$FailureImplCopyWith<$Res> {
  __$$FailureImplCopyWithImpl(
      _$FailureImpl _value, $Res Function(_$FailureImpl) _then)
      : super(_value, _then);

  /// Create a copy of ProductInfoState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
  }) {
    return _then(_$FailureImpl(
      null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$FailureImpl implements _Failure {
  const _$FailureImpl(this.message);

  @override
  final String message;

  @override
  String toString() {
    return 'ProductInfoState.failure(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FailureImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of ProductInfoState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FailureImplCopyWith<_$FailureImpl> get copyWith =>
      __$$FailureImplCopyWithImpl<_$FailureImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(ProductModel productInfo) loaded,
    required TResult Function(String error) error,
    required TResult Function(String message) failure,
    required TResult Function(String message, bool needPop) success,
  }) {
    return failure(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(ProductModel productInfo)? loaded,
    TResult? Function(String error)? error,
    TResult? Function(String message)? failure,
    TResult? Function(String message, bool needPop)? success,
  }) {
    return failure?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(ProductModel productInfo)? loaded,
    TResult Function(String error)? error,
    TResult Function(String message)? failure,
    TResult Function(String message, bool needPop)? success,
    required TResult orElse(),
  }) {
    if (failure != null) {
      return failure(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Loading value) loading,
    required TResult Function(_Loaded value) loaded,
    required TResult Function(_Error value) error,
    required TResult Function(_Failure value) failure,
    required TResult Function(_Success value) success,
  }) {
    return failure(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Loaded value)? loaded,
    TResult? Function(_Error value)? error,
    TResult? Function(_Failure value)? failure,
    TResult? Function(_Success value)? success,
  }) {
    return failure?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Loading value)? loading,
    TResult Function(_Loaded value)? loaded,
    TResult Function(_Error value)? error,
    TResult Function(_Failure value)? failure,
    TResult Function(_Success value)? success,
    required TResult orElse(),
  }) {
    if (failure != null) {
      return failure(this);
    }
    return orElse();
  }
}

abstract class _Failure implements ProductInfoState {
  const factory _Failure(final String message) = _$FailureImpl;

  String get message;

  /// Create a copy of ProductInfoState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FailureImplCopyWith<_$FailureImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SuccessImplCopyWith<$Res> {
  factory _$$SuccessImplCopyWith(
          _$SuccessImpl value, $Res Function(_$SuccessImpl) then) =
      __$$SuccessImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String message, bool needPop});
}

/// @nodoc
class __$$SuccessImplCopyWithImpl<$Res>
    extends _$ProductInfoStateCopyWithImpl<$Res, _$SuccessImpl>
    implements _$$SuccessImplCopyWith<$Res> {
  __$$SuccessImplCopyWithImpl(
      _$SuccessImpl _value, $Res Function(_$SuccessImpl) _then)
      : super(_value, _then);

  /// Create a copy of ProductInfoState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
    Object? needPop = null,
  }) {
    return _then(_$SuccessImpl(
      null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      null == needPop
          ? _value.needPop
          : needPop // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$SuccessImpl implements _Success {
  const _$SuccessImpl(this.message, [this.needPop = false]);

  @override
  final String message;
  @override
  @JsonKey()
  final bool needPop;

  @override
  String toString() {
    return 'ProductInfoState.success(message: $message, needPop: $needPop)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SuccessImpl &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.needPop, needPop) || other.needPop == needPop));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message, needPop);

  /// Create a copy of ProductInfoState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SuccessImplCopyWith<_$SuccessImpl> get copyWith =>
      __$$SuccessImplCopyWithImpl<_$SuccessImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(ProductModel productInfo) loaded,
    required TResult Function(String error) error,
    required TResult Function(String message) failure,
    required TResult Function(String message, bool needPop) success,
  }) {
    return success(message, needPop);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(ProductModel productInfo)? loaded,
    TResult? Function(String error)? error,
    TResult? Function(String message)? failure,
    TResult? Function(String message, bool needPop)? success,
  }) {
    return success?.call(message, needPop);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(ProductModel productInfo)? loaded,
    TResult Function(String error)? error,
    TResult Function(String message)? failure,
    TResult Function(String message, bool needPop)? success,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(message, needPop);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Loading value) loading,
    required TResult Function(_Loaded value) loaded,
    required TResult Function(_Error value) error,
    required TResult Function(_Failure value) failure,
    required TResult Function(_Success value) success,
  }) {
    return success(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Loaded value)? loaded,
    TResult? Function(_Error value)? error,
    TResult? Function(_Failure value)? failure,
    TResult? Function(_Success value)? success,
  }) {
    return success?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Loading value)? loading,
    TResult Function(_Loaded value)? loaded,
    TResult Function(_Error value)? error,
    TResult Function(_Failure value)? failure,
    TResult Function(_Success value)? success,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(this);
    }
    return orElse();
  }
}

abstract class _Success implements ProductInfoState {
  const factory _Success(final String message, [final bool needPop]) =
      _$SuccessImpl;

  String get message;
  bool get needPop;

  /// Create a copy of ProductInfoState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SuccessImplCopyWith<_$SuccessImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
