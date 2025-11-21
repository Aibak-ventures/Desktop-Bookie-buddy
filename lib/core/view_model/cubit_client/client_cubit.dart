import 'dart:developer';

import 'package:bookie_buddy_web/core/repositories/client_repository.dart';
import 'package:bookie_buddy_web/features/add_booking/models/client_model/client_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'client_cubit.freezed.dart';
part 'client_state.dart';

class ClientCubit extends Cubit<ClientState> {
  final ClientRepository _repository;
  ClientCubit({required ClientRepository repository})
      : _repository = repository,
        super(
          const ClientState(
            selectedClient: null,
            suggestions: [],
            searchQuery: '',
          ),
        );

  ClientModel? _clientModel;

  Future<List<ClientModel>> searchClient(String query) async {
    try {
      final result = await _repository.getClients(searchName: query);

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

  void selectClient(ClientModel selectedClient) {
    _clientModel = selectedClient;
    emit(
      ClientState(
        suggestions: [],
        selectedClient: selectedClient,
        searchQuery: selectedClient.name,
      ),
    );
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

  ClientModel? getSelectedClient() => _clientModel;
}
