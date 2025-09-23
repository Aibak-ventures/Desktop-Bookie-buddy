import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:bookie_buddy_web/core/app_dependencies.dart';
import 'package:bookie_buddy_web/core/models/pagination_model.dart';
import 'package:bookie_buddy_web/core/repositories/client_repository.dart';
import 'package:bookie_buddy_web/features/add_booking/models/client_model/client_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'client_bloc.freezed.dart';
part 'client_event.dart';
part 'client_state.dart';

class ClientBloc extends Bloc<ClientEvent, ClientState> {
  final ClientRepository _repository = getIt.get<ClientRepository>();
  ClientBloc()
      : super(const _Initial(
          selectedClient: null,
          suggestions: [],
          searchQuery: '',
        )) {
    on<_ClientSelected>(_onClientSelected);
    on<_ClearSelected>(_onClearSelected);
    on<_SearchQueryChanged>(_onSearchChanged);
    on<_LoadNextData>(_onLoadNexData);
  }

  ClientModel? _clientModel;

  Future<void> _onSearchChanged(
      _SearchQueryChanged event, Emitter<ClientState> emit) async {
    try {
      final result =
          await _repository.getClients(page: 1, searchName: event.query);

      emit(
        _Initial(
          suggestions: result.data,
          selectedClient: null,
          isLoading: false,
          searchQuery: event.query,
          nextPageUrl: result.nextPageUrl,
        ),
      );
    } catch (e, stack) {
      log(e.toString(), stackTrace: stack);
      emit(
        const _Initial(
          suggestions: [],
          selectedClient: null,
          isLoading: false,
          searchQuery: '',
        ),
      );
    }
  }

  Future<void> _onLoadNexData(
      _LoadNextData event, Emitter<ClientState> emit) async {
    final s = state as _Initial;

    if (s.isLoading) return;

    try {
      emit(s.copyWith(isLoading: true));
      final nextPage = PaginationModel.getPageFromUrl(s.nextPageUrl);
      final result = await _repository.getClients(
        page: nextPage,
        searchName: s.searchQuery,
      );
      emit(s.copyWith(
        suggestions: [...s.suggestions, ...result.data],
        isLoading: false,
        nextPageUrl: result.nextPageUrl,
      ));
    } catch (e, stack) {
      log(e.toString(), stackTrace: stack);
      emit(s.copyWith(isLoading: false));
    }
  }

  void _onClientSelected(_ClientSelected event, Emitter<ClientState> emit) {
    _clientModel = event.selectedClient;
    emit(_Initial(
      suggestions: [],
      selectedClient: event.selectedClient,
      searchQuery: event.selectedClient.name,
    ));
  }

  void _onClearSelected(_ClearSelected event, Emitter<ClientState> emit) {
    _clientModel = null;
    emit(const _Initial(
      suggestions: [],
      selectedClient: null,
      searchQuery: '',
    ));

    Future.delayed(
      const Duration(milliseconds: 200),
      () {
        event.callback?.call();
      },
    );
  }

  ClientModel? getSelectedClient() {
    return _clientModel;
  }
}
