import 'package:bookie_buddy_web/utils/extensions/number_extensions.dart';
import 'package:bookie_buddy_web/core/models/services_model/services_model.dart';
import 'package:bookie_buddy_web/core/common/widgets/custom_error_text_widget.dart';
import 'package:bookie_buddy_web/core/common/widgets/custom_responsive_builder.dart';
import 'package:bookie_buddy_web/core/common/widgets/empty_data_widget.dart';
import 'package:bookie_buddy_web/core/common/widgets/service_card.dart';
import 'package:bookie_buddy_web/core/view_model/bloc_service/service_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SelectServiceScreen extends StatelessWidget {
  const SelectServiceScreen({
    required this.onServiceSelected,
    super.key,
  });
  final void Function(ServicesModel service, BuildContext context)
      onServiceSelected;
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        context.read<ServiceBloc>().add(const ServiceEvent.loadServices());
      },
    );
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Service'),
      ),
      body: RefreshIndicator.adaptive(
        onRefresh: () async {
          context.read<ServiceBloc>().add(const ServiceEvent.loadServices());
        },
        child: BlocBuilder<ServiceBloc, ServiceState>(
          builder: (context, state) {
            return state.when(
              loading: () => const Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                    Color(0xFF2575FC),
                  ),
                ),
              ),
              error: (error) => Center(
                child: CustomErrorWidget(
                  errorText: error,
                  onRetry: () => context
                      .read<ServiceBloc>()
                      .add(const ServiceEvent.loadServices()),
                ),
              ),
              loaded: (services) {
                return services.isEmpty
                    ? const EmptyDataWidget(
                        height: 0.8,
                        isScrollable: true,
                        isShowIcon: false,
                        message: 'No services available',
                      )
                    : CustomResponsiveBuilder(
                        builder: (context, deviceType) {
                          if (deviceType.isMobile) {
                            return ListView.builder(
                              itemCount: services.length,
                              padding: 16.padding,
                              itemBuilder: (context, index) {
                                final service = services[index];
                                print(service);
                                return ServiceCard(
                                  serviceName: service.name,
                                  icon: service.icon,
                                  onTap: () =>
                                      onServiceSelected(service, context),
                                );
                              },
                            );
                          } else {
                            return GridView.builder(
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 5,
                                childAspectRatio: 1,
                              ),
                              padding: 15.padding,
                              itemCount: services.length,
                              itemBuilder: (context, index) {
                                final service = services[index];
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ServiceCard(
                                    isGrid: true,
                                    serviceName: service.name,
                                    icon: service.icon,
                                    onTap: () =>
                                        onServiceSelected(service, context),
                                  ),
                                );
                              },
                            );
                          }
                        },
                      );
              },
            );
          },
        ),
      ),
    );
  }
}
