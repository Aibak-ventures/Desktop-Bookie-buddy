// import 'dart:developer';

// import 'package:bookie_buddy_web/features/client/domain/models/client_request_model/client_request_model.dart';
// import 'package:bookie_buddy_web/features/client/domain/usecases/add_client_usecase.dart';
// import 'package:bookie_buddy_web/features/client/domain/models/client_model/client_model.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:freezed_annotation/freezed_annotation.dart';

// part 'client_save_bloc.freezed.dart';
// part 'client_save_event.dart';
// part 'client_save_state.dart';

// class ClientSaveBloc extends Bloc<ClientSaveEvent, ClientSaveState> {
//   final AddClientUseCase _addClient;

//   ClientSaveBloc({required AddClientUseCase addClient})
//       : _addClient = addClient,
//         super(const ClientSaveState.initial()) {
//     on<_SaveClient>((event, emit) async {
//       emit(const _Saving());

//       try {
//         final client = await _addClient.call(event.client);
//         emit(_Success('Client added successfully', client));
//       } catch (e, stack) {
//         log(e.toString(), stackTrace: stack);
//         emit(_Failure(e.toString()));
//       }
//     });
//   }
// }
