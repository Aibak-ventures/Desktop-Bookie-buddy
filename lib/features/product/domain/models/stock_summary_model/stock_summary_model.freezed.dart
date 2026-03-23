// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'stock_summary_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$StockSummaryModel {

@JsonKey(name: 'total_products') int get totalProducts;@JsonKey(name: 'total_categories') int get totalCategories;@JsonKey(name: 'categories') List<CategorySummary> get categories;
/// Create a copy of StockSummaryModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StockSummaryModelCopyWith<StockSummaryModel> get copyWith => _$StockSummaryModelCopyWithImpl<StockSummaryModel>(this as StockSummaryModel, _$identity);

  /// Serializes this StockSummaryModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StockSummaryModel&&(identical(other.totalProducts, totalProducts) || other.totalProducts == totalProducts)&&(identical(other.totalCategories, totalCategories) || other.totalCategories == totalCategories)&&const DeepCollectionEquality().equals(other.categories, categories));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,totalProducts,totalCategories,const DeepCollectionEquality().hash(categories));

@override
String toString() {
  return 'StockSummaryModel(totalProducts: $totalProducts, totalCategories: $totalCategories, categories: $categories)';
}


}

/// @nodoc
abstract mixin class $StockSummaryModelCopyWith<$Res>  {
  factory $StockSummaryModelCopyWith(StockSummaryModel value, $Res Function(StockSummaryModel) _then) = _$StockSummaryModelCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'total_products') int totalProducts,@JsonKey(name: 'total_categories') int totalCategories,@JsonKey(name: 'categories') List<CategorySummary> categories
});




}
/// @nodoc
class _$StockSummaryModelCopyWithImpl<$Res>
    implements $StockSummaryModelCopyWith<$Res> {
  _$StockSummaryModelCopyWithImpl(this._self, this._then);

  final StockSummaryModel _self;
  final $Res Function(StockSummaryModel) _then;

/// Create a copy of StockSummaryModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? totalProducts = null,Object? totalCategories = null,Object? categories = null,}) {
  return _then(_self.copyWith(
totalProducts: null == totalProducts ? _self.totalProducts : totalProducts // ignore: cast_nullable_to_non_nullable
as int,totalCategories: null == totalCategories ? _self.totalCategories : totalCategories // ignore: cast_nullable_to_non_nullable
as int,categories: null == categories ? _self.categories : categories // ignore: cast_nullable_to_non_nullable
as List<CategorySummary>,
  ));
}

}


/// Adds pattern-matching-related methods to [StockSummaryModel].
extension StockSummaryModelPatterns on StockSummaryModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _StockSummaryModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _StockSummaryModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _StockSummaryModel value)  $default,){
final _that = this;
switch (_that) {
case _StockSummaryModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _StockSummaryModel value)?  $default,){
final _that = this;
switch (_that) {
case _StockSummaryModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'total_products')  int totalProducts, @JsonKey(name: 'total_categories')  int totalCategories, @JsonKey(name: 'categories')  List<CategorySummary> categories)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _StockSummaryModel() when $default != null:
return $default(_that.totalProducts,_that.totalCategories,_that.categories);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'total_products')  int totalProducts, @JsonKey(name: 'total_categories')  int totalCategories, @JsonKey(name: 'categories')  List<CategorySummary> categories)  $default,) {final _that = this;
switch (_that) {
case _StockSummaryModel():
return $default(_that.totalProducts,_that.totalCategories,_that.categories);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'total_products')  int totalProducts, @JsonKey(name: 'total_categories')  int totalCategories, @JsonKey(name: 'categories')  List<CategorySummary> categories)?  $default,) {final _that = this;
switch (_that) {
case _StockSummaryModel() when $default != null:
return $default(_that.totalProducts,_that.totalCategories,_that.categories);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _StockSummaryModel implements StockSummaryModel {
  const _StockSummaryModel({@JsonKey(name: 'total_products') required this.totalProducts, @JsonKey(name: 'total_categories') required this.totalCategories, @JsonKey(name: 'categories') required final  List<CategorySummary> categories}): _categories = categories;
  factory _StockSummaryModel.fromJson(Map<String, dynamic> json) => _$StockSummaryModelFromJson(json);

@override@JsonKey(name: 'total_products') final  int totalProducts;
@override@JsonKey(name: 'total_categories') final  int totalCategories;
 final  List<CategorySummary> _categories;
@override@JsonKey(name: 'categories') List<CategorySummary> get categories {
  if (_categories is EqualUnmodifiableListView) return _categories;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_categories);
}


/// Create a copy of StockSummaryModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StockSummaryModelCopyWith<_StockSummaryModel> get copyWith => __$StockSummaryModelCopyWithImpl<_StockSummaryModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$StockSummaryModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _StockSummaryModel&&(identical(other.totalProducts, totalProducts) || other.totalProducts == totalProducts)&&(identical(other.totalCategories, totalCategories) || other.totalCategories == totalCategories)&&const DeepCollectionEquality().equals(other._categories, _categories));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,totalProducts,totalCategories,const DeepCollectionEquality().hash(_categories));

@override
String toString() {
  return 'StockSummaryModel(totalProducts: $totalProducts, totalCategories: $totalCategories, categories: $categories)';
}


}

/// @nodoc
abstract mixin class _$StockSummaryModelCopyWith<$Res> implements $StockSummaryModelCopyWith<$Res> {
  factory _$StockSummaryModelCopyWith(_StockSummaryModel value, $Res Function(_StockSummaryModel) _then) = __$StockSummaryModelCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'total_products') int totalProducts,@JsonKey(name: 'total_categories') int totalCategories,@JsonKey(name: 'categories') List<CategorySummary> categories
});




}
/// @nodoc
class __$StockSummaryModelCopyWithImpl<$Res>
    implements _$StockSummaryModelCopyWith<$Res> {
  __$StockSummaryModelCopyWithImpl(this._self, this._then);

  final _StockSummaryModel _self;
  final $Res Function(_StockSummaryModel) _then;

/// Create a copy of StockSummaryModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? totalProducts = null,Object? totalCategories = null,Object? categories = null,}) {
  return _then(_StockSummaryModel(
totalProducts: null == totalProducts ? _self.totalProducts : totalProducts // ignore: cast_nullable_to_non_nullable
as int,totalCategories: null == totalCategories ? _self.totalCategories : totalCategories // ignore: cast_nullable_to_non_nullable
as int,categories: null == categories ? _self._categories : categories // ignore: cast_nullable_to_non_nullable
as List<CategorySummary>,
  ));
}


}


