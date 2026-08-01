import 'package:bookie_buddy_web/features/booking/domain/entities/booking_request_entity/booking_request_entity.dart';
import 'package:bookie_buddy_web/features/booking/domain/entities/document_file_entity/document_file_entity.dart';
import 'package:bookie_buddy_web/features/booking/domain/usecases/add_booking_usecase.dart';
import 'package:bookie_buddy_web/features/booking/domain/usecases/create_old_booking_usecase.dart';
import 'package:bookie_buddy_web/features/booking/domain/usecases/create_sale_booking_usecase.dart';
import 'package:bookie_buddy_web/features/booking/presentation/common/booking_form/booking_type_enum.dart';
import 'package:bookie_buddy_web/features/sales/domain/entities/sales_request_entity/sales_request_entity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'add_booking_state.dart';
part 'add_booking_cubit.freezed.dart';

class AddBookingCubit extends Cubit<AddBookingState> {
  final AddBookingUseCase _addBooking;
  final CreateSaleBookingUseCase _createSale;
  final CreateOldBookingUseCase _createOldBooking;

  AddBookingCubit({
    required AddBookingUseCase addBooking,
    required CreateSaleBookingUseCase createSale,
    required CreateOldBookingUseCase createOldBooking,
  }) : _addBooking = addBooking,
       _createSale = createSale,
       _createOldBooking = createOldBooking,
       super(const AddBookingState.initial());

  Future<void> submitBooking(
    BookingRequestEntity request, {
    List<DocumentFileEntity>? documents,
  }) async {
    emit(const AddBookingState.loading());
    try {
      final id = await _addBooking(request, documents: documents);
      emit(AddBookingState.success(id: id, type: BookingType.booking));
    } catch (e) {
      emit(AddBookingState.error(message: e.toString()));
    }
  }

  Future<void> submitSale(SalesRequestEntity request) async {
    emit(const AddBookingState.loading());
    try {
      final id = await _createSale(request);
      emit(AddBookingState.success(id: id, type: BookingType.sales));
    } catch (e) {
      emit(AddBookingState.error(message: e.toString()));
    }
  }

  Future<void> submitOldBooking(BookingRequestEntity request) async {
    emit(const AddBookingState.loading());
    try {
      await _createOldBooking(request);
      emit(const AddBookingState.success(id: 0, type: BookingType.oldBooking));
    } catch (e) {
      emit(AddBookingState.error(message: e.toString()));
    }
  }
}
