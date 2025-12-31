// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'all_shop_summary_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AllShopSummaryModelImpl _$$AllShopSummaryModelImplFromJson(
        Map<String, dynamic> json) =>
    _$AllShopSummaryModelImpl(
      overallRevenue: AllShopSummaryOverallRevenueModel.fromJson(
          json['overall'] as Map<String, dynamic>),
      shops: (json['shops'] as List<dynamic>)
          .map((e) =>
              AllShopSummaryShopModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$AllShopSummaryModelImplToJson(
        _$AllShopSummaryModelImpl instance) =>
    <String, dynamic>{
      'overall': instance.overallRevenue,
      'shops': instance.shops,
    };

_$AllShopSummaryOverallRevenueModelImpl
    _$$AllShopSummaryOverallRevenueModelImplFromJson(
            Map<String, dynamic> json) =>
        _$AllShopSummaryOverallRevenueModelImpl(
          totalRevenue: (json['revenue'] as num?)?.toInt() ?? 0,
          totalExpense: (json['expense'] as num?)?.toInt() ?? 0,
          totalProfit: (json['profit'] as num?)?.toInt() ?? 0,
          revenueGrowth: (json['revenue_growth'] as num?)?.toInt() ?? 0,
          expenseGrowth: (json['expense_growth'] as num?)?.toInt() ?? 0,
          profitGrowth: (json['profit_growth'] as num?)?.toInt() ?? 0,
        );

Map<String, dynamic> _$$AllShopSummaryOverallRevenueModelImplToJson(
        _$AllShopSummaryOverallRevenueModelImpl instance) =>
    <String, dynamic>{
      'revenue': instance.totalRevenue,
      'expense': instance.totalExpense,
      'profit': instance.totalProfit,
      'revenue_growth': instance.revenueGrowth,
      'expense_growth': instance.expenseGrowth,
      'profit_growth': instance.profitGrowth,
    };

_$AllShopSummaryShopModelImpl _$$AllShopSummaryShopModelImplFromJson(
        Map<String, dynamic> json) =>
    _$AllShopSummaryShopModelImpl(
      shopId: (json['shop_id'] as num).toInt(),
      shopName: json['shop_name'] as String,
      shopAddress: json['shop_address'] as String? ?? '',
      monthlyDetails: (json['months'] as List<dynamic>)
          .map((e) => AllShopSummaryShopMonthlyDetailsModel.fromJson(
              e as Map<String, dynamic>))
          .toList(),
      overallRevenue: AllShopSummaryOverallRevenueModel.fromJson(
          json['totals'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$AllShopSummaryShopModelImplToJson(
        _$AllShopSummaryShopModelImpl instance) =>
    <String, dynamic>{
      'shop_id': instance.shopId,
      'shop_name': instance.shopName,
      'shop_address': instance.shopAddress,
      'months': instance.monthlyDetails,
      'totals': instance.overallRevenue,
    };

_$AllShopSummaryShopMonthlyDetailsModelImpl
    _$$AllShopSummaryShopMonthlyDetailsModelImplFromJson(
            Map<String, dynamic> json) =>
        _$AllShopSummaryShopMonthlyDetailsModelImpl(
          month: (json['month'] as num?)?.toInt() ?? 1,
          monthName: json['month_name'] as String,
          bookingsCount: (json['bookings_count'] as num?)?.toInt() ?? 0,
          bookingsEarnings: (json['bookings_earnings'] as num?)?.toInt() ?? 0,
          salesCount: (json['sales_count'] as num?)?.toInt() ?? 0,
          salesEarnings: (json['sales_earnings'] as num?)?.toInt() ?? 0,
          totalRevenue: (json['total_revenue'] as num?)?.toInt() ?? 0,
          totalExpense: (json['total_expense'] as num?)?.toInt() ?? 0,
          expenseBreakdown: json['expense_breakdown'] == null
              ? {}
              : _expenseBreakdownFromJson(json['expense_breakdown'] as Map?),
          profit: (json['profit'] as num?)?.toInt() ?? 0,
          growth: (json['growth'] as num?)?.toInt() ?? 0,
        );

Map<String, dynamic> _$$AllShopSummaryShopMonthlyDetailsModelImplToJson(
        _$AllShopSummaryShopMonthlyDetailsModelImpl instance) =>
    <String, dynamic>{
      'month': instance.month,
      'month_name': instance.monthName,
      'bookings_count': instance.bookingsCount,
      'bookings_earnings': instance.bookingsEarnings,
      'sales_count': instance.salesCount,
      'sales_earnings': instance.salesEarnings,
      'total_revenue': instance.totalRevenue,
      'total_expense': instance.totalExpense,
      'expense_breakdown': instance.expenseBreakdown,
      'profit': instance.profit,
      'growth': instance.growth,
    };
