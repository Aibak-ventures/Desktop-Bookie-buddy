// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'stock_summary_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

StockSummaryModel _$StockSummaryModelFromJson(Map<String, dynamic> json) {
  return _StockSummaryModel.fromJson(json);
}

/// @nodoc
mixin _$StockSummaryModel {
  @JsonKey(name: 'total_products')
  int get totalProducts => throw _privateConstructorUsedError;
  @JsonKey(name: 'total_categories')
  int get totalCategories => throw _privateConstructorUsedError;
  @JsonKey(name: 'categories')
  List<CategorySummary> get categories => throw _privateConstructorUsedError;

  /// Serializes this StockSummaryModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of StockSummaryModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $StockSummaryModelCopyWith<StockSummaryModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StockSummaryModelCopyWith<$Res> {
  factory $StockSummaryModelCopyWith(
          StockSummaryModel value, $Res Function(StockSummaryModel) then) =
      _$StockSummaryModelCopyWithImpl<$Res, StockSummaryModel>;
  @useResult
  $Res call(
      {@JsonKey(name: 'total_products') int totalProducts,
      @JsonKey(name: 'total_categories') int totalCategories,
      @JsonKey(name: 'categories') List<CategorySummary> categories});
}

/// @nodoc
class _$StockSummaryModelCopyWithImpl<$Res, $Val extends StockSummaryModel>
    implements $StockSummaryModelCopyWith<$Res> {
  _$StockSummaryModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of StockSummaryModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalProducts = null,
    Object? totalCategories = null,
    Object? categories = null,
  }) {
    return _then(_value.copyWith(
      totalProducts: null == totalProducts
          ? _value.totalProducts
          : totalProducts // ignore: cast_nullable_to_non_nullable
              as int,
      totalCategories: null == totalCategories
          ? _value.totalCategories
          : totalCategories // ignore: cast_nullable_to_non_nullable
              as int,
      categories: null == categories
          ? _value.categories
          : categories // ignore: cast_nullable_to_non_nullable
              as List<CategorySummary>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$StockSummaryModelImplCopyWith<$Res>
    implements $StockSummaryModelCopyWith<$Res> {
  factory _$$StockSummaryModelImplCopyWith(_$StockSummaryModelImpl value,
          $Res Function(_$StockSummaryModelImpl) then) =
      __$$StockSummaryModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'total_products') int totalProducts,
      @JsonKey(name: 'total_categories') int totalCategories,
      @JsonKey(name: 'categories') List<CategorySummary> categories});
}

