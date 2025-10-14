import 'dart:developer';

import 'package:bookie_buddy_web/core/models/services_model/services_model.dart';
import 'package:bookie_buddy_web/core/repositories/service_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'service_bloc.freezed.dart';
part 'service_event.dart';
part 'service_state.dart';

class ServiceBloc extends Bloc<ServiceEvent, ServiceState> {
  final ServiceRepository _repository;
  ServiceBloc({required ServiceRepository repository})
    : _repository = repository,
      super(const _Loading()) {
    on<_LoadServices>((event, emit) async {
      if (!event.force) {
        if (state is _Loaded) {
          emit(state);
          return;
        }
      }
      emit(const _Loading());

      try {
        final services = await _repository.fetchServices();
        emit(_Loaded(services));
      } catch (e, stack) {
        log(e.toString(), stackTrace: stack);
        emit(_Error(e.toString()));
      }
    });
  }

  List<ServicesModel> getServices() {
    if (state is _Loaded) {
      return (state as _Loaded).services;
    }
    return [];
  }
}