/// @nodoc
mixin _$CategorySummary {

 String get name; int get count;
/// Create a copy of CategorySummary
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CategorySummaryCopyWith<CategorySummary> get copyWith => _$CategorySummaryCopyWithImpl<CategorySummary>(this as CategorySummary, _$identity);

  /// Serializes this CategorySummary to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CategorySummary&&(identical(other.name, name) || other.name == name)&&(identical(other.count, count) || other.count == count));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,count);

@override
String toString() {
  return 'CategorySummary(name: $name, count: $count)';
}


}

/// @nodoc
abstract mixin class $CategorySummaryCopyWith<$Res>  {
  factory $CategorySummaryCopyWith(CategorySummary value, $Res Function(CategorySummary) _then) = _$CategorySummaryCopyWithImpl;
@useResult
$Res call({
 String name, int count
});




}
/// @nodoc
class _$CategorySummaryCopyWithImpl<$Res>
    implements $CategorySummaryCopyWith<$Res> {
  _$CategorySummaryCopyWithImpl(this._self, this._then);

  final CategorySummary _self;
  final $Res Function(CategorySummary) _then;

/// Create a copy of CategorySummary
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? count = null,}) {
  return _then(_self.copyWith(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,count: null == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [CategorySummary].
extension CategorySummaryPatterns on CategorySummary {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CategorySummary value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CategorySummary() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CategorySummary value)  $default,){
final _that = this;
switch (_that) {
case _CategorySummary():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CategorySummary value)?  $default,){
final _that = this;
switch (_that) {
case _CategorySummary() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String name,  int count)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CategorySummary() when $default != null:
return $default(_that.name,_that.count);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String name,  int count)  $default,) {final _that = this;
switch (_that) {
case _CategorySummary():
return $default(_that.name,_that.count);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String name,  int count)?  $default,) {final _that = this;
switch (_that) {
case _CategorySummary() when $default != null:
return $default(_that.name,_that.count);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CategorySummary implements CategorySummary {
  const _CategorySummary({required this.name, required this.count});
  factory _CategorySummary.fromJson(Map<String, dynamic> json) => _$CategorySummaryFromJson(json);

@override final  String name;
@override final  int count;

/// Create a copy of CategorySummary
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CategorySummaryCopyWith<_CategorySummary> get copyWith => __$CategorySummaryCopyWithImpl<_CategorySummary>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CategorySummaryToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CategorySummary&&(identical(other.name, name) || other.name == name)&&(identical(other.count, count) || other.count == count));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,count);

@override
String toString() {
  return 'CategorySummary(name: $name, count: $count)';
}


}

/// @nodoc
abstract mixin class _$CategorySummaryCopyWith<$Res> implements $CategorySummaryCopyWith<$Res> {
  factory _$CategorySummaryCopyWith(_CategorySummary value, $Res Function(_CategorySummary) _then) = __$CategorySummaryCopyWithImpl;
@override @useResult
$Res call({
 String name, int count
});




}
/// @nodoc
class __$CategorySummaryCopyWithImpl<$Res>
    implements _$CategorySummaryCopyWith<$Res> {
  __$CategorySummaryCopyWithImpl(this._self, this._then);

  final _CategorySummary _self;
  final $Res Function(_CategorySummary) _then;

/// Create a copy of CategorySummary
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? count = null,}) {
  return _then(_CategorySummary(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,count: null == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
