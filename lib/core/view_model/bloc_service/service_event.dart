part of 'service_bloc.dart';

@freezed
class ServiceEvent with _$ServiceEvent {
  const factory ServiceEvent.loadServices({@Default(true) bool force}) =
      _LoadServices;
}
