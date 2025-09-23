import 'package:bookie_buddy_web/core/app_input_validators.dart';
import 'package:bookie_buddy_web/core/extensions/number_extensions.dart';
import 'package:bookie_buddy_web/core/theme/app_colors.dart';
import 'package:bookie_buddy_web/core/ui/widgets/custom_textfield.dart';
import 'package:bookie_buddy_web/core/view_model/bloc_client/client_bloc.dart';
import 'package:bookie_buddy_web/features/add_booking/models/client_model/client_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

class ClientSearchNameField extends StatelessWidget {
  const ClientSearchNameField({
    super.key,
    required this.nameController,
    required this.scrollController,
    this.onClear,
    this.hitText = 'Client Name',
  });

  final TextEditingController nameController;
  final ScrollController scrollController;
  final VoidCallback? onClear;
  final String hitText;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ClientBloc, ClientState>(
      builder: (context, state) {
        return TypeAheadField<ClientModel>(
          controller: nameController,
          scrollController: scrollController,
          hideOnSelect: true,
          decorationBuilder: (context, child) {
            return Container(
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: 10.radiusBorder,
                border: BoxBorder.all(
                  color: AppColors.grey300,
                ),
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
            );
          },
          builder: (context, controller, focusNode) {
            return CustomTextField(
              focusNode: focusNode,
              controller: controller,
              hintText: hitText,
              keyboardType: TextInputType.name,
              prefixIcon: const Icon(
                Icons.person,
              ),
              suffixIcon: ValueListenableBuilder(
                  valueListenable: controller,
                  builder: (context, searchValue, child) {
                    return searchValue.text.isEmpty
                        ? const SizedBox.shrink()
                        : IconButton(
                            onPressed: () {
                              controller.clear();
                              context
                                  .read<ClientBloc>()
                                  .add(ClientEvent.clearSelected(onClear));
                              // onClear?.call();
                            },
                            icon: const Icon(Icons.clear),
                          );
                  }),
              validator: AppInputValidators.name,
              onChanged: (value) {
                if (!state.isLoading)
                  context
                      .read<ClientBloc>()
                      .add(ClientEvent.searchQueryChanged(value));
              },
            );
          },
          itemBuilder: (context, suggestion) {
            return ListTile(
              title: Text(suggestion.name),
              subtitle: Text(suggestion.phone1.toString()),
            );
          },
          suggestionsCallback: (pattern) async {
            // final state = context.read<ClientBloc>().state;
            return state.suggestions;
          },
          onSelected: (client) {
            context.read<ClientBloc>().add(ClientEvent.clientSelected(client));
          },
          emptyBuilder: (context) => const SizedBox(
            height: 100,
            child: Center(child: Text('No client found')),
          ),
          errorBuilder: (context, error) => SizedBox(
            height: 100,
            child: Center(child: Text(error.toString())),
          ),
          loadingBuilder: (context) => const Padding(
            padding: EdgeInsets.all(8.0),
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
