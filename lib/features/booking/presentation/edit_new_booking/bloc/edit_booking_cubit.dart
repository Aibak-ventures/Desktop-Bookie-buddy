import 'package:bookie_buddy_web/features/booking/domain/entities/document_file_entity/document_file_entity.dart';
import 'package:bookie_buddy_web/features/booking/domain/usecases/update_booking_partial_usecase.dart';
import 'package:bookie_buddy_web/features/sales/domain/entities/sales_request_entity/sales_request_entity.dart';
import 'package:bookie_buddy_web/features/sales/domain/usecases/update_sale_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'edit_booking_state.dart';
part 'edit_booking_cubit.freezed.dart';

class EditBookingCubit extends Cubit<EditBookingState> {
  final UpdateBookingPartialUseCase _updateBookingPartial;
  final UpdateSaleUseCase _updateSale;

  EditBookingCubit({
    required UpdateBookingPartialUseCase updateBookingPartial,
    required UpdateSaleUseCase updateSale,
  }) : _updateBookingPartial = updateBookingPartial,
       _updateSale = updateSale,
       super(const EditBookingState.initial());

  Future<void> updateBooking(
    int bookingId,
    Map<String, dynamic> partialData, {
    List<DocumentFileEntity>? newDocuments,
    List<String>? removedDocumentUrls,
  }) async {
    emit(const EditBookingState.loading());
    try {
      await _updateBookingPartial(
        bookingId,
        partialData,
        newDocuments: newDocuments,
        removedDocumentUrls: removedDocumentUrls,
      );
      emit(const EditBookingState.success(isBooking: true));
    } catch (e) {
      emit(EditBookingState.error(message: e.toString()));
    }
  }

  Future<void> updateSale(SalesRequestEntity request) async {
    emit(const EditBookingState.loading());
    try {
      await _updateSale(request);
      emit(const EditBookingState.success(isBooking: false));
    } catch (e) {
      emit(EditBookingState.error(message: e.toString()));
    }
  }
}
