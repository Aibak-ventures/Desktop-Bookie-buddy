import 'package:bookie_buddy_web/core/common/widgets/custom_error_text_widget.dart';
import 'package:bookie_buddy_web/core/common/widgets/empty_data_widget.dart';
import 'package:bookie_buddy_web/core/common/widgets/global_loading_overlay.dart';
import 'package:bookie_buddy_web/features/tax_and_compliance/presentation/cubit/tax_and_compliance_cubit.dart';
import 'package:bookie_buddy_web/features/tax_and_compliance/presentation/widgets/tax_configuration_card.dart';
import 'package:bookie_buddy_web/features/tax_and_compliance/presentation/widgets/tax_configuration_dialog.dart';
import 'package:bookie_buddy_web/utils/extensions/context_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Pops `true` if any tax rule was created/updated/toggled while this screen
/// was open, `false` otherwise — so the caller (settings screen) knows
/// whether it needs to refetch the user/shop data. Other modules (booking,
/// sales, custom work) read tax config off the cached `UserCubit.shopDetails`
/// snapshot, not live from here, so that refetch is the only way they see a
/// change made on this screen.
class TaxAndComplianceScreen extends StatelessWidget {
  const TaxAndComplianceScreen({super.key, required this.canManage});

  final bool canManage;

  Future<void> _fetchData(BuildContext context) =>
      context.read<TaxAndComplianceCubit>().loadTaxConfigurations();

  Future<void> _addTaxRule(BuildContext context) async {
    final request = await TaxConfigurationDialog.show(context: context);
    if (request == null || !context.mounted) return;
    await context.read<TaxAndComplianceCubit>().saveTaxConfiguration(request);
  }

  @override
  Widget build(BuildContext context) => PopScope(
    canPop: false,
    onPopInvokedWithResult: (didPop, result) {
      if (didPop) return;
      Navigator.of(
        context,
      ).pop(context.read<TaxAndComplianceCubit>().hasChanges);
    },
    child: Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1200),
            child: BlocConsumer<TaxAndComplianceCubit, TaxAndComplianceState>(
              listenWhen: (previous, current) =>
                  previous != current &&
                  current.maybeMap(
                    orElse: () => false,
                    loaded: (value) =>
                        value.status.isSuccess ||
                        value.status.isFailure ||
                        value.status.isSaving,
                  ),
              listener: (context, state) {
                state.maybeMap(
                  loaded: (value) {
                    if (value.status.isSaving) {
                      GlobalLoadingOverlay.show(context, text: 'Saving...');
                    } else {
                      GlobalLoadingOverlay.hide();
                    }
                    if (value.status.isSuccess && value.message != null) {
                      context.showSnackBar(value.message!);
                    }
                    if (value.status.isFailure && value.message != null) {
                      context.showSnackBar(value.message!, isError: true);
                    }
                  },
                  orElse: () {},
                );
              },
              builder: (context, state) => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _Header(
                    canManage: canManage,
                    showAddButton: state.maybeMap(
                      orElse: () => false,
                      loaded: (value) => value.taxConfigurations.length < 1,
                    ),
                    onAdd: () => _addTaxRule(context),
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                    child: state.when(
                      loading: () =>
                          const Center(child: CircularProgressIndicator()),
                      error: (message) => CustomErrorWidget(
                        errorText: message,
                        onRetry: () => _fetchData(context),
                      ),
                      loaded: (taxConfigurations, _, __) {
                        return RefreshIndicator.adaptive(
                          onRefresh: () async => _fetchData(context),
                          child: taxConfigurations.isEmpty
                              ? EmptyDataWidget(
                                  message: canManage
                                      ? 'No tax rule set up yet.\nTap + Add Tax Rule to create one.'
                                      : 'No tax rule has been set up yet.',
                                  icon: const Icon(
                                    Icons.percent,
                                    size: 54,
                                    color: Colors.grey,
                                  ),
                                  isScrollable: true,
                                  height: 0.7,
                                  childAfterMessage: canManage == false
                                      ? null
                                      : Column(
                                          children: [
                                            const SizedBox(height: 16),
                                            FilledButton.icon(
                                              onPressed: () =>
                                                  _addTaxRule(context),
                                              icon: const Icon(Icons.add),
                                              label: const Text('Add Tax Rule'),
                                            ),
                                          ],
                                        ),
                                )
                              : SingleChildScrollView(
                                  physics:
                                      const AlwaysScrollableScrollPhysics(),
                                  child: LayoutBuilder(
                                    builder: (context, constraints) {
                                      const spacing = 16.0;
                                      const minTileWidth = 340.0;
                                      final columns =
                                          (constraints.maxWidth /
                                                  (minTileWidth + spacing))
                                              .floor()
                                              .clamp(1, 3);
                                      final tileWidth =
                                          (constraints.maxWidth -
                                              spacing * (columns - 1)) /
                                          columns;
                                      return Wrap(
                                        spacing: spacing,
                                        runSpacing: spacing,
                                        children: [
                                          for (final taxConfiguration
                                              in taxConfigurations)
                                            SizedBox(
                                              width: tileWidth,
                                              child: TaxConfigurationCard(
                                                taxConfiguration:
                                                    taxConfiguration,
                                                canManage: canManage,
                                                onToggleEnabled: (isEnabled) =>
                                                    context
                                                        .read<
                                                          TaxAndComplianceCubit
                                                        >()
                                                        .toggleEnabled(
                                                          taxConfiguration.id,
                                                          isEnabled,
                                                        ),
                                                onEdit: () async {
                                                  final request =
                                                      await TaxConfigurationDialog.show(
                                                        context: context,
                                                        initialData:
                                                            taxConfiguration,
                                                      );
                                                  if (request == null ||
                                                      !context.mounted) {
                                                    return;
                                                  }
                                                  await context
                                                      .read<
                                                        TaxAndComplianceCubit
                                                      >()
                                                      .saveTaxConfiguration(
                                                        request,
                                                        taxId:
                                                            taxConfiguration.id,
                                                      );
                                                },
                                              ),
                                            ),
                                        ],
                                      );
                                    },
                                  ),
                                ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    ),
  );
}

class _Header extends StatelessWidget {
  const _Header({
    required this.canManage,
    required this.showAddButton,
    required this.onAdd,
  });

  final bool canManage;
  final bool showAddButton;
  final VoidCallback onAdd;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        InkWell(
          onTap: () => Navigator.of(
            context,
          ).maybePop(context.read<TaxAndComplianceCubit>().hasChanges),
          borderRadius: BorderRadius.circular(8),
          child: const Padding(
            padding: EdgeInsets.all(4),
            child: Icon(Icons.arrow_back, size: 20, color: Color(0xFF2D3436)),
          ),
        ),
        const SizedBox(width: 8),
        const Text(
          'Tax & Compliance',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w400,
            color: Color(0xFF2D3436),
          ),
        ),
        const Spacer(),
        if (canManage && showAddButton)
          FilledButton.icon(
            onPressed: onAdd,
            icon: const Icon(Icons.add),
            label: const Text('Add Tax Rule'),
          ),
      ],
    );
  }
}
