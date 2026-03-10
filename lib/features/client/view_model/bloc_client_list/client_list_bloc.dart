import 'dart:async';
import 'dart:developer';

import 'package:bookie_buddy_web/utils/extensions/string_extensions.dart';
import 'package:bookie_buddy_web/core/models/client_request_model/client_request_model.dart';
import 'package:bookie_buddy_web/core/models/pagination_model/pagination_model.dart';
import 'package:bookie_buddy_web/core/repositories/client_repository.dart';
import 'package:bookie_buddy_web/features/add_booking/models/client_model/client_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'client_list_bloc.freezed.dart';
part 'client_list_event.dart';
part 'client_list_state.dart';

class ClientListBloc extends Bloc<ClientListEvent, ClientListState> {
  final ClientRepository _repository;
  ClientListBloc({required ClientRepository repository})
      : _repository = repository,
        super(const _Loading()) {
    on<_LoadClients>(_onLoadClients);
    on<_LoadNextPageClients>(_onLoadNextPageClients);
    on<_DeleteClient>(_onDeleteClient);
    on<_EditClient>(_onEditClient);
    on<_AddClient>(_onAddClient);
  }

  Future<void> _onLoadClients(
    _LoadClients event,
    Emitter<ClientListState> emit,
  ) async {
    if (state is! _Loading) emit(const _Loading());

    try {
      final searchPhone = event.searchQuery?.toIntOrNull();

      final results = await _repository.getClients(
        searchName: searchPhone == null ? event.searchQuery : null,
        searchPhone: searchPhone != null ? searchPhone.toString() : null,
      );
      emit(_Loaded(clients: results.data, nextPageUrl: results.nextPageUrl));
    } catch (e, stack) {
      log(e.toString(), stackTrace: stack);
      emit(_Error(e.toString()));
    }
  }

  FutureOr<void> _onLoadNextPageClients(
    _LoadNextPageClients event,
    Emitter<ClientListState> emit,
  ) async {
    if (state is! _Loaded) return;
    final s = state as _Loaded;
    if (s.isPaginating || s.nextPageUrl == null) return;

    emit(s.copyWith(isPaginating: true));

    try {
      final nextPage = PaginationModel.getPageFromUrl(s.nextPageUrl);

      final searchPhone = s.searchQuery?.toIntOrNull();
      final results = await _repository.getClients(
        page: nextPage,
        searchName: searchPhone == null ? s.searchQuery : null,
        searchPhone: searchPhone != null ? searchPhone.toString() : null,
      );
      emit(
        _Loaded(
          clients: [...s.clients, ...results.data],
          nextPageUrl: results.nextPageUrl,
        ),
      );
    } catch (e, stack) {
      log(e.toString(), stackTrace: stack);
      emit(_Error(e.toString()));
    }
  }

  Future<void> _onAddClient(
    _AddClient event,
    Emitter<ClientListState> emit,
  ) async {
    try {
      await _repository.addClient(event.client, allowExisting: false);
      emit(
        _Success(
          'Client ${event.client.name} added successfully',
          didPop: true,
        ),
      );
    } catch (e, stack) {
      log(e.toString(), stackTrace: stack);
      emit(_Failure(e.toString()));
    }
  }

  FutureOr<void> _onEditClient(
    _EditClient event,
    Emitter<ClientListState> emit,
  ) async {
    try {
      await _repository.updateClient(event.client);
      emit(const _Success('Client updated successfully', didPop: true));
    } catch (e, stack) {
      log(e.toString(), stackTrace: stack);
      emit(_Failure(e.toString()));
    }
  }

  Future<void> _onDeleteClient(
    _DeleteClient event,
    Emitter<ClientListState> emit,
  ) async {
    try {
      if (event.client.id == null) return;
      await _repository.deleteClient(event.client.id!);
      emit(_Success('Client ${event.client.name} deleted successfully'));
    } catch (e, stack) {
      log(e.toString(), stackTrace: stack);
      emit(_Failure(e.toString()));
    }
  }
}
