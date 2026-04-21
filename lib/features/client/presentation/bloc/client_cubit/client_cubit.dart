import 'dart:developer';

import 'package:bookie_buddy_web/features/client/domain/entities/client_entity/client_entity.dart';
import 'package:bookie_buddy_web/features/client/domain/usecases/get_client_by_id_usecase.dart';
import 'package:bookie_buddy_web/features/client/domain/usecases/get_clients_usecase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'client_cubit.freezed.dart';
part 'client_state.dart';

class ClientCubit extends Cubit<ClientState> {
  final GetClientsUseCase _getClients;
  final GetClientByIdUseCase _getClientById;

  ClientCubit({
    required GetClientsUseCase getClients,
    required GetClientByIdUseCase getClientById,
  })  : _getClients = getClients,
        _getClientById = getClientById,
        super(
          const ClientState(
            selectedClient: null,
            suggestions: [],
            searchQuery: '',
          ),
        );

  ClientEntity? _clientModel;
  // Tracks whether a v4 fetch is already in flight to prevent duplicate calls.
  bool _fetchingById = false;

  Future<List<ClientEntity>> searchClient(String query) async {
    // Never search using the selected client's own name — it would clear the
    // selection and re-trigger an unnecessary list fetch.
    final selected = state.selectedClient;
    if (selected != null && query == selected.name) {
      return state.suggestions;
    }

    try {
      final result = await _getClients.call(searchName: query);

      emit(
        ClientState(
          suggestions: result.data,
          selectedClient: null,
          searchQuery: query,
          nextPageUrl: result.nextPageUrl,
        ),
      );

      return result.data;
    } catch (e, stack) {
      log(e.toString(), stackTrace: stack);
      emit(
        const ClientState(
          suggestions: [],
          selectedClient: null,
          searchQuery: '',
        ),
      );
      return [];
    }
  }

  /// Selects [selectedClient] optimistically, then fetches fresh v4 data by ID
  /// to ensure phone numbers are populated from the E.164 fields.
  ///
  /// Guards against duplicate taps: if the same client is already selected and
  /// a v4 fetch is already in flight, the call is ignored.
  Future<void> selectClient(ClientEntity selectedClient) async {
    // Deduplicate: ignore if we're already fetching this exact client.
    if (_fetchingById && _clientModel?.id == selectedClient.id) return;

    _clientModel = selectedClient;
    emit(
      ClientState(
        suggestions: [],
        selectedClient: selectedClient,
        searchQuery: selectedClient.name,
      ),
    );

    if (selectedClient.id == null) return;

    _fetchingById = true;
    try {
      final fresh = await _getClientById.call(selectedClient.id!);
      _clientModel = fresh;
      emit(
        ClientState(
          suggestions: [],
          selectedClient: fresh,
          searchQuery: fresh.name,
        ),
      );
    } catch (e) {
      log('Could not refresh client from v4 API: $e');
      // Keep the optimistic client already emitted.
    } finally {
      _fetchingById = false;
    }
  }

  void clearSelected([VoidCallback? callback]) {
    _clientModel = null;
    emit(
      const ClientState(suggestions: [], selectedClient: null, searchQuery: ''),
    );

    Future.delayed(const Duration(milliseconds: 200), () {
      callback?.call();
    });
  }

  ClientEntity? getSelectedClient() => _clientModel;
}
