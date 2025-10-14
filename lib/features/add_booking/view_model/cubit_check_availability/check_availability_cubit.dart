// import 'package:bookie_buddy_web/features/add_booking/models/check_availability_model.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:freezed_annotation/freezed_annotation.dart';

// part 'check_availability_state.dart';
// part 'check_availability_cubit.freezed.dart';

// class CheckAvailabilityCubit extends Cubit<CheckAvailabilityState> {

//   CheckAvailabilityCubit() : super(const _Initial());

//   Future<void> checkAvailability({
//     required String eventDate,
//     required String returnDate,
//     required List<int> productIds,
//   }) async {
//     throw UnimplementedError(
//       'This method is not implemented yet. Please implement this before using it.',
//     );
    // emit(const _Checking());
    // log('eventDate: $eventDate, returnDate: $returnDate, productIds: $productIds');
    // try {
    //   final result = await _repository.checkAvailability(
    //     eventDate: eventDate,
    //     returnDate: returnDate,
    //     productIds: productIds,
    //   );
    //   final status = result.status;

    //   if (status == CheckAvailabilityStatus.available) {
    //     emit(const _Success());
    //   } else {
    //     emit(_Failure(result.unavailableProducts));
    //   }
    // } catch (e, stack) {
    //   log(e.toString(), stackTrace: stack);
    //   emit(_Error(e.toString()));
    // }
//   }
// }
