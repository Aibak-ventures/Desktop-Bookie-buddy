// import 'dart:developer';
// import 'package:bookie_buddy_web/core/app_dependencies.dart';
// import 'package:bookie_buddy_web/features/wallet/models/wallet_day_summary_model.dart';
// import 'package:bookie_buddy_web/features/wallet/repository/wallet_repository.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:freezed_annotation/freezed_annotation.dart';

// part 'wallet_payment_summary_state.dart';
// part 'wallet_payment_summary_cubit.freezed.dart';

// class WalletPaymentSummaryCubit extends Cubit<WalletPaymentSummaryState> {
//   final WalletRepository _repository = getIt.get<WalletRepository>();
//   WalletPaymentSummaryCubit()
//       : super(
//           _Summary(summary: TodaySummary.initial()),
//         );

//   final Map<String, TodaySummary> _daySummaries = {}; // Cache day summaries

//   Future<void> getDaySummary(String date) async {
//     try {
//       log('fetching summary for $date');
//       if (_daySummaries.containsKey(date)) {
//         log('already have summary for $date, summary: ${_daySummaries[date]}');
//       }
//       final summary = _daySummaries[date] ??
//           await _repository.getPaymentDaySummary(date: date);
//       emit(
//         _Summary(
//           summary: summary,
//           currentShowingDate: date,
//         ),
//       );

//       _daySummaries.putIfAbsent(date, () => summary);
//     } catch (e, stack) {
//       log(e.toString(), stackTrace: stack);
//       emit(
//         _Summary(
//           summary: TodaySummary.initial(),
//           currentShowingDate: date,
//         ),
//       );
//     }
//   }

//   void reset() {
//     emit(
//       _Summary(summary: TodaySummary.initial()),
//     );
//     final firstDate = _daySummaries.keys.first;
//     _daySummaries.clear();
//     getDaySummary(firstDate);
//   }

//   // _Summary get summary => state as _Summary;
// }
