part of 'tax_and_compliance_cubit.dart';

enum TaxConfigurationActionStatus {
  idle,
  saving,
  success,
  failure;

  bool get isSaving => this == saving;
  bool get isSuccess => this == success;
  bool get isFailure => this == failure;
}

@freezed
abstract class TaxAndComplianceState with _$TaxAndComplianceState {
  const factory TaxAndComplianceState.loading() = _Loading;
  const factory TaxAndComplianceState.loaded({
    required List<TaxConfigurationEntity> taxConfigurations,
    @Default(TaxConfigurationActionStatus.idle)
    TaxConfigurationActionStatus status,
    String? message,
  }) = _Loaded;
  const factory TaxAndComplianceState.error({required String error}) = _Error;
}
