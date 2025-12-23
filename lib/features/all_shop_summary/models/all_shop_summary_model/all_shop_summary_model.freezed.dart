// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'all_shop_summary_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

AllShopSummaryModel _$AllShopSummaryModelFromJson(Map<String, dynamic> json) {
  return _AllShopSummaryModel.fromJson(json);
}

/// @nodoc
mixin _$AllShopSummaryModel {
  @JsonKey(name: 'overall')
  AllShopSummaryOverallRevenueModel get overallRevenue =>
      throw _privateConstructorUsedError;
  @JsonKey(name: 'shops')
  List<AllShopSummaryShopModel> get shops => throw _privateConstructorUsedError;

  /// Serializes this AllShopSummaryModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AllShopSummaryModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AllShopSummaryModelCopyWith<AllShopSummaryModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AllShopSummaryModelCopyWith<$Res> {
  factory $AllShopSummaryModelCopyWith(
          AllShopSummaryModel value, $Res Function(AllShopSummaryModel) then) =
      _$AllShopSummaryModelCopyWithImpl<$Res, AllShopSummaryModel>;
  @useResult
  $Res call(
      {@JsonKey(name: 'overall')
      AllShopSummaryOverallRevenueModel overallRevenue,
      @JsonKey(name: 'shops') List<AllShopSummaryShopModel> shops});

  $AllShopSummaryOverallRevenueModelCopyWith<$Res> get overallRevenue;
}

