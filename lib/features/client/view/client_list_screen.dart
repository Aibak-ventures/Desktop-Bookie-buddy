import 'package:bookie_buddy_web/core/extensions/context_extensions.dart';
import 'package:bookie_buddy_web/core/extensions/number_extensions.dart';
import 'package:bookie_buddy_web/core/extensions/string_extensions.dart';
import 'package:bookie_buddy_web/core/theme/app_colors.dart';
import 'package:bookie_buddy_web/core/ui/dialogs/show_add_client_dialog.dart';
import 'package:bookie_buddy_web/core/ui/widgets/custom_error_text_widget.dart';
import 'package:bookie_buddy_web/core/ui/widgets/custom_responsive_builder.dart';
import 'package:bookie_buddy_web/core/ui/widgets/custom_search_field.dart';
import 'package:bookie_buddy_web/features/add_booking/models/client_model/client_model.dart';
import 'package:bookie_buddy_web/features/booking_details/models/client_request_model/client_request_model.dart';
import 'package:bookie_buddy_web/features/client/view/widgets/client_list_tile.dart';
import 'package:bookie_buddy_web/features/client/view_model/bloc_client_list/client_list_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ClientListScreen extends StatelessWidget {
  const ClientListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          ClientListBloc()..add(const ClientListEvent.loadClients()),
      child: ClientListView(),
    );
  }
}

