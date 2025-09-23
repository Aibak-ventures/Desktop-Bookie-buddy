import 'dart:developer';

import 'package:bookie_buddy_web/core/extensions/context_extensions.dart';
import 'package:bookie_buddy_web/core/extensions/number_extensions.dart';
import 'package:bookie_buddy_web/core/extensions/string_extensions.dart';
import 'package:bookie_buddy_web/core/theme/app_colors.dart';
import 'package:bookie_buddy_web/core/ui/dialogs/show_add_client_dialog.dart';
import 'package:bookie_buddy_web/core/ui/widgets/client_search_name_field.dart';
import 'package:bookie_buddy_web/core/view_model/bloc_client/client_bloc.dart';
import 'package:bookie_buddy_web/features/add_booking/view_model/bloc_client_save/client_save_bloc.dart';
import 'package:bookie_buddy_web/features/booking_details/models/client_request_model/client_request_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ClientSelectWidget extends StatefulWidget {
  ClientSelectWidget({
    super.key,
    required TextEditingController nameController,
    required TextEditingController phone1Controller,
    required TextEditingController phone2Controller,
    this.textSize,
    this.spacing,
  })  : _nameController = nameController,
        _phone1Controller = phone1Controller,
        _phone2Controller = phone2Controller;

  // controllers
  final TextEditingController _nameController;
  final TextEditingController _phone1Controller;
  final TextEditingController _phone2Controller;

  //
  final double? textSize;
  final double? spacing;

  @override
  State<ClientSelectWidget> createState() => _ClientSelectWidgetState();
}

class _ClientSelectWidgetState extends State<ClientSelectWidget> {
  final scrollController = ScrollController();

  void _onScroll() {
    final bloc = context.read<ClientBloc>();
    final isLoadNext = bloc.state.when(
      initial: (suggestions, selectedClient, searchQuery, nextPageUrl,
              isLoading) =>
          selectedClient == null &&
          searchQuery.isNotEmpty &&
          nextPageUrl != null &&
          !isLoading,
    );
    if (scrollController.hasClients &&
        scrollController.position.maxScrollExtent - 50 >=
            scrollController.position.pixels &&
        isLoadNext) {
      bloc.add(const ClientEvent.loadNextData());
    }
  }

  @override
  void initState() {
    scrollController.addListener(_onScroll);
    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ClientBloc, ClientState>(
      listener: (context, state) {
        state.when(
          initial: (
            suggestions,
            selectedClient,
            searchQuery,
            nextPageUrl,
            isLoading,
          ) {
            if (selectedClient != null) {
              print('selected client: ${selectedClient}');
              widget._nameController.text = selectedClient.name;
              widget._phone1Controller.text = selectedClient.phone1.toString();
              widget._phone2Controller.text =
                  selectedClient.phone2?.toString() ?? '';
              context.hideKeyboard();
            }
          },
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: widget.spacing?.w ?? 0.05.widthR,
        children: [
          Padding(
            padding: 8.paddingHorizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    'Client Details',
                    style: TextStyle(
                      fontSize: widget.textSize?.sp ?? 20.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                BlocListener<ClientSaveBloc, ClientSaveState>(
                  listener: (context, state) {
                    state.maybeWhen(
                      orElse: () {
                        log('orElse');
                      },
                      failure: (message) {
                        log('message: $message');
                        context.showSnackBar(
                          message,
                          isError: true,
                        );
                      },
                      success: (message, client) {
                        log('client: $client');
                        context.pop();
                        context.showSnackBar(message);

                        context
                            .read<ClientBloc>()
                            .add(ClientEvent.clientSelected(client));
                      },
                    );
                  },
                  child: ElevatedButton.icon(
                    onPressed: () async {
                      await showAddClientDialog(
                        context: context,
                        onPressed: (dialogContext, name, phone1, phone2) {
                          context.read<ClientSaveBloc>().add(
                                ClientSaveEvent.saveClient(
                                  ClientRequestModel(
                                    id: null,
                                    name: name,
                                    phone1: phone1.toInt(),
                                    phone2: phone2.toIntOrNull(),
                                  ),
                                ),
                              );
                          // context.pop();
                        },
                      );
                    },
                    icon: const Icon(Icons.add),
                    label: const Text(
                      'Add Client',
                      style: TextStyle(
                        color: AppColors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          // 0.01.heightCustom,

          ClientSearchNameField(
            nameController: widget._nameController,
            scrollController: scrollController,
            hitText: 'Search existing client',
          ),

          // 0.03.heightCustom,

          /// Phone Number 1
          ValueListenableBuilder(
            valueListenable: widget._phone1Controller,
            builder: (context, value, child) {
              return phoneDisplay(
                label: 'Phone Number 1 (auto-filled)',
                phoneNumber: value.text.isEmpty ? '' : value.text,
                icon: Icons.phone,
              );
            },
          ),

          // 0.02.heightCustom,

          /// Phone Number 2
          ValueListenableBuilder(
            valueListenable: widget._phone2Controller,
            builder: (context, value, child) {
              return phoneDisplay(
                label: 'Phone Number 2 (auto-filled)',
                phoneNumber: value.text.isEmpty ? '' : value.text,
                icon: Icons.phone,
              );
            },
          ),
        ],
      ),
    );
  }
}

Widget phoneDisplay({
  required String label,
  required String phoneNumber,
  required IconData icon,
}) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
    decoration: BoxDecoration(
      color: AppColors.white,
      borderRadius: 5.radiusBorder,
      border: Border.all(color: Colors.grey.shade400),
    ),
    child: Row(
      children: [
        Icon(
          icon,
          color: AppColors.purple,
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                ),
              ),
              Text(
                phoneNumber,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        const Icon(
          Icons.lock,
          size: 18,
          color: Colors.grey,
        ), // shows it's not editable
      ],
    ),
  );
}
