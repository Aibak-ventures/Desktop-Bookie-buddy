import 'package:freezed_annotation/freezed_annotation.dart';

import '../payment_model/payment_model.dart';

part 'payment_history_model.freezed.dart';
part 'payment_history_model.g.dart';

@freezed
class PaymentHistoryModel with _$PaymentHistoryModel {
  const factory PaymentHistoryModel({
    required List<MonthlyPaymentsModel> monthlyPayments,
  }) = _PaymentHistoryModel;

  factory PaymentHistoryModel.fromJson(Map<String, dynamic> json) {
    final List<MonthlyPaymentsModel> monthlyList = [];

    json.forEach((month, datesMap) {
      final Map<String, dynamic> dates = datesMap as Map<String, dynamic>;

      final List<DailyPaymentsModel> dailyList = [];

      dates.forEach((date, paymentsList) {
        final List<PaymentModel> paymentModel = (paymentsList as List)
            .map((e) => PaymentModel.fromJson(e as Map<String, dynamic>))
            .toList();

        dailyList.add(DailyPaymentsModel(date: date, payments: paymentModel));
      });

      monthlyList
          .add(MonthlyPaymentsModel(month: month, dailyPayments: dailyList));
    });

    return PaymentHistoryModel(monthlyPayments: monthlyList);
  }
}

@freezed
class MonthlyPaymentsModel with _$MonthlyPaymentsModel {
  const factory MonthlyPaymentsModel({
    required String month,
    @JsonKey(name: 'daily_payments')
    required List<DailyPaymentsModel> dailyPayments,
  }) = _MonthlyPaymentsModel;

  factory MonthlyPaymentsModel.fromJson(Map<String, dynamic> json) =>
      _$MonthlyPaymentsModelFromJson(json);
}

@freezed
class DailyPaymentsModel with _$DailyPaymentsModel {
  const factory DailyPaymentsModel({
    required String date,
    required List<PaymentModel> payments,
  }) = _DailyPaymentsModel;

  factory DailyPaymentsModel.fromJson(Map<String, dynamic> json) =>
      _$DailyPaymentsModelFromJson(json);
}
