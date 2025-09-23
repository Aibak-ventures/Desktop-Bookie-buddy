import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:bookie_buddy_web/core/app_dependencies.dart';
import 'package:bookie_buddy_web/core/repositories/client_repository.dart';
import 'package:bookie_buddy_web/features/add_booking/models/client_model/client_model.dart';
import 'package:bookie_buddy_web/features/booking_details/models/client_request_model/client_request_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'client_save_bloc.freezed.dart';
part 'client_save_event.dart';
part 'client_save_state.dart';

class ClientSaveBloc extends Bloc<ClientSaveEvent, ClientSaveState> {
  final ClientRepository _repository = getIt.get<ClientRepository>();
  ClientSaveBloc() : super(const _Initial()) {
    on<_SaveClient>((event, emit) async {
      emit(const _Saving());

      try {
        final client = await _repository.addClient(event.client);
        emit(
          _Success('Client added successfully', client),
        );
      } catch (e, stack) {
        log(e.toString(), stackTrace: stack);
        emit(_Failure(e.toString()));
      }
    });
  }
}
