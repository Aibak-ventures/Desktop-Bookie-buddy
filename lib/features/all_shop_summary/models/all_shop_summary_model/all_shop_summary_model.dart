import 'package:freezed_annotation/freezed_annotation.dart';

part 'all_shop_summary_model.freezed.dart';
part 'all_shop_summary_model.g.dart';

@freezed
class AllShopSummaryModel with _$AllShopSummaryModel {
  const factory AllShopSummaryModel({
    @JsonKey(name: 'overall')
    required AllShopSummaryOverallRevenueModel overallRevenue,
    @JsonKey(name: 'shops') required List<AllShopSummaryShopModel> shops,
  }) = _AllShopSummaryModel;

  factory AllShopSummaryModel.fromJson(Map<String, dynamic> json) =>
      _$AllShopSummaryModelFromJson(json);

  static AllShopSummaryModel empty({int shopCount = 2}) => AllShopSummaryModel(
    overallRevenue: const AllShopSummaryOverallRevenueModel(
      totalRevenue: 0,
      totalExpense: 0,
      totalProfit: 0,
      revenueGrowth: 0,
      expenseGrowth: 0,
      profitGrowth: 0,
    ),
    shops: List.generate(
      shopCount,
      (_) => AllShopSummaryShopModel(
        shopId: -1,
        shopName: 'Loading...',
        shopAddress: '',
        monthlyDetails: [AllShopSummaryShopMonthlyDetailsModel.empty()],
        overallRevenue: AllShopSummaryOverallRevenueModel.empty(),
      ),
    ),
  );
}

@freezed
class AllShopSummaryOverallRevenueModel
    with _$AllShopSummaryOverallRevenueModel {
  const factory AllShopSummaryOverallRevenueModel({
    @JsonKey(name: 'revenue', defaultValue: 0) required int totalRevenue,
    @JsonKey(name: 'expense', defaultValue: 0) required int totalExpense,
    @JsonKey(name: 'profit', defaultValue: 0) required int totalProfit,

    @JsonKey(name: 'revenue_growth', defaultValue: 0)
    required int revenueGrowth,
    @JsonKey(name: 'expense_growth', defaultValue: 0)
    required int expenseGrowth,
    @JsonKey(name: 'profit_growth', defaultValue: 0) required int profitGrowth,
  }) = _AllShopSummaryOverallRevenueModel;

  factory AllShopSummaryOverallRevenueModel.fromJson(
    Map<String, dynamic> json,
  ) => _$AllShopSummaryOverallRevenueModelFromJson(json);

  static AllShopSummaryOverallRevenueModel empty() =>
      const AllShopSummaryOverallRevenueModel(
        totalRevenue: 0,
        totalExpense: 0,
        totalProfit: 0,
        revenueGrowth: 0,
        expenseGrowth: 0,
        profitGrowth: 0,
      );
}

@freezed
class AllShopSummaryShopModel with _$AllShopSummaryShopModel {
  const factory AllShopSummaryShopModel({
    @JsonKey(name: 'shop_id') required int shopId,
    @JsonKey(name: 'shop_name') required String shopName,
    @JsonKey(name: 'shop_address', defaultValue: '')
    required String shopAddress,
    @JsonKey(name: 'months')
    required List<AllShopSummaryShopMonthlyDetailsModel> monthlyDetails,
    @JsonKey(name: 'totals')
    required AllShopSummaryOverallRevenueModel overallRevenue,
  }) = _AllShopSummaryShopModel;

  factory AllShopSummaryShopModel.fromJson(Map<String, dynamic> json) =>
      _$AllShopSummaryShopModelFromJson(json);

  static AllShopSummaryShopModel empty() => AllShopSummaryShopModel(
    shopId: -1,
    shopName: 'Loading...',
    shopAddress: '',
    monthlyDetails: [],
    overallRevenue: AllShopSummaryOverallRevenueModel.empty(),
  );
}

@freezed
class AllShopSummaryShopMonthlyDetailsModel
    with _$AllShopSummaryShopMonthlyDetailsModel {
  const factory AllShopSummaryShopMonthlyDetailsModel({
    @JsonKey(name: 'month', defaultValue: 1) required int month,
    @JsonKey(name: 'month_name') required String monthName,
    @JsonKey(name: 'bookings_count', defaultValue: 0)
    required int bookingsCount,
    @JsonKey(name: 'bookings_earnings', defaultValue: 0)
    required int bookingsEarnings,
    @JsonKey(name: 'sales_count', defaultValue: 0) required int salesCount,
    @JsonKey(name: 'sales_earnings', defaultValue: 0)
    required int salesEarnings,
    @JsonKey(name: 'total_revenue', defaultValue: 0) required int totalRevenue,
    @JsonKey(name: 'total_expense', defaultValue: 0) required int totalExpense,
    @JsonKey(
      name: 'expense_breakdown',
      defaultValue: {},
      fromJson: _expenseBreakdownFromJson,
    )
    required Map<String, int> expenseBreakdown,
    @JsonKey(name: 'profit', defaultValue: 0) required int profit,
    @JsonKey(name: 'growth', defaultValue: 0) required int growth,
  }) = _AllShopSummaryShopMonthlyDetailsModel;

  factory AllShopSummaryShopMonthlyDetailsModel.fromJson(
    Map<String, dynamic> json,
  ) => _$AllShopSummaryShopMonthlyDetailsModelFromJson(json);

  static AllShopSummaryShopMonthlyDetailsModel empty() =>
      const AllShopSummaryShopMonthlyDetailsModel(
        month: 1,
        monthName: 'Jan',
        bookingsCount: 0,
        bookingsEarnings: 0,
        salesCount: 0,
        salesEarnings: 0,
        totalRevenue: 0,
        totalExpense: 0,
        expenseBreakdown: {},
        profit: 0,
        growth: 0,
      );
}

Map<String, int> _expenseBreakdownFromJson(Map? json) {
  if (json == null) {
    return {};
  }
  return json.map((key, value) => MapEntry(key, (value as num).toInt()));
}
