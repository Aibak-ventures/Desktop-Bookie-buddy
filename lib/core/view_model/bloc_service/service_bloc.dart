import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:bookie_buddy_web/core/app_dependencies.dart';

import 'package:bookie_buddy_web/core/models/services_model/services_model.dart';
import 'package:bookie_buddy_web/core/repositories/service_repository.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'service_bloc.freezed.dart';
part 'service_event.dart';
part 'service_state.dart';

class ServiceBloc extends Bloc<ServiceEvent, ServiceState> {
  final ServiceRepository _repository = getIt.get<ServiceRepository>();
  ServiceBloc() : super(const _Loading()) {
    on<_LoadServices>((event, emit) async {
      // if (state is! _Loading) emit(const _Loading());
      emit(const _Loading());

      try {
        final services = await _repository.fetchServices();
        emit(
          _Loaded(services),
        );
      } catch (e, stack) {
        log('Service loading failed: $e', stackTrace: stack);
        
        String errorMessage = 'Failed to load services';
        
        // Provide more specific error messages
        if (e is DioException) {
          switch (e.type) {
            case DioExceptionType.connectionError:
              if (kIsWeb) {
                errorMessage = 'Network connection failed. For development, please run:\n'
                    'flutter run -d chrome --web-browser-flag "--disable-web-security --disable-features=VizDisplayCompositor"';
              } else {
                errorMessage = 'No internet connection. Please check your network.';
              }
              break;
            case DioExceptionType.connectionTimeout:
              errorMessage = 'Connection timeout. Server might be busy.';
              break;
            case DioExceptionType.receiveTimeout:
              errorMessage = 'Server response timeout. Please try again.';
              break;
            case DioExceptionType.badResponse:
              errorMessage = 'Server error (${e.response?.statusCode}). Please try again later.';
              break;
            default:
              errorMessage = 'Network error: ${e.message}';
          }
        }
        
        emit(_Error(errorMessage));
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
