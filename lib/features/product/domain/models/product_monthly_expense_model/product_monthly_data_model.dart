import 'package:freezed_annotation/freezed_annotation.dart';

part 'product_monthly_data_model.freezed.dart';
part 'product_monthly_data_model.g.dart';

@freezed
abstract class ProductMonthlyDataModel with _$ProductMonthlyDataModel {
  const factory ProductMonthlyDataModel({
    required int year,
    required int month,
    @JsonKey(name: 'total_expense') required double totalExpense,
    @JsonKey(name: 'total_earned') required double totalEarned,
  }) = _ProductMonthlyDataModel;

  factory ProductMonthlyDataModel.fromJson(Map<String, dynamic> json) =>
      _$ProductMonthlyDataModelFromJson(json);
}

// @freezed
// class ProductMonthlyExpenseModel with _$ProductMonthlyExpenseModel {
//   const factory ProductMonthlyExpenseModel({
//     required String name,
//     @JsonKey(name: 'monthly_data') required List<MonthlyData> monthlyData,
//     required List<Expense> expenses,
//   }) = _ProductMonthlyExpenseModel;

//   factory ProductMonthlyExpenseModel.fromJson(Map<String, dynamic> json) =>
//       _$ProductMonthlyExpenseModelFromJson(json);
// }

// @freezed
// class Expense with _$Expense {
//   const factory Expense({
//     required int id,
//     @JsonKey(name: 'sub_service') required int productId,
//     required String date,
//     required int expense,
//     String? type,
//     String? description,
//   }) = _Expense;

//   factory Expense.fromJson(Map<String, dynamic> json) =>
//       _$ExpenseFromJson(json);
// }

// class ProductMonthlyExpenseModel {
//   final String name;
//   final List<MonthlyData> monthlyData;
//   final List<Expense> expenses;

//   ProductMonthlyExpenseModel({
//     required this.name,
//     required this.monthlyData,
//     required this.expenses,
//   });

//   factory ProductMonthlyExpenseModel.fromJson(Map<String, dynamic> json) {
//     return ProductMonthlyExpenseModel(
//       name: json['sub_service_name'] ?? '',
//       monthlyData: (json['monthly_data'] as List?)
//               ?.map((e) => MonthlyData.fromJson(e))
//               .toList() ??
//           [],
//       expenses: (json['expenses'] as List?)
//               ?.map((e) => Expense.fromJson(e))
//               .toList() ??
//           [],
//     );
//   }

//   @override
//   String toString() =>
//       'ProductMonthlyExpenseModel(name: $name, monthlyData: $monthlyData, expenses: $expenses)';
// }

// class MonthlyData {
//   final int year;
//   final int month;
//   final int totalExpense;
//   final int totalEarned;

//   MonthlyData({
//     required this.year,
//     required this.month,
//     required this.totalExpense,
//     required this.totalEarned,
//   });

//   factory MonthlyData.fromJson(Map<String, dynamic> json) {
//     return MonthlyData(
//       year: json['year'] ?? 0,
//       month: json['month'] ?? 0,
//       totalExpense: json['total_expense'] ?? 0,
//       totalEarned: json['total_earned'] ?? 0,
//     );
//   }

//   @override
//   String toString() {
//     return 'MonthlyData(year: $year, month: $month, totalExpense: $totalExpense, totalEarned: $totalEarned)';
//   }
// }

// class Expense {
//   final int id;
//   final int productId;
//   final String date;
//   final int expense;
//   final String? type;
//   final String? description;

//   Expense({
//     required this.id,
//     required this.productId,
//     required this.date,
//     required this.expense,
//     this.type,
//     this.description,
//   });

//   factory Expense.fromJson(Map<String, dynamic> json) {
//     return Expense(
//       id: json['id'] ?? 0,
//       productId: json['sub_service'] ?? 0,
//       date: json['date'] ?? '',
//       expense: json['expense'] ?? 0,
//       type: json['type'],
//       description: json['description'],
//     );
//   }

//   @override
//   String toString() {
//     return 'Expense(id: $id, productId: $productId, date: $date, expense: $expense, type: $type, description: $description)';
//   }
// }
