// // ignore_for_file: public_member_api_docs, sort_constructors_first
// import 'package:bookie_buddy_web/features/wallet/models/wallet_day_summary_model.dart';

// class PaymentScreenData {
//   final GroupedPayments groupedPayments;
//   final TodaySummary? todaySummary;

//   PaymentScreenData({
//     required this.groupedPayments,
//     required this.todaySummary,
//   });

//   factory PaymentScreenData.fromJson(Map<String, dynamic> json) {
//     return PaymentScreenData(
//       groupedPayments: GroupedPayments.fromJson(json['grouped_payments']),
//       todaySummary: null, //!TODO: Change when using this
//       // todaySummary: TodaySummary.fromJson(json['today_summary']),
//     );
//   }
// }

// class GroupedPayments {
//   final Map<String, PaymentGroup> monthWiseGroups;

//   GroupedPayments({required this.monthWiseGroups});

//   factory GroupedPayments.fromJson(Map<String, dynamic> json) {
//     final Map<String, PaymentGroup> parsed = {};
//     json.forEach((month, dates) {
//       parsed[month] = PaymentGroup.fromJson(dates);
//     });
//     return GroupedPayments(monthWiseGroups: parsed);
//   }
// }

// class PaymentGroup {
//   final Map<String, List<PaymentModel>> dateWisePayments;

//   PaymentGroup({required this.dateWisePayments});

//   factory PaymentGroup.fromJson(Map<String, dynamic> json) {
//     final Map<String, List<PaymentModel>> parsed = {};
//     json.forEach((date, list) {
//       parsed[date] = List<PaymentModel>.from(
//         (list as List).map((item) => PaymentModel.fromJson(item)),
//       );
//     });
//     return PaymentGroup(dateWisePayments: parsed);
//   }
// }

// class PaymentModel {
//   final int bookingId;
//   final int paymentAmount;
//   final String paymentMethod;
//   final String clientName;
//   final DateTime currentDate;

//   PaymentModel({
//     required this.bookingId,
//     required this.paymentAmount,
//     required this.paymentMethod,
//     required this.clientName,
//     required this.currentDate,
//   });

//   factory PaymentModel.fromJson(Map<String, dynamic> json) {
//     return PaymentModel(
//       bookingId: json['booking_id'],
//       paymentAmount: json['payment_amount'],
//       paymentMethod: json['payment_method'],
//       clientName: json['client_name'],
//       currentDate: DateTime.parse(json['current_date']),
//     );
//   }
// }
