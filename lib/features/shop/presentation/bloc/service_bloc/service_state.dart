part of 'service_bloc.dart';

@freezed
abstract class ServiceState with _$ServiceState {
  const factory ServiceState.loading() = _Loading;
  const factory ServiceState.loaded(List<ServiceEntity> services) = _Loaded;
  const factory ServiceState.error(String error) = _Error;
}
