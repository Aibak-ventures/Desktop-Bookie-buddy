import 'package:bookie_buddy_web/core/enums/service_type_enums.dart';
import 'package:bookie_buddy_web/core/models/services_model/services_model.dart';
import 'package:bookie_buddy_web/core/theme/app_colors.dart';
import 'package:bookie_buddy_web/core/view_model/bloc_service/service_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BookingServiceSelectionSection extends StatelessWidget {
  final MainServiceType? serviceTypeSelected;
  final Function(ServicesModel?) onServiceSelected;

  const BookingServiceSelectionSection({
    super.key,
    required this.serviceTypeSelected,
    required this.onServiceSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Select Service',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 12),
          BlocBuilder<ServiceBloc, ServiceState>(
            builder: (context, state) {
              if (state.isLoading) {
                return const Center(
                  child: Padding(
                    padding: EdgeInsets.all(20.0),
                    child: CircularProgressIndicator(),
                  ),
                );
              }

              if (state.errorMessage != null) {
                return Center(
                  child: Text(
                    state.errorMessage!,
                    style: TextStyle(color: Colors.grey.shade600),
                  ),
                );
              }

              final filteredServices = serviceTypeSelected != null
                  ? state.serviceList
                      .where((s) => s.mainServiceType == serviceTypeSelected)
                      .toList()
                  : [];

              if (filteredServices.isEmpty) {
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text(
                      'No services available',
                      style: TextStyle(color: Colors.grey.shade600),
                    ),
                  ),
                );
              }

              return Wrap(
                spacing: 8,
                runSpacing: 8,
                children: filteredServices.map((service) {
                  return InkWell(
                    onTap: () => onServiceSelected(service),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.grey.shade300),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        service.name,
                        style: const TextStyle(
                          fontSize: 13,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              );
            },
          ),
        ],
      ),
    );
  }
}