/// @nodoc
class __$$StockSummaryModelImplCopyWithImpl<$Res>
    extends _$StockSummaryModelCopyWithImpl<$Res, _$StockSummaryModelImpl>
    implements _$$StockSummaryModelImplCopyWith<$Res> {
  __$$StockSummaryModelImplCopyWithImpl(_$StockSummaryModelImpl _value,
      $Res Function(_$StockSummaryModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of StockSummaryModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalProducts = null,
    Object? totalCategories = null,
    Object? categories = null,
  }) {
    return _then(_$StockSummaryModelImpl(
      totalProducts: null == totalProducts
          ? _value.totalProducts
          : totalProducts // ignore: cast_nullable_to_non_nullable
              as int,
      totalCategories: null == totalCategories
          ? _value.totalCategories
          : totalCategories // ignore: cast_nullable_to_non_nullable
              as int,
      categories: null == categories
          ? _value._categories
          : categories // ignore: cast_nullable_to_non_nullable
              as List<CategorySummary>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$StockSummaryModelImpl implements _StockSummaryModel {
  const _$StockSummaryModelImpl(
      {@JsonKey(name: 'total_products') required this.totalProducts,
      @JsonKey(name: 'total_categories') required this.totalCategories,
      @JsonKey(name: 'categories')
      required final List<CategorySummary> categories})
      : _categories = categories;

  factory _$StockSummaryModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$StockSummaryModelImplFromJson(json);

  @override
  @JsonKey(name: 'total_products')
  final int totalProducts;
  @override
  @JsonKey(name: 'total_categories')
  final int totalCategories;
  final List<CategorySummary> _categories;
  @override
  @JsonKey(name: 'categories')
  List<CategorySummary> get categories {
    if (_categories is EqualUnmodifiableListView) return _categories;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_categories);
  }

  @override
  String toString() {
    return 'StockSummaryModel(totalProducts: $totalProducts, totalCategories: $totalCategories, categories: $categories)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StockSummaryModelImpl &&
            (identical(other.totalProducts, totalProducts) ||
                other.totalProducts == totalProducts) &&
            (identical(other.totalCategories, totalCategories) ||
                other.totalCategories == totalCategories) &&
            const DeepCollectionEquality()
                .equals(other._categories, _categories));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, totalProducts, totalCategories,
      const DeepCollectionEquality().hash(_categories));

  /// Create a copy of StockSummaryModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$StockSummaryModelImplCopyWith<_$StockSummaryModelImpl> get copyWith =>
      __$$StockSummaryModelImplCopyWithImpl<_$StockSummaryModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$StockSummaryModelImplToJson(
      this,
    );
  }
}

abstract class _StockSummaryModel implements StockSummaryModel {
  const factory _StockSummaryModel(
          {@JsonKey(name: 'total_products') required final int totalProducts,
          @JsonKey(name: 'total_categories') required final int totalCategories,
          @JsonKey(name: 'categories')
          required final List<CategorySummary> categories}) =
      _$StockSummaryModelImpl;

  factory _StockSummaryModel.fromJson(Map<String, dynamic> json) =
      _$StockSummaryModelImpl.fromJson;

  @override
  @JsonKey(name: 'total_products')
  int get totalProducts;
  @override
  @JsonKey(name: 'total_categories')
  int get totalCategories;
  @override
  @JsonKey(name: 'categories')
  List<CategorySummary> get categories;

  /// Create a copy of StockSummaryModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$StockSummaryModelImplCopyWith<_$StockSummaryModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

CategorySummary _$CategorySummaryFromJson(Map<String, dynamic> json) {
  return _CategorySummary.fromJson(json);
}

/// @nodoc
mixin _$CategorySummary {
  String get name => throw _privateConstructorUsedError;
  int get count => throw _privateConstructorUsedError;

  /// Serializes this CategorySummary to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CategorySummary
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CategorySummaryCopyWith<CategorySummary> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CategorySummaryCopyWith<$Res> {
  factory $CategorySummaryCopyWith(
          CategorySummary value, $Res Function(CategorySummary) then) =
      _$CategorySummaryCopyWithImpl<$Res, CategorySummary>;
  @useResult
  $Res call({String name, int count});
}

/// @nodoc
class _$CategorySummaryCopyWithImpl<$Res, $Val extends CategorySummary>
    implements $CategorySummaryCopyWith<$Res> {
  _$CategorySummaryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CategorySummary
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? count = null,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      count: null == count
          ? _value.count
          : count // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CategorySummaryImplCopyWith<$Res>
    implements $CategorySummaryCopyWith<$Res> {
  factory _$$CategorySummaryImplCopyWith(_$CategorySummaryImpl value,
          $Res Function(_$CategorySummaryImpl) then) =
      __$$CategorySummaryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String name, int count});
}

/// @nodoc
class __$$CategorySummaryImplCopyWithImpl<$Res>
    extends _$CategorySummaryCopyWithImpl<$Res, _$CategorySummaryImpl>
    implements _$$CategorySummaryImplCopyWith<$Res> {
  __$$CategorySummaryImplCopyWithImpl(
      _$CategorySummaryImpl _value, $Res Function(_$CategorySummaryImpl) _then)
      : super(_value, _then);

  /// Create a copy of CategorySummary
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? count = null,
  }) {
    return _then(_$CategorySummaryImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      count: null == count
          ? _value.count
          : count // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CategorySummaryImpl implements _CategorySummary {
  const _$CategorySummaryImpl({required this.name, required this.count});

  factory _$CategorySummaryImpl.fromJson(Map<String, dynamic> json) =>
      _$$CategorySummaryImplFromJson(json);

  @override
  final String name;
  @override
  final int count;

  @override
  String toString() {
    return 'CategorySummary(name: $name, count: $count)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CategorySummaryImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.count, count) || other.count == count));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, name, count);

  /// Create a copy of CategorySummary
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CategorySummaryImplCopyWith<_$CategorySummaryImpl> get copyWith =>
      __$$CategorySummaryImplCopyWithImpl<_$CategorySummaryImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CategorySummaryImplToJson(
      this,
    );
  }
}

abstract class _CategorySummary implements CategorySummary {
  const factory _CategorySummary(
      {required final String name,
      required final int count}) = _$CategorySummaryImpl;

  factory _CategorySummary.fromJson(Map<String, dynamic> json) =
      _$CategorySummaryImpl.fromJson;

  @override
  String get name;
  @override
  int get count;

  /// Create a copy of CategorySummary
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CategorySummaryImplCopyWith<_$CategorySummaryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
