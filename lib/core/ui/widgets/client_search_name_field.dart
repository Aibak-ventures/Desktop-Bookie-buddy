import 'package:bookie_buddy_web/core/app_input_validators.dart';
import 'package:bookie_buddy_web/core/extensions/number_extensions.dart';
import 'package:bookie_buddy_web/core/theme/app_colors.dart';
import 'package:bookie_buddy_web/core/ui/widgets/custom_shimmer_box.dart';
import 'package:bookie_buddy_web/core/ui/widgets/custom_textfield.dart';
// import 'package:bookie_buddy_web/core/view_model/bloc_client/client_bloc.dart' hide ClientState;
import 'package:bookie_buddy_web/core/view_model/cubit_client/client_cubit.dart' ;
import 'package:bookie_buddy_web/features/add_booking/models/client_model/client_model.dart';
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
  });

  final TextEditingController nameController;
  final ScrollController? scrollController;
  final VoidCallback? onClear;
  final String hitText;
  final bool isSearchEnabled;
  final FocusNode? focusNode;

  @override
  Widget build(BuildContext context) => BlocBuilder<ClientCubit, ClientState>(
    builder: (context, state) => TypeAheadField<ClientModel>(
      controller: nameController,
      focusNode: focusNode,
      scrollController: scrollController,
      hideOnEmpty: !isSearchEnabled,
      hideWithKeyboard: false,
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
      builder: (context, controller, focusNode) => CustomTextField(
        focusNode: focusNode,
        controller: controller,
        hintText: hitText,
        keyboardType: TextInputType.name,
        textInputAction: TextInputAction.next,
        prefixIcon: const Icon(Icons.person),
        suffixIcon: ValueListenableBuilder(
          valueListenable: controller,
          builder: (context, searchValue, child) => searchValue.text.isEmpty
              ? const SizedBox.shrink()
              : IconButton(
                  onPressed: () {
                    controller.clear();
                    context.read<ClientCubit>().clearSelected(onClear);
                  },
                  icon: const Icon(Icons.clear),
                ),
        ),
        validator: AppInputValidators.name,
      ),
      itemBuilder: (context, client) => ListTile(
        title: Text(client.name),
        subtitle: Text(client.phone1.toString()),
      ),
      suggestionsCallback: (query) async {
        if (isSearchEnabled)
          return context.read<ClientCubit>().searchClient(query);
        return null;
      },
      onSelected: (client) {
        context.read<ClientCubit>().selectClient(client);
      },
      emptyBuilder: (context) => const SizedBox(
        height: 100,
        child: Center(child: Text('No client found')),
      ),
      errorBuilder: (context, error) =>
          SizedBox(height: 100, child: Center(child: Text(error.toString()))),
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
  );
}
