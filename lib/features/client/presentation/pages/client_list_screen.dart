import 'package:bookie_buddy_web/core/di/app_dependencies.dart';
import 'package:bookie_buddy_web/utils/extensions/context_extensions.dart';
import 'package:bookie_buddy_web/utils/extensions/number_extensions.dart';
import 'package:bookie_buddy_web/core/theme/app_colors.dart';
import 'package:bookie_buddy_web/core/ui/widgets/custom_error_text_widget.dart';
import 'package:bookie_buddy_web/core/ui/widgets/custom_normal_elevated_button.dart';
import 'package:bookie_buddy_web/core/ui/widgets/empty_data_widget.dart';
import 'package:bookie_buddy_web/features/client/presentation/bloc/client_list_bloc/client_list_bloc.dart';
import 'package:bookie_buddy_web/features/client/domain/models/client_model/client_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/models/client_request_model/client_request_model.dart';
import '../widgets/show_add_client_dialog.dart';

class ClientListScreen extends StatelessWidget {
  const ClientListScreen({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider(
        create: (context) => ClientListBloc(
            addClient: getIt.get(),
            getClients: getIt.get(),
            updateClient: getIt.get(),
            deleteClient: getIt.get())
          ..add(const ClientListEvent.loadClients()),
        child: const _ClientListView(),
      );
}

class _ClientListView extends StatefulWidget {
  const _ClientListView();

  @override
  State<_ClientListView> createState() => _ClientListViewState();
}

class _ClientListViewState extends State<_ClientListView> {
  final TextEditingController searchController = TextEditingController();

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  void _fetchData(BuildContext context) {
    context.read<ClientListBloc>().add(const ClientListEvent.loadClients());
  }

  void _onSearch(String query) {
    context.read<ClientListBloc>().add(
          ClientListEvent.loadClients(
            searchQuery: query.trim().isEmpty ? null : query.trim(),
          ),
        );
  }

  void _showAddClientDialog({ClientModel? client}) {
    showAddClientDialog(
      context: context,
      client: client,
      onPressed: (dialogContext, name, phone1, phone2) {
        final bloc = context.read<ClientListBloc>();
        final model = ClientRequestModel(
          id: client?.id,
          name: name,
          phone1: int.tryParse(phone1) ?? 0,
          phone2: int.tryParse(phone2),
        );

        if (client == null) {
          bloc.add(ClientListEvent.addClient(model));
        } else {
          bloc.add(ClientListEvent.editClient(model));
        }
      },
    );
  }

  void _showDeleteDialog(ClientModel client) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Delete Client'),
        content: Text('Are you sure you want to delete "${client.name}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: const Text('Cancel'),
          ),
          BlocConsumer<ClientListBloc, ClientListState>(
            listener: (context, state) {
              state.maybeMap(
                orElse: () {},
                success: (value) {
                  Navigator.of(dialogContext).pop();
                  context.showSnackBar(value.message);
                  if (value.needRefresh) {
                    _fetchData(context);
                  }
                },
                error: (value) {
                  context.showSnackBar(value.error, isError: true);
                },
              );
            },
            builder: (context, state) {
              final isDeleting = state.maybeMap(
                orElse: () => false,
                loading: (_) => true,
              );

              return CustomNormalElevatedButton(
                text: 'Delete',
                color: AppColors.redTomato,
                isLoading: isDeleting,
                onPressed: () {
                  context
                      .read<ClientListBloc>()
                      .add(ClientListEvent.deleteClient(client));
                },
              );
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Clients'),
          centerTitle: true,
        ),
        body: Padding(
          padding: 16.padding,
          child: Column(
            children: [
// 🔍 Search bar
              TextField(
                controller: searchController,
                decoration: InputDecoration(
                  hintText: 'Search by name or phone number...',
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: searchController.text.isNotEmpty
                      ? IconButton(
                          icon: const Icon(Icons.clear),
                          onPressed: () {
                            searchController.clear();
                            _onSearch('');
                          },
                        )
                      : null,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onChanged: _onSearch,
              ),
              const SizedBox(height: 16),

              // 📋 Client list
              Expanded(
                child: BlocConsumer<ClientListBloc, ClientListState>(
                  listener: (context, state) {
                    state.maybeMap(
                      success: (value) {
                        context.showSnackBar(
                          value.message,
                          isError: false,
                        );
                        if (value.needRefresh) {
                          _fetchData(context);
                        }
                      },
                      error: (value) {
                        context.showSnackBar(
                          value.error,
                          isError: true,
                        );
                      },
                      orElse: () {},
                    );
                  },
                  builder: (context, state) {
                    return state.maybeWhen(
                      loading: () => const Center(
                        child: CircularProgressIndicator(),
                      ),
                      error: (error) => CustomErrorWidget(
                        errorText: error,
                        onRetry: () => _fetchData(context),
                      ),
                      loaded: (clients, nextPageUrl, isPaginating, _, __) {
                        if (clients.isEmpty) {
                          return const EmptyDataWidget(
                            message: 'No clients found. Tap + to add new.',
                            isShowIcon: false,
                          );
                        }

                        return RefreshIndicator.adaptive(
                          onRefresh: () async => _fetchData(context),
                          child: ListView.builder(
                            itemCount: clients.length + (isPaginating ? 1 : 0),
                            itemBuilder: (context, index) {
                              if (index >= clients.length) {
                                return const Padding(
                                  padding: EdgeInsets.all(16),
                                  child: Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                );
                              }
                              final client = clients[index];
                              return Card(
                                margin: 8.paddingVertical,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: ListTile(
                                  leading: CircleAvatar(
                                    backgroundColor:
                                        AppColors.purple.withOpacity(0.2),
                                    child: const Icon(Icons.person,
                                        color: AppColors.purple),
                                  ),
                                  title: Text(client.name),
                                  subtitle: Text(
                                    'Phone 1: ${client.phone1}\n'
                                    'Phone 2: ${client.phone2 ?? '-'}',
                                  ),
                                  isThreeLine: true,
                                  trailing: Wrap(
                                    spacing: 8,
                                    children: [
                                      IconButton(
                                        icon: const Icon(Icons.edit,
                                            color: Colors.blue),
                                        onPressed: () => _showAddClientDialog(
                                            client: client),
                                      ),
                                      IconButton(
                                        icon: const Icon(Icons.delete,
                                            color: Colors.red),
                                        onPressed: () =>
                                            _showDeleteDialog(client),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      },
                      orElse: () => const Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          label:
              const Text('Add Client', style: TextStyle(color: Colors.white)),
          icon: const Icon(Icons.person_add_alt_1_rounded, color: Colors.white),
          backgroundColor: AppColors.purple,
          onPressed: () => _showAddClientDialog(),
        ),
      );
}
