import 'package:bookie_buddy_web/core/app_input_validators.dart';
import 'package:bookie_buddy_web/core/constants/enums/service_type_enums.dart';
import 'package:bookie_buddy_web/utils/extensions/context_extensions.dart';
import 'package:bookie_buddy_web/utils/extensions/date_time_extensions.dart';
import 'package:bookie_buddy_web/utils/extensions/string_extensions.dart';
import 'package:bookie_buddy_web/utils/extensions/widget_extensions.dart';
import 'package:bookie_buddy_web/core/models/services_model/services_model.dart';
import 'package:bookie_buddy_web/core/ui/widgets/custom_button.dart';
import 'package:bookie_buddy_web/core/ui/widgets/custom_textfield.dart';
import 'package:bookie_buddy_web/core/ui/widgets/show_custom_bottom_sheet.dart';
import 'package:bookie_buddy_web/utils/responsive_helper.dart';
import 'package:bookie_buddy_web/core/view_model/bloc_service/service_bloc.dart';
import 'package:bookie_buddy_web/features/select_product_booking/view/select_product_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CheckAvailabilityScreen extends StatefulWidget {
  const CheckAvailabilityScreen({super.key});

  @override
  State<CheckAvailabilityScreen> createState() =>
      _CheckAvailabilityScreenState();
}

class _CheckAvailabilityScreenState extends State<CheckAvailabilityScreen> {
  @override
  void initState() {
    super.initState();
    // Show the service and date selection dialog immediately
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _showServiceDateSelectionDialog();
    });
  }

  Future<void> _showServiceDateSelectionDialog() async {
    if (context.read<ServiceBloc>().getServices().isEmpty) {
      context.read<ServiceBloc>().add(const ServiceEvent.loadServices());
    }

    final dateController = TextEditingController(
      text: DateTime.now().format(),
    );
    int? serviceId;
    final isDesktop = ResponsiveHelper.isDesktop(context);

    final result = await showCustomBottomSheet(
      context,
      isDraggable: false,
      child: SizedBox(
        width: isDesktop ? 500 : double.infinity,
        child: Padding(
          padding: EdgeInsets.all(isDesktop ? 24 : 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.calendar_today,
                    color: const Color(0xFF667eea),
                    size: isDesktop ? 28 : 24,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Check Availability',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: isDesktop ? 20 : 18,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Text(
                'Select service and date to check product availability',
                style: TextStyle(
                  fontSize: isDesktop ? 14 : 13,
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 24),

              // Service Selection
              BlocBuilder<ServiceBloc, ServiceState>(
                builder: (context, state) {
                  final services = state.maybeWhen(
                    orElse: () => <ServicesModel>[],
                    loaded: (services) => services,
                  );

                  // Filter out material services
                  final availableServices = services
                      .where((e) => !MainServiceType.fromString(
                            e.mainServiceName,
                          ).isMaterial)
                      .toList();

                  if (availableServices.isNotEmpty && serviceId == null) {
                    serviceId = availableServices.first.id;
                  }

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Service',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey[700],
                        ),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey[300]!),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: DropdownButtonFormField<int>(
                          initialValue: serviceId,
                          decoration: const InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 12,
                            ),
                            border: InputBorder.none,
                          ),
                          hint: const Text('Select Service'),
                          isExpanded: true,
                          items: availableServices
                              .map(
                                (service) => DropdownMenuItem(
                                  value: service.id,
                                  child: Text(service.name),
                                ),
                              )
                              .toList(),
                          onChanged: (value) {
                            if (value != null) {
                              setState(() {
                                serviceId = value;
                              });
                            }
                          },
                        ),
                      ),
                    ],
                  );
                },
              ),

              const SizedBox(height: 20),

              // Date Selection
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Date',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey[700],
                    ),
                  ),
                  const SizedBox(height: 8),
                  CustomTextField(
                    controller: dateController,
                    ignorePointers: true,
                    hintText: 'Select availability date',
                    validator: (value) => AppInputValidators.isEmpty(value)
                        ? 'Please select date'
                        : null,
                    suffixIcon: const Icon(Icons.calendar_today, size: 20),
                  ).onTap(() async {
                    final picked = await showDatePicker(
                      context: context,
                      initialDate: dateController.text.isNotNullOrEmpty
                          ? dateController.text.parseToDateTime()
                          : DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime.now().add(
                        const Duration(days: 365),
                      ),
                    );

                    if (picked != null) {
                      dateController.text = picked.format();
                    }
                  }),
                ],
              ),

              const SizedBox(height: 28),

              // Action Buttons
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.of(context).pop(),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text('Cancel'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    flex: 2,
                    child: CustomElevatedButton(
                      text: 'Check Availability',
                      onPressed: () {
                        if (serviceId == null) {
                          context.showSnackBar(
                            'Please select a service',
                            isError: true,
                          );
                          return;
                        }
                        if (dateController.text.isNullOrEmpty) {
                          context.showSnackBar(
                            'Please select a date',
                            isError: true,
                          );
                          return;
                        }
                        final selectedDate =
                            dateController.text.parseToDateTime();
                        if (selectedDate.isBefore(
                          DateTime.now().subtract(const Duration(days: 1)),
                        )) {
                          context.showSnackBar(
                            'Please select a valid date',
                            isError: true,
                          );
                          return;
                        }

                        Navigator.of(context).pop({
                          'serviceId': serviceId,
                          'date': dateController.text,
                        });
                      },
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );

    // Navigate to select products screen if service and date were selected
    if (result != null && result is Map<String, dynamic>) {
      final serviceId = result['serviceId'] as int;
      final date = result['date'] as String;

      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => SelectProductScreen(
            serviceId: serviceId,
            pickupDate: date,
            returnDate: date,
            useAvailableProductsApi: true,
            availabilityCheckOnly: true,
          ),
        ),
      );
    } else {
      // User cancelled, go back
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    // Show loading while dialog appears
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
