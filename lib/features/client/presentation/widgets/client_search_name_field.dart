import 'package:bookie_buddy_web/utils/extensions/number_extensions.dart';
import 'package:bookie_buddy_web/core/theme/app_colors.dart';
import 'package:bookie_buddy_web/core/ui/widgets/custom_shimmer_box.dart';
import 'package:bookie_buddy_web/features/client/presentation/bloc/client_cubit/client_cubit.dart';
import 'package:bookie_buddy_web/features/client/domain/models/client_model/client_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

class ClientSearchNameField extends StatelessWidget {
  const ClientSearchNameField({
    super.key,
    required this.nameController,
    this.scrollController,
    this.onClear,
    this.hitText = 'Client Name',
    this.isSearchEnabled = true,
    this.focusNode,
    this.errorText,
    this.onClientSelected,
  });

  final TextEditingController nameController;
  final ScrollController? scrollController;
  final VoidCallback? onClear;
  final String hitText;
  final bool isSearchEnabled;
  final FocusNode? focusNode;
  final String? errorText;
  final ValueChanged<ClientModel>? onClientSelected;

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TypeAheadField<ClientModel>(
            controller: nameController,
            focusNode: focusNode,
            scrollController: scrollController,
            debounceDuration: const Duration(milliseconds: 200),
            hideOnEmpty: true,
            hideWithKeyboard: false,
            hideOnUnfocus: true,
            hideOnSelect: true,
            decorationBuilder: (context, child) => isSearchEnabled
                ? DecoratedBox(
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: 10.radiusBorder,
                      border: BoxBorder.all(color: AppColors.grey300),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.grey300,
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: child,
                  )
                : const SizedBox.shrink(),
            builder: (context, controller, focusNode) => Container(
              height: 42,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                border: Border.all(
                    color: errorText != null
                        ? Colors.red.shade400
                        : Colors.grey.shade300),
                borderRadius: BorderRadius.circular(8),
                color: Colors.white,
              ),
              alignment: Alignment.centerLeft,
              child: Row(
                children: [
                  Icon(Icons.person,
                      size: 16,
                      color: errorText != null
                          ? Colors.red.shade400
                          : Colors.grey),
                  const SizedBox(width: 8),
                  Expanded(
                    child: TextField(
                      focusNode: focusNode,
                      controller: controller,
                      keyboardType: TextInputType.name,
                      textInputAction: TextInputAction.next,
                      style:
                          const TextStyle(fontSize: 13, color: Colors.black87),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: hitText,
                        hintStyle: TextStyle(
                            fontSize: 13, color: Colors.grey.shade400),
                        isDense: true,
                        contentPadding: EdgeInsets.zero,
                      ),
                    ),
                  ),
                  ValueListenableBuilder(
                    valueListenable: controller,
                    builder: (context, searchValue, child) =>
                        searchValue.text.isEmpty
                            ? const SizedBox.shrink()
                            : IconButton(
                                padding: EdgeInsets.zero,
                                constraints: const BoxConstraints(),
                                onPressed: () {
                                  controller.clear();
                                  context
                                      .read<ClientCubit>()
                                      .clearSelected(onClear);
                                },
                                icon: const Icon(Icons.clear,
                                    size: 16, color: Colors.grey),
                              ),
                  ),
                ],
              ),
            ),
            itemBuilder: (context, client) {
              // Dummy logic for "No results"
              if (client.id == -1) {
                return Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  child: const Text('No client found',
                      style: TextStyle(fontSize: 13, color: Colors.grey)),
                );
              }
              return Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border(
                    bottom: BorderSide(color: Colors.grey.shade100),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      client.name,
                      style: const TextStyle(
                          fontSize: 14, fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      client.phone1.toString(),
                      style: const TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ],
                ),
              );
            },
            suggestionsCallback: (query) async {
              if (!isSearchEnabled) return [];
              if (query.isEmpty) return [];

              // Check if query matches exact selection name to prevent re-opening overlay
              final selected = context.read<ClientCubit>().state.selectedClient;
              if (selected != null &&
                  selected.name.toLowerCase() == query.toLowerCase()) {
                return [];
              }

              final results =
                  await context.read<ClientCubit>().searchClient(query);
              if (results.isEmpty) {
                // Return dummy to show "No client found" while keeping hideOnEmpty: true logic for valid empty search on selection
                return [
                  const ClientModel(id: -1, name: 'No client found', phone1: 0)
                ];
              }
              return results;
            },
            onSelected: (client) {
              if (client.id == -1) return; // Ignore dummy
              context.read<ClientCubit>().selectClient(client);
              onClientSelected?.call(client);
            },
            emptyBuilder: (context) => const SizedBox(
              height: 100,
              child: Center(child: Text('No client found')),
            ),
            errorBuilder: (context, error) => SizedBox(
                height: 100, child: Center(child: Text(error.toString()))),
            loadingBuilder: (context) => ListView.builder(
              itemCount: 4,
              shrinkWrap: true,
              itemBuilder: (context, index) => ListTile(
                title: Row(
                  children: [CustomShimmerBox(width: 0.11.widthR, height: 20)],
                ),
                subtitle: Row(
                  children: [CustomShimmerBox(width: 0.12.widthR, height: 15)],
                ),
              ),
            ),
          ),
          if (errorText != null) ...[
            const SizedBox(height: 4),
            Padding(
              padding: const EdgeInsets.only(left: 4),
              child: Text(
                errorText!,
                style: TextStyle(
                  fontSize: 11,
                  color: Colors.red.shade600,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ],
      );
}
