import 'package:bookie_buddy_shared/core/core/common/entities/tax_configuration_entity/tax_configuration_entity.dart';
import 'package:bookie_buddy_web/features/tax_and_compliance/domain/entities/tax_configuration_request_entity/tax_configuration_request_entity.dart';
import 'package:bookie_buddy_web/features/tax_and_compliance/domain/usecases/create_tax_configuration_usecase.dart';
import 'package:bookie_buddy_web/features/tax_and_compliance/domain/usecases/get_tax_configurations_usecase.dart';
import 'package:bookie_buddy_web/features/tax_and_compliance/domain/usecases/update_tax_configuration_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'tax_and_compliance_state.dart';
part 'tax_and_compliance_cubit.freezed.dart';

class TaxAndComplianceCubit extends Cubit<TaxAndComplianceState> {
  final GetTaxConfigurationsUseCase _getTaxConfigurations;
  final CreateTaxConfigurationUseCase _createTaxConfiguration;
  final UpdateTaxConfigurationUseCase _updateTaxConfiguration;

  TaxAndComplianceCubit({
    required GetTaxConfigurationsUseCase getTaxConfigurations,
    required CreateTaxConfigurationUseCase createTaxConfiguration,
    required UpdateTaxConfigurationUseCase updateTaxConfiguration,
  }) : _getTaxConfigurations = getTaxConfigurations,
       _createTaxConfiguration = createTaxConfiguration,
       _updateTaxConfiguration = updateTaxConfiguration,
       super(const TaxAndComplianceState.loading());

  /// Whether any tax rule was created/updated/toggled during this cubit's
  /// lifetime. Other modules (booking, sales, custom work) read tax config
  /// off the cached `UserCubit.shopDetails` snapshot, not live from here, so
  /// the screen uses this to tell its caller whether that snapshot needs
  /// refetching — same pattern as `AccountsSummaryCubit.haveChanges`.
  bool get hasChanges => _hasChanges;
  bool _hasChanges = false;

  Future<void> loadTaxConfigurations() async {
    emit(const TaxAndComplianceState.loading());
    try {
      final taxConfigurations = await _getTaxConfigurations();
      emit(TaxAndComplianceState.loaded(taxConfigurations: taxConfigurations));
    } catch (e) {
      emit(TaxAndComplianceState.error(error: e.toString()));
    }
  }

  Future<void> saveTaxConfiguration(
    TaxConfigurationRequestEntity request, {
    int? taxId,
  }) async {
    if (state is! _Loaded) return;
    final s = state as _Loaded;
    emit(s.copyWith(status: TaxConfigurationActionStatus.saving));
    try {
      if (taxId == null) {
        await _createTaxConfiguration(taxConfiguration: request);
      } else {
        await _updateTaxConfiguration(id: taxId, taxConfiguration: request);
      }
      final taxConfigurations = await _getTaxConfigurations();
      _hasChanges = true;
      emit(
        TaxAndComplianceState.loaded(
          taxConfigurations: taxConfigurations,
          status: TaxConfigurationActionStatus.success,
          message: taxId == null
              ? 'Tax rule created successfully'
              : 'Tax rule updated successfully',
        ),
      );
    } catch (e) {
      emit(
        s.copyWith(
          status: TaxConfigurationActionStatus.failure,
          message: e.toString(),
        ),
      );
    }
  }

  Future<void> toggleEnabled(int taxId, bool isEnabled) async {
    if (state is! _Loaded) return;
    final s = state as _Loaded;

    if (s.status.isSaving) return; // Prevent multiple simultaneous updates

    final previousTaxConfigurations = s.taxConfigurations;
    if (previousTaxConfigurations.isEmpty) return;

    final optimisticTaxConfigurations = previousTaxConfigurations
        .map((e) => e.id == taxId ? e.copyWith(isEnabled: isEnabled) : e)
        .toList();
    emit(
      s.copyWith(
        taxConfigurations: optimisticTaxConfigurations,
        status: TaxConfigurationActionStatus.saving,
      ),
    );
    try {
      await _updateTaxConfiguration(
        id: taxId,
        taxConfiguration: TaxConfigurationRequestEntity(isEnabled: isEnabled),
      );
      _hasChanges = true;
      emit(
        TaxAndComplianceState.loaded(
          taxConfigurations: optimisticTaxConfigurations,
          status: TaxConfigurationActionStatus.success,
          message: isEnabled ? 'Tax rule enabled' : 'Tax rule disabled',
        ),
      );
    } catch (e) {
      emit(
        TaxAndComplianceState.loaded(
          taxConfigurations: previousTaxConfigurations,
          status: TaxConfigurationActionStatus.failure,
          message: e.toString(),
        ),
      );
    }
  }
}
