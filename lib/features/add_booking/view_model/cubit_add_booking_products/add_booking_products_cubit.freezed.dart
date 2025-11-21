// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'add_booking_products_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$AddBookingProductsState {
  List<ProductSelectedModel> get products => throw _privateConstructorUsedError;

  /// Create a copy of AddBookingProductsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AddBookingProductsStateCopyWith<AddBookingProductsState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AddBookingProductsStateCopyWith<$Res> {
  factory $AddBookingProductsStateCopyWith(
    AddBookingProductsState value,
    $Res Function(AddBookingProductsState) then,
  ) = _$AddBookingProductsStateCopyWithImpl<$Res, AddBookingProductsState>;
  @useResult
  $Res call({List<ProductSelectedModel> products});
}

/// @nodoc
class _$AddBookingProductsStateCopyWithImpl<$Res,
        $Val extends AddBookingProductsState>
    implements $AddBookingProductsStateCopyWith<$Res> {
  _$AddBookingProductsStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AddBookingProductsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? products = null}) {
    return _then(
      _value.copyWith(
        products: null == products
            ? _value.products
            : products // ignore: cast_nullable_to_non_nullable
                as List<ProductSelectedModel>,
      ) as $Val,
    );
  }
}

/// @nodoc
abstract class _$$AddBookingProductsStateImplCopyWith<$Res>
    implements $AddBookingProductsStateCopyWith<$Res> {
  factory _$$AddBookingProductsStateImplCopyWith(
    _$AddBookingProductsStateImpl value,
    $Res Function(_$AddBookingProductsStateImpl) then,
  ) = __$$AddBookingProductsStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<ProductSelectedModel> products});
}

/// @nodoc
class __$$AddBookingProductsStateImplCopyWithImpl<$Res>
    extends _$AddBookingProductsStateCopyWithImpl<$Res,
        _$AddBookingProductsStateImpl>
    implements _$$AddBookingProductsStateImplCopyWith<$Res> {
  __$$AddBookingProductsStateImplCopyWithImpl(
    _$AddBookingProductsStateImpl _value,
    $Res Function(_$AddBookingProductsStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AddBookingProductsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? products = null}) {
    return _then(
      _$AddBookingProductsStateImpl(
        null == products
            ? _value._products
            : products // ignore: cast_nullable_to_non_nullable
                as List<ProductSelectedModel>,
      ),
    );
  }
}

/// @nodoc

class _$AddBookingProductsStateImpl implements _AddBookingProductsState {
  const _$AddBookingProductsStateImpl(final List<ProductSelectedModel> products)
      : _products = products;

  final List<ProductSelectedModel> _products;
  @override
  List<ProductSelectedModel> get products {
    if (_products is EqualUnmodifiableListView) return _products;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_products);
  }

  @override
  String toString() {
    return 'AddBookingProductsState(products: $products)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AddBookingProductsStateImpl &&
            const DeepCollectionEquality().equals(other._products, _products));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_products));

  /// Create a copy of AddBookingProductsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AddBookingProductsStateImplCopyWith<_$AddBookingProductsStateImpl>
      get copyWith => __$$AddBookingProductsStateImplCopyWithImpl<
          _$AddBookingProductsStateImpl>(this, _$identity);
}

abstract class _AddBookingProductsState implements AddBookingProductsState {
  const factory _AddBookingProductsState(
    final List<ProductSelectedModel> products,
  ) = _$AddBookingProductsStateImpl;

  @override
  List<ProductSelectedModel> get products;

  /// Create a copy of AddBookingProductsState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AddBookingProductsStateImplCopyWith<_$AddBookingProductsStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}