class ClientListView extends StatelessWidget {
  ClientListView({super.key});
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Clients',
        ),
      ),
      body: Column(
        children: [
          CustomSearchField(
            searchController: searchController,
            hintText: 'Search by name or phone number',
            onChanged: (query) {
              context
                  .read<ClientListBloc>()
                  .add(ClientListEvent.loadClients(searchQuery: query));
            },
            suffixFunction: () {
              searchController.clear();
              context
                  .read<ClientListBloc>()
                  .add(const ClientListEvent.loadClients());
            },
          ),
          Expanded(
            child: BlocConsumer<ClientListBloc, ClientListState>(
              listener: (context, state) {
                state.maybeMap(
                  orElse: () {},
                  error: (value) => context.showSnackBar(
                    value.error,
                    isError: true,
                  ),
                  failure: (value) => context.showSnackBar(
                    value.message,
                    isError: true,
                  ),
                  success: (value) {
                    if (value.didPop) {
                      context.pop();
                    }

                    context.showSnackBar(
                      value.message,
                    );

                    if (value.needRefresh)
                      context
                          .read<ClientListBloc>()
                          .add(const ClientListEvent.loadClients());
                  },
                );
              },
              buildWhen: (previous, current) {
                return current.maybeMap(
                  orElse: () => true,
                  failure: (value) => false,
                  success: (value) => false,
                );
              },
              builder: (context, state) {
                return state.maybeWhen(
                  orElse: () => const SizedBox(),
                  loading: () => CustomResponsiveBuilder(
                    builder: (context, deviceType) {
                      if (!deviceType.isMobile) {
                        return GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 8,
                            crossAxisSpacing: 15,
                            childAspectRatio: 2,
                          ),
                          padding: 16.padding,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: 12.paddingOnly(
                                bottom: true,
                              ),
                              child: const ClientListTileShimmer(),
                            );
                          },
                        );
                      }
                      return ListView.builder(
                          padding: 14.padding,
                          itemCount: 15,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: 12.paddingOnly(
                                bottom: true,
                              ),
                              child: const ClientListTileShimmer(),
                            );
                          });
                    },
                  ),
                  error: (error) => CustomErrorWidget(
                    errorText: error,
                    onRetry: () {
                      context.read<ClientListBloc>().add(
                            ClientListEvent.loadClients(
                              searchQuery: searchController.text.isNotEmpty
                                  ? searchController.text.trim()
                                  : null,
                            ),
                          );
                    },
                  ),
                  loaded: (
                    clients,
                    nextPageUrl,
                    isPaginating,
                    isLoading,
                    searchQuery,
                  ) {
                    if (clients.isEmpty) {
                      return const CustomErrorWidget(
                        icon: Icon(Icons.people_outline_rounded),
                        errorText: 'No clients found',
                        showRetry: false,
                      );
                    }
                    return RefreshIndicator(
                      onRefresh: () async {
                        context
                            .read<ClientListBloc>()
                            .add(ClientListEvent.loadClients(
                              searchQuery: searchQuery,
                            ));
                      },
                      child: NotificationListener<ScrollNotification>(
                        onNotification: (notification) {
                          if (!isPaginating &&
                              !isLoading &&
                              nextPageUrl != null &&
                              notification.metrics.pixels >=
                                  notification.metrics.maxScrollExtent - 200) {
                            context.read<ClientListBloc>().add(
                                const ClientListEvent.loadNextPageClients());
                          }
                          return false;
                        },
                        child: CustomResponsiveBuilder(
                          builder: (context, deviceType) {
                            if (deviceType.isMobile) {
                              return ListView.builder(
                                padding: 14.padding,
                                itemCount:
                                    clients.length + (isPaginating ? 1 : 0),
                                itemBuilder: (context, index) {
                                  return _buildListItem(
                                    context,
                                    index,
                                    clients,
                                  );
                                },
                              );
                            }
                            return GridView.builder(
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                mainAxisSpacing: 8,
                                crossAxisSpacing: 15,
                                childAspectRatio: 2,
                              ),
                              padding: 16.padding,
                              itemCount:
                                  clients.length + (isPaginating ? 1 : 0),
                              itemBuilder: (context, index) {
                                return _buildListItem(
                                  context,
                                  index,
                                  clients,
                                  isGrid: true,
                                );
                              },
                            );
                          },
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _addClient(context),
        icon: const Icon(Icons.person_add_rounded),
        label: const Text('Add Client'),
        foregroundColor: AppColors.white,
        backgroundColor: AppColors.purple,
      ),
    );
  }

  Widget? _buildListItem(
    BuildContext context,
    int index,
    List<ClientModel> clients, {
    bool isGrid = false,
  }) {
    if (index == clients.length) {
      return const Center(
        child: ClientListTileShimmer(),
      );
    }
    final client = clients[index];
    return Padding(
      padding: 12.paddingOnly(
        bottom: true,
      ),
      child: ClientListTile(
        client: client,
        isGrid: isGrid,
        onDelete: () {
          if (client.id == null) {
            return;
          }
          _deleteClient(
            context,
            client,
          );
        },
        onEdit: () {
          showAddClientDialog(
            context: context,
            client: client,
            onPressed: (dialogContext, name, phone1, phone2) {
              if (client.name == name &&
                  client.phone1 == phone1.toInt() &&
                  client.phone2 == phone2.toIntOrNull()) {
                context.pop();
                context.showSnackBar(
                  'No changes were made',
                );
                return;
              }
              context.read<ClientListBloc>().add(
                    ClientListEvent.editClient(
                      ClientRequestModel(
                        id: client.id,
                        name: name,
                        phone1: phone1.toInt(),
                        phone2: phone2.toIntOrNull(),
                      ),
                    ),
                  );
            },
          );
        },
      ),
    );
  }

  void _addClient(BuildContext context) {
    showAddClientDialog(
      context: context,
      onPressed: (dialogContext, name, phone1, phone2) {
        context.read<ClientListBloc>().add(
              ClientListEvent.addClient(
                ClientRequestModel(
                  id: null,
                  name: name,
                  phone1: phone1.toInt(),
                  phone2: phone2.toIntOrNull(),
                ),
              ),
            );
      },
    );
  }

  Future<void> _deleteClient(BuildContext context, ClientModel client) async {
    final shouldDelete = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Client'),
        content: Text('Are you sure you want to delete ${client.name}?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(true),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text(
              'Delete',
              style: TextStyle(color: AppColors.white),
            ),
          ),
        ],
      ),
    );

    if (shouldDelete == true && client.id != null) {
      context.read<ClientListBloc>().add(ClientListEvent.deleteClient(client));
    }
  }
}