/// @nodoc
class _$AllShopSummaryModelCopyWithImpl<$Res, $Val extends AllShopSummaryModel>
    implements $AllShopSummaryModelCopyWith<$Res> {
  _$AllShopSummaryModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AllShopSummaryModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? overallRevenue = null,
    Object? shops = null,
  }) {
    return _then(_value.copyWith(
      overallRevenue: null == overallRevenue
          ? _value.overallRevenue
          : overallRevenue // ignore: cast_nullable_to_non_nullable
              as AllShopSummaryOverallRevenueModel,
      shops: null == shops
          ? _value.shops
          : shops // ignore: cast_nullable_to_non_nullable
              as List<AllShopSummaryShopModel>,
    ) as $Val);
  }

  /// Create a copy of AllShopSummaryModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AllShopSummaryOverallRevenueModelCopyWith<$Res> get overallRevenue {
    return $AllShopSummaryOverallRevenueModelCopyWith<$Res>(
        _value.overallRevenue, (value) {
      return _then(_value.copyWith(overallRevenue: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$AllShopSummaryModelImplCopyWith<$Res>
    implements $AllShopSummaryModelCopyWith<$Res> {
  factory _$$AllShopSummaryModelImplCopyWith(_$AllShopSummaryModelImpl value,
          $Res Function(_$AllShopSummaryModelImpl) then) =
      __$$AllShopSummaryModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'overall')
      AllShopSummaryOverallRevenueModel overallRevenue,
      @JsonKey(name: 'shops') List<AllShopSummaryShopModel> shops});

  @override
  $AllShopSummaryOverallRevenueModelCopyWith<$Res> get overallRevenue;
}

/// @nodoc
class __$$AllShopSummaryModelImplCopyWithImpl<$Res>
    extends _$AllShopSummaryModelCopyWithImpl<$Res, _$AllShopSummaryModelImpl>
    implements _$$AllShopSummaryModelImplCopyWith<$Res> {
  __$$AllShopSummaryModelImplCopyWithImpl(_$AllShopSummaryModelImpl _value,
      $Res Function(_$AllShopSummaryModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of AllShopSummaryModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? overallRevenue = null,
    Object? shops = null,
  }) {
    return _then(_$AllShopSummaryModelImpl(
      overallRevenue: null == overallRevenue
          ? _value.overallRevenue
          : overallRevenue // ignore: cast_nullable_to_non_nullable
              as AllShopSummaryOverallRevenueModel,
      shops: null == shops
          ? _value._shops
          : shops // ignore: cast_nullable_to_non_nullable
              as List<AllShopSummaryShopModel>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AllShopSummaryModelImpl implements _AllShopSummaryModel {
  const _$AllShopSummaryModelImpl(
      {@JsonKey(name: 'overall') required this.overallRevenue,
      @JsonKey(name: 'shops')
      required final List<AllShopSummaryShopModel> shops})
      : _shops = shops;

  factory _$AllShopSummaryModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$AllShopSummaryModelImplFromJson(json);

  @override
  @JsonKey(name: 'overall')
  final AllShopSummaryOverallRevenueModel overallRevenue;
  final List<AllShopSummaryShopModel> _shops;
  @override
  @JsonKey(name: 'shops')
  List<AllShopSummaryShopModel> get shops {
    if (_shops is EqualUnmodifiableListView) return _shops;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_shops);
  }

  @override
  String toString() {
    return 'AllShopSummaryModel(overallRevenue: $overallRevenue, shops: $shops)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AllShopSummaryModelImpl &&
            (identical(other.overallRevenue, overallRevenue) ||
                other.overallRevenue == overallRevenue) &&
            const DeepCollectionEquality().equals(other._shops, _shops));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, overallRevenue, const DeepCollectionEquality().hash(_shops));

  /// Create a copy of AllShopSummaryModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AllShopSummaryModelImplCopyWith<_$AllShopSummaryModelImpl> get copyWith =>
      __$$AllShopSummaryModelImplCopyWithImpl<_$AllShopSummaryModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AllShopSummaryModelImplToJson(
      this,
    );
  }
}

abstract class _AllShopSummaryModel implements AllShopSummaryModel {
  const factory _AllShopSummaryModel(
          {@JsonKey(name: 'overall')
          required final AllShopSummaryOverallRevenueModel overallRevenue,
          @JsonKey(name: 'shops')
          required final List<AllShopSummaryShopModel> shops}) =
      _$AllShopSummaryModelImpl;

  factory _AllShopSummaryModel.fromJson(Map<String, dynamic> json) =
      _$AllShopSummaryModelImpl.fromJson;

  @override
  @JsonKey(name: 'overall')
  AllShopSummaryOverallRevenueModel get overallRevenue;
  @override
  @JsonKey(name: 'shops')
  List<AllShopSummaryShopModel> get shops;

  /// Create a copy of AllShopSummaryModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AllShopSummaryModelImplCopyWith<_$AllShopSummaryModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

AllShopSummaryOverallRevenueModel _$AllShopSummaryOverallRevenueModelFromJson(
    Map<String, dynamic> json) {
  return _AllShopSummaryOverallRevenueModel.fromJson(json);
}

/// @nodoc
mixin _$AllShopSummaryOverallRevenueModel {
  @JsonKey(name: 'revenue', defaultValue: 0)
  int get totalRevenue => throw _privateConstructorUsedError;
  @JsonKey(name: 'expense', defaultValue: 0)
  int get totalExpense => throw _privateConstructorUsedError;
  @JsonKey(name: 'profit', defaultValue: 0)
  int get totalProfit => throw _privateConstructorUsedError;
  @JsonKey(name: 'revenue_growth', defaultValue: 0)
  int get revenueGrowth => throw _privateConstructorUsedError;
  @JsonKey(name: 'expense_growth', defaultValue: 0)
  int get expenseGrowth => throw _privateConstructorUsedError;
  @JsonKey(name: 'profit_growth', defaultValue: 0)
  int get profitGrowth => throw _privateConstructorUsedError;

  /// Serializes this AllShopSummaryOverallRevenueModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AllShopSummaryOverallRevenueModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AllShopSummaryOverallRevenueModelCopyWith<AllShopSummaryOverallRevenueModel>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AllShopSummaryOverallRevenueModelCopyWith<$Res> {
  factory $AllShopSummaryOverallRevenueModelCopyWith(
          AllShopSummaryOverallRevenueModel value,
          $Res Function(AllShopSummaryOverallRevenueModel) then) =
      _$AllShopSummaryOverallRevenueModelCopyWithImpl<$Res,
          AllShopSummaryOverallRevenueModel>;
  @useResult
  $Res call(
      {@JsonKey(name: 'revenue', defaultValue: 0) int totalRevenue,
      @JsonKey(name: 'expense', defaultValue: 0) int totalExpense,
      @JsonKey(name: 'profit', defaultValue: 0) int totalProfit,
      @JsonKey(name: 'revenue_growth', defaultValue: 0) int revenueGrowth,
      @JsonKey(name: 'expense_growth', defaultValue: 0) int expenseGrowth,
      @JsonKey(name: 'profit_growth', defaultValue: 0) int profitGrowth});
}

/// @nodoc
class _$AllShopSummaryOverallRevenueModelCopyWithImpl<$Res,
        $Val extends AllShopSummaryOverallRevenueModel>
    implements $AllShopSummaryOverallRevenueModelCopyWith<$Res> {
  _$AllShopSummaryOverallRevenueModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AllShopSummaryOverallRevenueModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalRevenue = null,
    Object? totalExpense = null,
    Object? totalProfit = null,
    Object? revenueGrowth = null,
    Object? expenseGrowth = null,
    Object? profitGrowth = null,
  }) {
    return _then(_value.copyWith(
      totalRevenue: null == totalRevenue
          ? _value.totalRevenue
          : totalRevenue // ignore: cast_nullable_to_non_nullable
              as int,
      totalExpense: null == totalExpense
          ? _value.totalExpense
          : totalExpense // ignore: cast_nullable_to_non_nullable
              as int,
      totalProfit: null == totalProfit
          ? _value.totalProfit
          : totalProfit // ignore: cast_nullable_to_non_nullable
              as int,
      revenueGrowth: null == revenueGrowth
          ? _value.revenueGrowth
          : revenueGrowth // ignore: cast_nullable_to_non_nullable
              as int,
      expenseGrowth: null == expenseGrowth
          ? _value.expenseGrowth
          : expenseGrowth // ignore: cast_nullable_to_non_nullable
              as int,
      profitGrowth: null == profitGrowth
          ? _value.profitGrowth
          : profitGrowth // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AllShopSummaryOverallRevenueModelImplCopyWith<$Res>
    implements $AllShopSummaryOverallRevenueModelCopyWith<$Res> {
  factory _$$AllShopSummaryOverallRevenueModelImplCopyWith(
          _$AllShopSummaryOverallRevenueModelImpl value,
          $Res Function(_$AllShopSummaryOverallRevenueModelImpl) then) =
      __$$AllShopSummaryOverallRevenueModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'revenue', defaultValue: 0) int totalRevenue,
      @JsonKey(name: 'expense', defaultValue: 0) int totalExpense,
      @JsonKey(name: 'profit', defaultValue: 0) int totalProfit,
      @JsonKey(name: 'revenue_growth', defaultValue: 0) int revenueGrowth,
      @JsonKey(name: 'expense_growth', defaultValue: 0) int expenseGrowth,
      @JsonKey(name: 'profit_growth', defaultValue: 0) int profitGrowth});
}

/// @nodoc
class __$$AllShopSummaryOverallRevenueModelImplCopyWithImpl<$Res>
    extends _$AllShopSummaryOverallRevenueModelCopyWithImpl<$Res,
        _$AllShopSummaryOverallRevenueModelImpl>
    implements _$$AllShopSummaryOverallRevenueModelImplCopyWith<$Res> {
  __$$AllShopSummaryOverallRevenueModelImplCopyWithImpl(
      _$AllShopSummaryOverallRevenueModelImpl _value,
      $Res Function(_$AllShopSummaryOverallRevenueModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of AllShopSummaryOverallRevenueModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalRevenue = null,
    Object? totalExpense = null,
    Object? totalProfit = null,
    Object? revenueGrowth = null,
    Object? expenseGrowth = null,
    Object? profitGrowth = null,
  }) {
    return _then(_$AllShopSummaryOverallRevenueModelImpl(
      totalRevenue: null == totalRevenue
          ? _value.totalRevenue
          : totalRevenue // ignore: cast_nullable_to_non_nullable
              as int,
      totalExpense: null == totalExpense
          ? _value.totalExpense
          : totalExpense // ignore: cast_nullable_to_non_nullable
              as int,
      totalProfit: null == totalProfit
          ? _value.totalProfit
          : totalProfit // ignore: cast_nullable_to_non_nullable
              as int,
      revenueGrowth: null == revenueGrowth
          ? _value.revenueGrowth
          : revenueGrowth // ignore: cast_nullable_to_non_nullable
              as int,
      expenseGrowth: null == expenseGrowth
          ? _value.expenseGrowth
          : expenseGrowth // ignore: cast_nullable_to_non_nullable
              as int,
      profitGrowth: null == profitGrowth
          ? _value.profitGrowth
          : profitGrowth // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AllShopSummaryOverallRevenueModelImpl
    implements _AllShopSummaryOverallRevenueModel {
  const _$AllShopSummaryOverallRevenueModelImpl(
      {@JsonKey(name: 'revenue', defaultValue: 0) required this.totalRevenue,
      @JsonKey(name: 'expense', defaultValue: 0) required this.totalExpense,
      @JsonKey(name: 'profit', defaultValue: 0) required this.totalProfit,
      @JsonKey(name: 'revenue_growth', defaultValue: 0)
      required this.revenueGrowth,
      @JsonKey(name: 'expense_growth', defaultValue: 0)
      required this.expenseGrowth,
      @JsonKey(name: 'profit_growth', defaultValue: 0)
      required this.profitGrowth});

  factory _$AllShopSummaryOverallRevenueModelImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$AllShopSummaryOverallRevenueModelImplFromJson(json);

  @override
  @JsonKey(name: 'revenue', defaultValue: 0)
  final int totalRevenue;
  @override
  @JsonKey(name: 'expense', defaultValue: 0)
  final int totalExpense;
  @override
  @JsonKey(name: 'profit', defaultValue: 0)
  final int totalProfit;
  @override
  @JsonKey(name: 'revenue_growth', defaultValue: 0)
  final int revenueGrowth;
  @override
  @JsonKey(name: 'expense_growth', defaultValue: 0)
  final int expenseGrowth;
  @override
  @JsonKey(name: 'profit_growth', defaultValue: 0)
  final int profitGrowth;

  @override
  String toString() {
    return 'AllShopSummaryOverallRevenueModel(totalRevenue: $totalRevenue, totalExpense: $totalExpense, totalProfit: $totalProfit, revenueGrowth: $revenueGrowth, expenseGrowth: $expenseGrowth, profitGrowth: $profitGrowth)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AllShopSummaryOverallRevenueModelImpl &&
            (identical(other.totalRevenue, totalRevenue) ||
                other.totalRevenue == totalRevenue) &&
            (identical(other.totalExpense, totalExpense) ||
                other.totalExpense == totalExpense) &&
            (identical(other.totalProfit, totalProfit) ||
                other.totalProfit == totalProfit) &&
            (identical(other.revenueGrowth, revenueGrowth) ||
                other.revenueGrowth == revenueGrowth) &&
            (identical(other.expenseGrowth, expenseGrowth) ||
                other.expenseGrowth == expenseGrowth) &&
            (identical(other.profitGrowth, profitGrowth) ||
                other.profitGrowth == profitGrowth));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, totalRevenue, totalExpense,
      totalProfit, revenueGrowth, expenseGrowth, profitGrowth);

  /// Create a copy of AllShopSummaryOverallRevenueModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AllShopSummaryOverallRevenueModelImplCopyWith<
          _$AllShopSummaryOverallRevenueModelImpl>
      get copyWith => __$$AllShopSummaryOverallRevenueModelImplCopyWithImpl<
          _$AllShopSummaryOverallRevenueModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AllShopSummaryOverallRevenueModelImplToJson(
      this,
    );
  }
}

abstract class _AllShopSummaryOverallRevenueModel
    implements AllShopSummaryOverallRevenueModel {
  const factory _AllShopSummaryOverallRevenueModel(
      {@JsonKey(name: 'revenue', defaultValue: 0)
      required final int totalRevenue,
      @JsonKey(name: 'expense', defaultValue: 0)
      required final int totalExpense,
      @JsonKey(name: 'profit', defaultValue: 0) required final int totalProfit,
      @JsonKey(name: 'revenue_growth', defaultValue: 0)
      required final int revenueGrowth,
      @JsonKey(name: 'expense_growth', defaultValue: 0)
      required final int expenseGrowth,
      @JsonKey(name: 'profit_growth', defaultValue: 0)
      required final int
          profitGrowth}) = _$AllShopSummaryOverallRevenueModelImpl;

  factory _AllShopSummaryOverallRevenueModel.fromJson(
          Map<String, dynamic> json) =
      _$AllShopSummaryOverallRevenueModelImpl.fromJson;

  @override
  @JsonKey(name: 'revenue', defaultValue: 0)
  int get totalRevenue;
  @override
  @JsonKey(name: 'expense', defaultValue: 0)
  int get totalExpense;
  @override
  @JsonKey(name: 'profit', defaultValue: 0)
  int get totalProfit;
  @override
  @JsonKey(name: 'revenue_growth', defaultValue: 0)
  int get revenueGrowth;
  @override
  @JsonKey(name: 'expense_growth', defaultValue: 0)
  int get expenseGrowth;
  @override
  @JsonKey(name: 'profit_growth', defaultValue: 0)
  int get profitGrowth;

  /// Create a copy of AllShopSummaryOverallRevenueModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AllShopSummaryOverallRevenueModelImplCopyWith<
          _$AllShopSummaryOverallRevenueModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}

AllShopSummaryShopModel _$AllShopSummaryShopModelFromJson(
    Map<String, dynamic> json) {
  return _AllShopSummaryShopModel.fromJson(json);
}

/// @nodoc
mixin _$AllShopSummaryShopModel {
  @JsonKey(name: 'shop_id')
  int get shopId => throw _privateConstructorUsedError;
  @JsonKey(name: 'shop_name')
  String get shopName => throw _privateConstructorUsedError;
  @JsonKey(name: 'shop_address', defaultValue: '')
  String get shopAddress => throw _privateConstructorUsedError;
  @JsonKey(name: 'months')
  List<AllShopSummaryShopMonthlyDetailsModel> get monthlyDetails =>
      throw _privateConstructorUsedError;
  @JsonKey(name: 'totals')
  AllShopSummaryOverallRevenueModel get overallRevenue =>
      throw _privateConstructorUsedError;

  /// Serializes this AllShopSummaryShopModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AllShopSummaryShopModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AllShopSummaryShopModelCopyWith<AllShopSummaryShopModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AllShopSummaryShopModelCopyWith<$Res> {
  factory $AllShopSummaryShopModelCopyWith(AllShopSummaryShopModel value,
          $Res Function(AllShopSummaryShopModel) then) =
      _$AllShopSummaryShopModelCopyWithImpl<$Res, AllShopSummaryShopModel>;
  @useResult
  $Res call(
      {@JsonKey(name: 'shop_id') int shopId,
      @JsonKey(name: 'shop_name') String shopName,
      @JsonKey(name: 'shop_address', defaultValue: '') String shopAddress,
      @JsonKey(name: 'months')
      List<AllShopSummaryShopMonthlyDetailsModel> monthlyDetails,
      @JsonKey(name: 'totals')
      AllShopSummaryOverallRevenueModel overallRevenue});

  $AllShopSummaryOverallRevenueModelCopyWith<$Res> get overallRevenue;
}

/// @nodoc
class _$AllShopSummaryShopModelCopyWithImpl<$Res,
        $Val extends AllShopSummaryShopModel>
    implements $AllShopSummaryShopModelCopyWith<$Res> {
  _$AllShopSummaryShopModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AllShopSummaryShopModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? shopId = null,
    Object? shopName = null,
    Object? shopAddress = null,
    Object? monthlyDetails = null,
    Object? overallRevenue = null,
  }) {
    return _then(_value.copyWith(
      shopId: null == shopId
          ? _value.shopId
          : shopId // ignore: cast_nullable_to_non_nullable
              as int,
      shopName: null == shopName
          ? _value.shopName
          : shopName // ignore: cast_nullable_to_non_nullable
              as String,
      shopAddress: null == shopAddress
          ? _value.shopAddress
          : shopAddress // ignore: cast_nullable_to_non_nullable
              as String,
      monthlyDetails: null == monthlyDetails
          ? _value.monthlyDetails
          : monthlyDetails // ignore: cast_nullable_to_non_nullable
              as List<AllShopSummaryShopMonthlyDetailsModel>,
      overallRevenue: null == overallRevenue
          ? _value.overallRevenue
          : overallRevenue // ignore: cast_nullable_to_non_nullable
              as AllShopSummaryOverallRevenueModel,
    ) as $Val);
  }

  /// Create a copy of AllShopSummaryShopModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AllShopSummaryOverallRevenueModelCopyWith<$Res> get overallRevenue {
    return $AllShopSummaryOverallRevenueModelCopyWith<$Res>(
        _value.overallRevenue, (value) {
      return _then(_value.copyWith(overallRevenue: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$AllShopSummaryShopModelImplCopyWith<$Res>
    implements $AllShopSummaryShopModelCopyWith<$Res> {
  factory _$$AllShopSummaryShopModelImplCopyWith(
          _$AllShopSummaryShopModelImpl value,
          $Res Function(_$AllShopSummaryShopModelImpl) then) =
      __$$AllShopSummaryShopModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'shop_id') int shopId,
      @JsonKey(name: 'shop_name') String shopName,
      @JsonKey(name: 'shop_address', defaultValue: '') String shopAddress,
      @JsonKey(name: 'months')
      List<AllShopSummaryShopMonthlyDetailsModel> monthlyDetails,
      @JsonKey(name: 'totals')
      AllShopSummaryOverallRevenueModel overallRevenue});

  @override
  $AllShopSummaryOverallRevenueModelCopyWith<$Res> get overallRevenue;
}

/// @nodoc
class __$$AllShopSummaryShopModelImplCopyWithImpl<$Res>
    extends _$AllShopSummaryShopModelCopyWithImpl<$Res,
        _$AllShopSummaryShopModelImpl>
    implements _$$AllShopSummaryShopModelImplCopyWith<$Res> {
  __$$AllShopSummaryShopModelImplCopyWithImpl(
      _$AllShopSummaryShopModelImpl _value,
      $Res Function(_$AllShopSummaryShopModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of AllShopSummaryShopModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? shopId = null,
    Object? shopName = null,
    Object? shopAddress = null,
    Object? monthlyDetails = null,
    Object? overallRevenue = null,
  }) {
    return _then(_$AllShopSummaryShopModelImpl(
      shopId: null == shopId
          ? _value.shopId
          : shopId // ignore: cast_nullable_to_non_nullable
              as int,
      shopName: null == shopName
          ? _value.shopName
          : shopName // ignore: cast_nullable_to_non_nullable
              as String,
      shopAddress: null == shopAddress
          ? _value.shopAddress
          : shopAddress // ignore: cast_nullable_to_non_nullable
              as String,
      monthlyDetails: null == monthlyDetails
          ? _value._monthlyDetails
          : monthlyDetails // ignore: cast_nullable_to_non_nullable
              as List<AllShopSummaryShopMonthlyDetailsModel>,
      overallRevenue: null == overallRevenue
          ? _value.overallRevenue
          : overallRevenue // ignore: cast_nullable_to_non_nullable
              as AllShopSummaryOverallRevenueModel,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AllShopSummaryShopModelImpl implements _AllShopSummaryShopModel {
  const _$AllShopSummaryShopModelImpl(
      {@JsonKey(name: 'shop_id') required this.shopId,
      @JsonKey(name: 'shop_name') required this.shopName,
      @JsonKey(name: 'shop_address', defaultValue: '')
      required this.shopAddress,
      @JsonKey(name: 'months')
      required final List<AllShopSummaryShopMonthlyDetailsModel> monthlyDetails,
      @JsonKey(name: 'totals') required this.overallRevenue})
      : _monthlyDetails = monthlyDetails;

  factory _$AllShopSummaryShopModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$AllShopSummaryShopModelImplFromJson(json);

  @override
  @JsonKey(name: 'shop_id')
  final int shopId;
  @override
  @JsonKey(name: 'shop_name')
  final String shopName;
  @override
  @JsonKey(name: 'shop_address', defaultValue: '')
  final String shopAddress;
  final List<AllShopSummaryShopMonthlyDetailsModel> _monthlyDetails;
  @override
  @JsonKey(name: 'months')
  List<AllShopSummaryShopMonthlyDetailsModel> get monthlyDetails {
    if (_monthlyDetails is EqualUnmodifiableListView) return _monthlyDetails;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_monthlyDetails);
  }

  @override
  @JsonKey(name: 'totals')
  final AllShopSummaryOverallRevenueModel overallRevenue;

  @override
  String toString() {
    return 'AllShopSummaryShopModel(shopId: $shopId, shopName: $shopName, shopAddress: $shopAddress, monthlyDetails: $monthlyDetails, overallRevenue: $overallRevenue)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AllShopSummaryShopModelImpl &&
            (identical(other.shopId, shopId) || other.shopId == shopId) &&
            (identical(other.shopName, shopName) ||
                other.shopName == shopName) &&
            (identical(other.shopAddress, shopAddress) ||
                other.shopAddress == shopAddress) &&
            const DeepCollectionEquality()
                .equals(other._monthlyDetails, _monthlyDetails) &&
            (identical(other.overallRevenue, overallRevenue) ||
                other.overallRevenue == overallRevenue));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, shopId, shopName, shopAddress,
      const DeepCollectionEquality().hash(_monthlyDetails), overallRevenue);

  /// Create a copy of AllShopSummaryShopModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AllShopSummaryShopModelImplCopyWith<_$AllShopSummaryShopModelImpl>
      get copyWith => __$$AllShopSummaryShopModelImplCopyWithImpl<
          _$AllShopSummaryShopModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AllShopSummaryShopModelImplToJson(
      this,
    );
  }
}

abstract class _AllShopSummaryShopModel implements AllShopSummaryShopModel {
  const factory _AllShopSummaryShopModel(
      {@JsonKey(name: 'shop_id') required final int shopId,
      @JsonKey(name: 'shop_name') required final String shopName,
      @JsonKey(name: 'shop_address', defaultValue: '')
      required final String shopAddress,
      @JsonKey(name: 'months')
      required final List<AllShopSummaryShopMonthlyDetailsModel> monthlyDetails,
      @JsonKey(name: 'totals')
      required final AllShopSummaryOverallRevenueModel
          overallRevenue}) = _$AllShopSummaryShopModelImpl;

  factory _AllShopSummaryShopModel.fromJson(Map<String, dynamic> json) =
      _$AllShopSummaryShopModelImpl.fromJson;

  @override
  @JsonKey(name: 'shop_id')
  int get shopId;
  @override
  @JsonKey(name: 'shop_name')
  String get shopName;
  @override
  @JsonKey(name: 'shop_address', defaultValue: '')
  String get shopAddress;
  @override
  @JsonKey(name: 'months')
  List<AllShopSummaryShopMonthlyDetailsModel> get monthlyDetails;
  @override
  @JsonKey(name: 'totals')
  AllShopSummaryOverallRevenueModel get overallRevenue;

  /// Create a copy of AllShopSummaryShopModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AllShopSummaryShopModelImplCopyWith<_$AllShopSummaryShopModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}

AllShopSummaryShopMonthlyDetailsModel
    _$AllShopSummaryShopMonthlyDetailsModelFromJson(Map<String, dynamic> json) {
  return _AllShopSummaryShopMonthlyDetailsModel.fromJson(json);
}

/// @nodoc
mixin _$AllShopSummaryShopMonthlyDetailsModel {
  @JsonKey(name: 'month', defaultValue: 1)
  int get month => throw _privateConstructorUsedError;
  @JsonKey(name: 'month_name')
  String get monthName => throw _privateConstructorUsedError;
  @JsonKey(name: 'bookings_count', defaultValue: 0)
  int get bookingsCount => throw _privateConstructorUsedError;
  @JsonKey(name: 'bookings_earnings', defaultValue: 0)
  int get bookingsEarnings => throw _privateConstructorUsedError;
  @JsonKey(name: 'sales_count', defaultValue: 0)
  int get salesCount => throw _privateConstructorUsedError;
  @JsonKey(name: 'sales_earnings', defaultValue: 0)
  int get salesEarnings => throw _privateConstructorUsedError;
  @JsonKey(name: 'total_revenue', defaultValue: 0)
  int get totalRevenue => throw _privateConstructorUsedError;
  @JsonKey(name: 'total_expense', defaultValue: 0)
  int get totalExpense => throw _privateConstructorUsedError;
  @JsonKey(
      name: 'expense_breakdown',
      defaultValue: {},
      fromJson: _expenseBreakdownFromJson)
  Map<String, int> get expenseBreakdown => throw _privateConstructorUsedError;
  @JsonKey(name: 'profit', defaultValue: 0)
  int get profit => throw _privateConstructorUsedError;
  @JsonKey(name: 'growth', defaultValue: 0)
  int get growth => throw _privateConstructorUsedError;

  /// Serializes this AllShopSummaryShopMonthlyDetailsModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AllShopSummaryShopMonthlyDetailsModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AllShopSummaryShopMonthlyDetailsModelCopyWith<
          AllShopSummaryShopMonthlyDetailsModel>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AllShopSummaryShopMonthlyDetailsModelCopyWith<$Res> {
  factory $AllShopSummaryShopMonthlyDetailsModelCopyWith(
          AllShopSummaryShopMonthlyDetailsModel value,
          $Res Function(AllShopSummaryShopMonthlyDetailsModel) then) =
      _$AllShopSummaryShopMonthlyDetailsModelCopyWithImpl<$Res,
          AllShopSummaryShopMonthlyDetailsModel>;
  @useResult
  $Res call(
      {@JsonKey(name: 'month', defaultValue: 1) int month,
      @JsonKey(name: 'month_name') String monthName,
      @JsonKey(name: 'bookings_count', defaultValue: 0) int bookingsCount,
      @JsonKey(name: 'bookings_earnings', defaultValue: 0) int bookingsEarnings,
      @JsonKey(name: 'sales_count', defaultValue: 0) int salesCount,
      @JsonKey(name: 'sales_earnings', defaultValue: 0) int salesEarnings,
      @JsonKey(name: 'total_revenue', defaultValue: 0) int totalRevenue,
      @JsonKey(name: 'total_expense', defaultValue: 0) int totalExpense,
      @JsonKey(
          name: 'expense_breakdown',
          defaultValue: {},
          fromJson: _expenseBreakdownFromJson)
      Map<String, int> expenseBreakdown,
      @JsonKey(name: 'profit', defaultValue: 0) int profit,
      @JsonKey(name: 'growth', defaultValue: 0) int growth});
}

/// @nodoc
class _$AllShopSummaryShopMonthlyDetailsModelCopyWithImpl<$Res,
        $Val extends AllShopSummaryShopMonthlyDetailsModel>
    implements $AllShopSummaryShopMonthlyDetailsModelCopyWith<$Res> {
  _$AllShopSummaryShopMonthlyDetailsModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AllShopSummaryShopMonthlyDetailsModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? month = null,
    Object? monthName = null,
    Object? bookingsCount = null,
    Object? bookingsEarnings = null,
    Object? salesCount = null,
    Object? salesEarnings = null,
    Object? totalRevenue = null,
    Object? totalExpense = null,
    Object? expenseBreakdown = null,
    Object? profit = null,
    Object? growth = null,
  }) {
    return _then(_value.copyWith(
      month: null == month
          ? _value.month
          : month // ignore: cast_nullable_to_non_nullable
              as int,
      monthName: null == monthName
          ? _value.monthName
          : monthName // ignore: cast_nullable_to_non_nullable
              as String,
      bookingsCount: null == bookingsCount
          ? _value.bookingsCount
          : bookingsCount // ignore: cast_nullable_to_non_nullable
              as int,
      bookingsEarnings: null == bookingsEarnings
          ? _value.bookingsEarnings
          : bookingsEarnings // ignore: cast_nullable_to_non_nullable
              as int,
      salesCount: null == salesCount
          ? _value.salesCount
          : salesCount // ignore: cast_nullable_to_non_nullable
              as int,
      salesEarnings: null == salesEarnings
          ? _value.salesEarnings
          : salesEarnings // ignore: cast_nullable_to_non_nullable
              as int,
      totalRevenue: null == totalRevenue
          ? _value.totalRevenue
          : totalRevenue // ignore: cast_nullable_to_non_nullable
              as int,
      totalExpense: null == totalExpense
          ? _value.totalExpense
          : totalExpense // ignore: cast_nullable_to_non_nullable
              as int,
      expenseBreakdown: null == expenseBreakdown
          ? _value.expenseBreakdown
          : expenseBreakdown // ignore: cast_nullable_to_non_nullable
              as Map<String, int>,
      profit: null == profit
          ? _value.profit
          : profit // ignore: cast_nullable_to_non_nullable
              as int,
      growth: null == growth
          ? _value.growth
          : growth // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AllShopSummaryShopMonthlyDetailsModelImplCopyWith<$Res>
    implements $AllShopSummaryShopMonthlyDetailsModelCopyWith<$Res> {
  factory _$$AllShopSummaryShopMonthlyDetailsModelImplCopyWith(
          _$AllShopSummaryShopMonthlyDetailsModelImpl value,
          $Res Function(_$AllShopSummaryShopMonthlyDetailsModelImpl) then) =
      __$$AllShopSummaryShopMonthlyDetailsModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'month', defaultValue: 1) int month,
      @JsonKey(name: 'month_name') String monthName,
      @JsonKey(name: 'bookings_count', defaultValue: 0) int bookingsCount,
      @JsonKey(name: 'bookings_earnings', defaultValue: 0) int bookingsEarnings,
      @JsonKey(name: 'sales_count', defaultValue: 0) int salesCount,
      @JsonKey(name: 'sales_earnings', defaultValue: 0) int salesEarnings,
      @JsonKey(name: 'total_revenue', defaultValue: 0) int totalRevenue,
      @JsonKey(name: 'total_expense', defaultValue: 0) int totalExpense,
      @JsonKey(
          name: 'expense_breakdown',
          defaultValue: {},
          fromJson: _expenseBreakdownFromJson)
      Map<String, int> expenseBreakdown,
      @JsonKey(name: 'profit', defaultValue: 0) int profit,
      @JsonKey(name: 'growth', defaultValue: 0) int growth});
}

/// @nodoc
class __$$AllShopSummaryShopMonthlyDetailsModelImplCopyWithImpl<$Res>
    extends _$AllShopSummaryShopMonthlyDetailsModelCopyWithImpl<$Res,
        _$AllShopSummaryShopMonthlyDetailsModelImpl>
    implements _$$AllShopSummaryShopMonthlyDetailsModelImplCopyWith<$Res> {
  __$$AllShopSummaryShopMonthlyDetailsModelImplCopyWithImpl(
      _$AllShopSummaryShopMonthlyDetailsModelImpl _value,
      $Res Function(_$AllShopSummaryShopMonthlyDetailsModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of AllShopSummaryShopMonthlyDetailsModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? month = null,
    Object? monthName = null,
    Object? bookingsCount = null,
    Object? bookingsEarnings = null,
    Object? salesCount = null,
    Object? salesEarnings = null,
    Object? totalRevenue = null,
    Object? totalExpense = null,
    Object? expenseBreakdown = null,
    Object? profit = null,
    Object? growth = null,
  }) {
    return _then(_$AllShopSummaryShopMonthlyDetailsModelImpl(
      month: null == month
          ? _value.month
          : month // ignore: cast_nullable_to_non_nullable
              as int,
      monthName: null == monthName
          ? _value.monthName
          : monthName // ignore: cast_nullable_to_non_nullable
              as String,
      bookingsCount: null == bookingsCount
          ? _value.bookingsCount
          : bookingsCount // ignore: cast_nullable_to_non_nullable
              as int,
      bookingsEarnings: null == bookingsEarnings
          ? _value.bookingsEarnings
          : bookingsEarnings // ignore: cast_nullable_to_non_nullable
              as int,
      salesCount: null == salesCount
          ? _value.salesCount
          : salesCount // ignore: cast_nullable_to_non_nullable
              as int,
      salesEarnings: null == salesEarnings
          ? _value.salesEarnings
          : salesEarnings // ignore: cast_nullable_to_non_nullable
              as int,
      totalRevenue: null == totalRevenue
          ? _value.totalRevenue
          : totalRevenue // ignore: cast_nullable_to_non_nullable
              as int,
      totalExpense: null == totalExpense
          ? _value.totalExpense
          : totalExpense // ignore: cast_nullable_to_non_nullable
              as int,
      expenseBreakdown: null == expenseBreakdown
          ? _value._expenseBreakdown
          : expenseBreakdown // ignore: cast_nullable_to_non_nullable
              as Map<String, int>,
      profit: null == profit
          ? _value.profit
          : profit // ignore: cast_nullable_to_non_nullable
              as int,
      growth: null == growth
          ? _value.growth
          : growth // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AllShopSummaryShopMonthlyDetailsModelImpl
    implements _AllShopSummaryShopMonthlyDetailsModel {
  const _$AllShopSummaryShopMonthlyDetailsModelImpl(
      {@JsonKey(name: 'month', defaultValue: 1) required this.month,
      @JsonKey(name: 'month_name') required this.monthName,
      @JsonKey(name: 'bookings_count', defaultValue: 0)
      required this.bookingsCount,
      @JsonKey(name: 'bookings_earnings', defaultValue: 0)
      required this.bookingsEarnings,
      @JsonKey(name: 'sales_count', defaultValue: 0) required this.salesCount,
      @JsonKey(name: 'sales_earnings', defaultValue: 0)
      required this.salesEarnings,
      @JsonKey(name: 'total_revenue', defaultValue: 0)
      required this.totalRevenue,
      @JsonKey(name: 'total_expense', defaultValue: 0)
      required this.totalExpense,
      @JsonKey(
          name: 'expense_breakdown',
          defaultValue: {},
          fromJson: _expenseBreakdownFromJson)
      required final Map<String, int> expenseBreakdown,
      @JsonKey(name: 'profit', defaultValue: 0) required this.profit,
      @JsonKey(name: 'growth', defaultValue: 0) required this.growth})
      : _expenseBreakdown = expenseBreakdown;

  factory _$AllShopSummaryShopMonthlyDetailsModelImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$AllShopSummaryShopMonthlyDetailsModelImplFromJson(json);

  @override
  @JsonKey(name: 'month', defaultValue: 1)
  final int month;
  @override
  @JsonKey(name: 'month_name')
  final String monthName;
  @override
  @JsonKey(name: 'bookings_count', defaultValue: 0)
  final int bookingsCount;
  @override
  @JsonKey(name: 'bookings_earnings', defaultValue: 0)
  final int bookingsEarnings;
  @override
  @JsonKey(name: 'sales_count', defaultValue: 0)
  final int salesCount;
  @override
  @JsonKey(name: 'sales_earnings', defaultValue: 0)
  final int salesEarnings;
  @override
  @JsonKey(name: 'total_revenue', defaultValue: 0)
  final int totalRevenue;
  @override
  @JsonKey(name: 'total_expense', defaultValue: 0)
  final int totalExpense;
  final Map<String, int> _expenseBreakdown;
  @override
  @JsonKey(
      name: 'expense_breakdown',
      defaultValue: {},
      fromJson: _expenseBreakdownFromJson)
  Map<String, int> get expenseBreakdown {
    if (_expenseBreakdown is EqualUnmodifiableMapView) return _expenseBreakdown;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_expenseBreakdown);
  }

  @override
  @JsonKey(name: 'profit', defaultValue: 0)
  final int profit;
  @override
  @JsonKey(name: 'growth', defaultValue: 0)
  final int growth;

  @override
  String toString() {
    return 'AllShopSummaryShopMonthlyDetailsModel(month: $month, monthName: $monthName, bookingsCount: $bookingsCount, bookingsEarnings: $bookingsEarnings, salesCount: $salesCount, salesEarnings: $salesEarnings, totalRevenue: $totalRevenue, totalExpense: $totalExpense, expenseBreakdown: $expenseBreakdown, profit: $profit, growth: $growth)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AllShopSummaryShopMonthlyDetailsModelImpl &&
            (identical(other.month, month) || other.month == month) &&
            (identical(other.monthName, monthName) ||
                other.monthName == monthName) &&
            (identical(other.bookingsCount, bookingsCount) ||
                other.bookingsCount == bookingsCount) &&
            (identical(other.bookingsEarnings, bookingsEarnings) ||
                other.bookingsEarnings == bookingsEarnings) &&
            (identical(other.salesCount, salesCount) ||
                other.salesCount == salesCount) &&
            (identical(other.salesEarnings, salesEarnings) ||
                other.salesEarnings == salesEarnings) &&
            (identical(other.totalRevenue, totalRevenue) ||
                other.totalRevenue == totalRevenue) &&
            (identical(other.totalExpense, totalExpense) ||
                other.totalExpense == totalExpense) &&
            const DeepCollectionEquality()
                .equals(other._expenseBreakdown, _expenseBreakdown) &&
            (identical(other.profit, profit) || other.profit == profit) &&
            (identical(other.growth, growth) || other.growth == growth));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      month,
      monthName,
      bookingsCount,
      bookingsEarnings,
      salesCount,
      salesEarnings,
      totalRevenue,
      totalExpense,
      const DeepCollectionEquality().hash(_expenseBreakdown),
      profit,
      growth);

  /// Create a copy of AllShopSummaryShopMonthlyDetailsModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AllShopSummaryShopMonthlyDetailsModelImplCopyWith<
          _$AllShopSummaryShopMonthlyDetailsModelImpl>
      get copyWith => __$$AllShopSummaryShopMonthlyDetailsModelImplCopyWithImpl<
          _$AllShopSummaryShopMonthlyDetailsModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AllShopSummaryShopMonthlyDetailsModelImplToJson(
      this,
    );
  }
}

abstract class _AllShopSummaryShopMonthlyDetailsModel
    implements AllShopSummaryShopMonthlyDetailsModel {
  const factory _AllShopSummaryShopMonthlyDetailsModel(
      {@JsonKey(name: 'month', defaultValue: 1) required final int month,
      @JsonKey(name: 'month_name') required final String monthName,
      @JsonKey(name: 'bookings_count', defaultValue: 0)
      required final int bookingsCount,
      @JsonKey(name: 'bookings_earnings', defaultValue: 0)
      required final int bookingsEarnings,
      @JsonKey(name: 'sales_count', defaultValue: 0)
      required final int salesCount,
      @JsonKey(name: 'sales_earnings', defaultValue: 0)
      required final int salesEarnings,
      @JsonKey(name: 'total_revenue', defaultValue: 0)
      required final int totalRevenue,
      @JsonKey(name: 'total_expense', defaultValue: 0)
      required final int totalExpense,
      @JsonKey(
          name: 'expense_breakdown',
          defaultValue: {},
          fromJson: _expenseBreakdownFromJson)
      required final Map<String, int> expenseBreakdown,
      @JsonKey(name: 'profit', defaultValue: 0) required final int profit,
      @JsonKey(name: 'growth', defaultValue: 0)
      required final int growth}) = _$AllShopSummaryShopMonthlyDetailsModelImpl;

  factory _AllShopSummaryShopMonthlyDetailsModel.fromJson(
          Map<String, dynamic> json) =
      _$AllShopSummaryShopMonthlyDetailsModelImpl.fromJson;

  @override
  @JsonKey(name: 'month', defaultValue: 1)
  int get month;
  @override
  @JsonKey(name: 'month_name')
  String get monthName;
  @override
  @JsonKey(name: 'bookings_count', defaultValue: 0)
  int get bookingsCount;
  @override
  @JsonKey(name: 'bookings_earnings', defaultValue: 0)
  int get bookingsEarnings;
  @override
  @JsonKey(name: 'sales_count', defaultValue: 0)
  int get salesCount;
  @override
  @JsonKey(name: 'sales_earnings', defaultValue: 0)
  int get salesEarnings;
  @override
  @JsonKey(name: 'total_revenue', defaultValue: 0)
  int get totalRevenue;
  @override
  @JsonKey(name: 'total_expense', defaultValue: 0)
  int get totalExpense;
  @override
  @JsonKey(
      name: 'expense_breakdown',
      defaultValue: {},
      fromJson: _expenseBreakdownFromJson)
  Map<String, int> get expenseBreakdown;
  @override
  @JsonKey(name: 'profit', defaultValue: 0)
  int get profit;
  @override
  @JsonKey(name: 'growth', defaultValue: 0)
  int get growth;

  /// Create a copy of AllShopSummaryShopMonthlyDetailsModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AllShopSummaryShopMonthlyDetailsModelImplCopyWith<
          _$AllShopSummaryShopMonthlyDetailsModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}
