// import 'dart:developer';

// import 'package:bookie_buddy_web/core/enums/booking_status_enums.dart';
// import 'package:bookie_buddy_web/core/enums/payment_method_enums.dart';
// import 'package:bookie_buddy_web/core/extensions/context_extensions.dart';
// import 'package:bookie_buddy_web/core/extensions/date_time_extensions.dart';
// import 'package:bookie_buddy_web/core/extensions/number_extensions.dart';
// import 'package:bookie_buddy_web/core/extensions/string_extensions.dart';
// import 'package:bookie_buddy_web/core/extensions/widget_extensions.dart';
// import 'package:bookie_buddy_web/core/models/product_info_model/product_info_model.dart';
// import 'package:bookie_buddy_web/core/repositories/client_repository.dart';
// import 'package:bookie_buddy_web/core/repositories/product_repository.dart';
// import 'package:bookie_buddy_web/core/theme/app_colors.dart';
// import 'package:bookie_buddy_web/core/ui/widgets/custom_textfield.dart';
// import 'package:bookie_buddy_web/core/view_model/bloc_service/service_bloc.dart';
// import 'package:bookie_buddy_web/core/view_model/cubit_client/client_cubit.dart';
// import 'package:bookie_buddy_web/core/view_model/user_cubit.dart';
// import 'package:bookie_buddy_web/features/add_booking/models/additional_charges_model/additional_charges_model.dart';
// import 'package:bookie_buddy_web/features/add_booking/models/client_model/client_model.dart';
// import 'package:bookie_buddy_web/features/add_booking/models/request_booking_model/request_booking_model.dart';
// import 'package:bookie_buddy_web/features/add_booking/view/widgets/calender_widget.dart';
// import 'package:bookie_buddy_web/features/select_product_booking/models/product_selected_model/product_selected_model.dart';
// import 'package:bookie_buddy_web/features/select_product_booking/view/view_model/bloc_select_product/select_product_bloc.dart';
// import 'package:bookie_buddy_web/src/di/injection.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// enum BookingType { booking, sales }

// class NewBookingScreen extends StatefulWidget {
//   final VoidCallback? onClose;

//   const NewBookingScreen({super.key, this.onClose});

//   @override
//   State<NewBookingScreen> createState() => _NewBookingScreenState();
// }

// class _NewBookingScreenState extends State<NewBookingScreen> {
//   BookingType selectedBookingType = BookingType.booking;
//   final _formKey = GlobalKey<FormState>();

//   // Date controllers
//   late DateTime pickupDate;
//   late DateTime returnDate;
//   DateTime? coolingPeriodDate;
//   TimeOfDay? pickupTime;
//   TimeOfDay? returnTime;

//   final pickupDateNotifier = ValueNotifier<DateTime>(DateTime.now());
//   final returnDateController = TextEditingController();
//   final coolingPeriodDateController = TextEditingController();
//   final pickupTimeController = TextEditingController();
//   final returnTimeController = TextEditingController();

//   // Client details
//   final clientNameController = TextEditingController();
//   final clientPhone1Controller = TextEditingController();
//   final clientAddressController = TextEditingController();
//   final staffNameController = TextEditingController();
//   int? selectedStaffId;
//   int? selectedClientId;

//   // Payment controllers
//   final advanceAmountController = TextEditingController();
//   final securityAmountController = TextEditingController();
//   final discountAmountController = TextEditingController();
//   PaymentMethod paymentMethod = PaymentMethod.gPay;
//   DeliveryStatus deliveryStatus = DeliveryStatus.booked;

//   // Products
//   final selectedProductsNotifier = ValueNotifier<List<ProductSelectedModel>>([]);
//   final additionalChargesNotifier = ValueNotifier<List<AdditionalChargesModel>>([]);

//   // Service selection
//   int? selectedServiceId;
//   final serviceSearchController = TextEditingController();

//   // SelectProductBloc for inline search
//   late SelectProductBloc _selectProductBloc;
//   late ClientCubit _clientCubit;
//   late int coolingPeriodDuration;

//   @override
//   void initState() {
//     super.initState();
//     pickupDate = DateTime.now();
//     returnDate = DateTime.now().add(const Duration(days: 1));
//     returnDateController.text = returnDate.format();

//     coolingPeriodDuration = context.read<UserCubit>().state?.shopSettings.coolingPeriodDuration ?? 0;
//     final coolingPeriod = returnDate.add(Duration(days: coolingPeriodDuration)).format();
//     coolingPeriodDateController.text = coolingPeriod;

//     // Initialize BLoCs
//     _selectProductBloc = SelectProductBloc(repository: getIt<ProductRepository>());
//     _clientCubit = ClientCubit(repository: getIt<ClientRepository>());

//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       context.read<ServiceBloc>().add(const ServiceEvent.loadServices());
//     });

//     serviceSearchController.addListener(_onSearchChanged);
//   }

//   @override
//   void dispose() {
//     clientNameController.dispose();
//     clientPhone1Controller.dispose();
//     clientAddressController.dispose();
//     staffNameController.dispose();
//     advanceAmountController.dispose();
//     securityAmountController.dispose();
//     discountAmountController.dispose();
//     returnDateController.dispose();
//     coolingPeriodDateController.dispose();
//     pickupTimeController.dispose();
//     returnTimeController.dispose();
//     selectedProductsNotifier.dispose();
//     additionalChargesNotifier.dispose();
//     serviceSearchController.removeListener(_onSearchChanged);
//     serviceSearchController.dispose();
//     pickupDateNotifier.dispose();
//     _selectProductBloc.close();
//     _clientCubit.close();
//     super.dispose();
//   }

//   void _onSearchChanged() {
//     if (selectedServiceId == null) return;

//     final query = serviceSearchController.text.trim();
//     final isSales = selectedBookingType == BookingType.sales;

//     if (query.isEmpty) {
//       _selectProductBloc.add(
//         SelectProductEvent.loadProducts(
//           serviceId: selectedServiceId!,
//           pickupDate: pickupDate.format(),
//           returnDate: returnDate.format(),
//           pickupTime: pickupTime,
//           returnTime: returnTime,
//           useAvailableProductsApi: !isSales,
//           isSales: isSales,
//         ),
//       );
//     } else {
//       _selectProductBloc.add(
//         SelectProductEvent.searchProducts(
//           serviceId: selectedServiceId!,
//           query: query,
//           type: 'name',
//           pickupDate: pickupDate.format(),
//           returnDate: returnDate.format(),
//           pickupTime: pickupTime,
//           returnTime: returnTime,
//           useAvailableProductsApi: !isSales,
//           isSales: isSales,
//         ),
//       );
//     }
//   }

//   void _loadProductsForService(int serviceId) {
//     final isSales = selectedBookingType == BookingType.sales;
//     _selectProductBloc.add(
//       SelectProductEvent.loadProducts(
//         serviceId: serviceId,
//         pickupDate: pickupDate.format(),
//         returnDate: returnDate.format(),
//         pickupTime: pickupTime,
//         returnTime: returnTime,
//         useAvailableProductsApi: !isSales,
//         isSales: isSales,
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       color: const Color(0xFFF5F6FA),
//       child: Form(
//         key: _formKey,
//         child: Column(
//           children: [
//             _buildHeader(),
//             Expanded(
//               child: Padding(
//                 padding: const EdgeInsets.all(16),
//                 child: _buildContent(),
//               ),
//             ),
//           // ],
//         ),
//       ),
//     );
//   }

//   Widget _buildHeader() {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.04),
//             blurRadius: 4,
//             offset: const Offset(0, 1),
//           ),
//         ],
//       ),
//       child: Row(
//         children: [
//           InkWell(
//             onTap: () {
//               if (widget.onClose != null) {
//                 widget.onClose!();
//               } else {
//                 Navigator.of(context).pop();
//               }
//             },
//             borderRadius: BorderRadius.circular(4),
//             child: Padding(
//               padding: const EdgeInsets.all(4),
//               child: Row(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   Icon(Icons.arrow_back_ios, size: 14, color: Colors.grey.shade600),
//                   const SizedBox(width: 4),
//                   Text('Back', style: TextStyle(fontSize: 13, color: Colors.grey.shade600)),
//                 ],
//               ),
//             ),
//           ),
//           const SizedBox(width: 16),
//           Text(
//             _getTabTitle(),
//             style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: Colors.black87),
//           ),
//           const SizedBox(width: 16),
//           _buildTabButtons(),
//         ],
//       ),
//     );
//   }

//   String _getTabTitle() {
//     return selectedBookingType == BookingType.booking ? 'New Booking' : 'New Sale';
//   }

//   Widget _buildTabButtons() {
//     return Container(
//       decoration: BoxDecoration(
//         color: const Color(0xFFF0F0F0),
//         borderRadius: BorderRadius.circular(16),
//       ),
//       padding: const EdgeInsets.all(2),
//       child: Row(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           _buildTabButton('Booking', BookingType.booking),
//           _buildTabButton('Sales', BookingType.sales),
//         ],
//       ),
//     );
//   }

//   Widget _buildTabButton(String label, BookingType type) {
//     final isSelected = selectedBookingType == type;
//     return GestureDetector(
//       onTap: () => setState(() => selectedBookingType = type),
//       child: AnimatedContainer(
//         duration: const Duration(milliseconds: 200),
//         padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
//         decoration: BoxDecoration(
//           color: isSelected ? const Color(0xFF6132E4) : Colors.transparent,
//           borderRadius: BorderRadius.circular(14),
//         ),
//         child: Text(
//           label,
//           style: TextStyle(
//             color: isSelected ? Colors.white : Colors.grey.shade700,
//             fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
//             fontSize: 12,
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildContent() {
//     return Row(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         // Left side - Calendar and form fields
//         Expanded(
//           flex: 3,
//           child: Column(
//             children: [
//               // Calendar and dates row
//               SizedBox(
//                 height: 400,
//                 child: Row(
//                   children: [
//                     Expanded(child: _buildCalendarCard()),
//                     const SizedBox(width: 12),
//                     Expanded(child: _buildDatesCard()),
//                   ],
//                 ),
//               ),
//               const SizedBox(height: 12),
//               // Client details
//               SizedBox(
//                 height: 150,
//                 child: _buildClientCard(),
//               ),
//               const SizedBox(height: 12),
//               // Product selection - scrollable
//               Expanded(child: _buildProductSelectionCard()),
//             ],
//           ),
//         ),
//         const SizedBox(width: 12),
//         // Right side - Payment and Summary
//         Expanded(
//           flex: 2,
//           child: Column(
//             children: [
//               Expanded(child: _buildPaymentCard()),
//               const SizedBox(height: 12),
//               _buildSummaryCard(),
//             ],
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildCalendarCard() {
//     return Container(height: 320,
//       padding: const EdgeInsets.all(18),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(10),
//         border: Border.all(color: Colors.grey.shade200),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const Text(
//             'Select Dates',
//             style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.black87),
//           ),
//           const SizedBox(height: 8),
         
//           const SizedBox(height: 10),
//           Expanded(
//             child: CalenderWidget(
//               firstDate: pickupDate,
//               selectedDate: pickupDateNotifier.value,
//               onDateSelected: (selectedDate) {
//                 setState(() {
//                   pickupDateNotifier.value = selectedDate;
//                   pickupDate = selectedDate;
//                   if (returnDate.isBefore(selectedDate)) {
//                     returnDate = selectedDate.add(const Duration(days: 1));
//                     returnDateController.text = returnDate.format();
//                   }
//                 });
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildDatesCard() {
//     return Container(
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(10),
//         border: Border.all(color: Colors.grey.shade200),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const Text(
//             'Booking Details',
//             style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.black87),
//           ),
//           const SizedBox(height: 12),
//           // Return date
//           CustomTextField(
//             validator: (value) {
//               if (value == null || value.isEmpty) return 'Please select return date.';
//               final selectedDate = value.parseToDateTime();
//               if (selectedDate.isBefore(pickupDate.dateOnly)) {
//                 return 'Return date cannot be before pickup date.';
//               }
//               return null;
//             },
//             hintText: 'Select Return Date',
//             controller: returnDateController,
//             prefixIcon: const Icon(Icons.calendar_month_outlined, size: 18),
//             ignorePointers: true,
//           ).onTap(() => _selectReturnDate(context)),
//           const SizedBox(height: 12),
//           // Cooling period (only for booking)
//           if (selectedBookingType == BookingType.booking)
//             CustomTextField(
//               validator: (value) {
//                 if (value == null || value.isEmpty) return 'Please select cooling period date.';
//                 return null;
//               },
//               hintText: 'Cooling Period Date',
//               controller: coolingPeriodDateController,
//               prefixIcon: const Icon(Icons.calendar_today_outlined, size: 18),
//               ignorePointers: true,
//             ).onTap(() => _selectCoolingPeriodDate(context)),
//           if (selectedBookingType == BookingType.booking) const SizedBox(height: 12),
//           // Time selection
//           const Text('Time (Optional)', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: Colors.grey)),
//           const SizedBox(height: 8),
//           Row(
//             children: [
//               Expanded(
//                 child: CustomTextField(
//                    validator: (value) {
//                 if (value == null || value.isEmpty) return 'Please select cooling period date.';
//                 return null;
//               },
//                   controller: pickupTimeController,
//                   hintText: 'Pickup Time',
//                   prefixIcon: const Icon(Icons.access_time, size: 16),
//                   ignorePointers: true,
//                 ).onTap(() => _selectTime(context, isPickup: true)),
//               ),
//               const SizedBox(width: 8),
//               Expanded(
//                 child: CustomTextField(
//                    validator: (value) {
//                 if (value == null || value.isEmpty) return 'Please select cooling period date.';
//                 return null;
//               },
//                   controller: returnTimeController,
//                   hintText: 'Return Time',
//                   prefixIcon: const Icon(Icons.access_time, size: 16),
//                   ignorePointers: true,
//                 ).onTap(() => _selectTime(context, isPickup: false)),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildClientCard() {
//     return Container(
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(10),
//         border: Border.all(color: Colors.grey.shade200),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const Text(
//             'Client Details',
//             style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.black87),
//           ),
//           const SizedBox(height: 12),
//           Row(
//             children: [
//               Expanded(
//                 child: BlocBuilder<ClientCubit, ClientState>(
//                   bloc: _clientCubit,
//                   builder: (context, state) {
//                     return Autocomplete<ClientModel>(
//                       optionsBuilder: (TextEditingValue textEditingValue) async {
//                         if (textEditingValue.text.isEmpty) {
//                           return const Iterable<ClientModel>.empty();
//                         }
//                         await _clientCubit.searchClient(textEditingValue.text);
//                         return state.suggestions;
//                       },
//                       displayStringForOption: (ClientModel option) => option.phone1.toString(),
//                       onSelected: (ClientModel selection) {
//                         _clientCubit.selectClient(selection);
//                         setState(() {
//                           selectedClientId = selection.id;
//                           clientNameController.text = selection.name;
//                           clientPhone1Controller.text = selection.phone1.toString();
//                           clientAddressController.text =  '';
//                         });
//                       },
//                       fieldViewBuilder: (context, controller, focusNode, onFieldSubmitted) {
//                         return CustomTextField(
//                            validator: (value) {
//                 if (value == null || value.isEmpty) return 'Please select cooling period date.';
//                 return null;
//               },
//                           controller: controller,
//                           focusNode: focusNode,
//                           hintText: 'Search Client Phone',
//                           prefixIcon: const Icon(Icons.search, size: 18),
//                         );
//                       },
//                       optionsViewBuilder: (context, onSelected, options) {
//                         return Align(
//                           alignment: Alignment.topLeft,
//                           child: Material(
//                             elevation: 4,
//                             borderRadius: BorderRadius.circular(8),
//                             child: ConstrainedBox(
//                               constraints: const BoxConstraints(maxHeight: 200, maxWidth: 300),
//                               child: ListView.builder(
//                                 padding: const EdgeInsets.all(8),
//                                 itemCount: options.length,
//                                 shrinkWrap: true,
//                                 itemBuilder: (context, index) {
//                                   final option = options.elementAt(index);
//                                   return InkWell(
//                                     onTap: () => onSelected(option),
//                                     child: Container(
//                                       padding: const EdgeInsets.all(8),
//                                       child: Column(
//                                         crossAxisAlignment: CrossAxisAlignment.start,
//                                         children: [
//                                           Text(option.name, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 12)),
//                                           Text(option.phone1.toString(), style: TextStyle(color: Colors.grey.shade600, fontSize: 11)),
//                                         ],
//                                       ),
//                                     ),
//                                   );
//                                 },
//                               ),
//                             ),
//                           ),
//                         );
//                       },
//                     );
//                   },
//                 ),
//               ),
//               const SizedBox(width: 8),
//               Expanded(
//                 child: CustomTextField(
//                    validator: (value) {
//                 if (value == null || value.isEmpty) return 'Please select cooling period date.';
//                 return null;
//               },
//                   controller: clientNameController,
//                   hintText: 'Client Name',
//                   prefixIcon: const Icon(Icons.person_outline, size: 18),
//                 ),
//               ),
//               const SizedBox(width: 8),
//               Expanded(
//                 child: CustomTextField(
//                    validator: (value) {
//                 if (value == null || value.isEmpty) return 'Please select cooling period date.';
//                 return null;
//               },
//                   controller: staffNameController,
//                   hintText: 'Staff Name',
//                   prefixIcon: const Icon(Icons.badge_outlined, size: 18),
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildProductSelectionCard() {
//     return Container(
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(10),
//         border: Border.all(color: Colors.grey.shade200),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(16),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 const Text(
//                   'Select Products/Services',
//                   style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.black87),
//                 ),
//                 const SizedBox(height: 12),
//                 Row(
//                   children: [
//                     Expanded(child: _buildServiceDropdown()),
//                     const SizedBox(width: 12),
//                     Expanded(
//                       flex: 2,
//                       child: SizedBox(
//                         height: 40,
//                         child: TextField(
//                           controller: serviceSearchController,
//                           decoration: InputDecoration(
//                             hintText: 'Search products...',
//                             hintStyle: TextStyle(fontSize: 12, color: Colors.grey.shade400),
//                             prefixIcon: Icon(Icons.search, size: 18, color: Colors.grey.shade400),
//                             border: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(8),
//                               borderSide: BorderSide(color: Colors.grey.shade300),
//                             ),
//                             enabledBorder: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(8),
//                               borderSide: BorderSide(color: Colors.grey.shade300),
//                             ),
//                             focusedBorder: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(8),
//                               borderSide: const BorderSide(color: AppColors.purple),
//                             ),
//                             contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//           const Divider(height: 1),
//           Expanded(child: _buildProductList()),
//         ],
//       ),
//     );
//   }

//   Widget _buildServiceDropdown() {
//     return BlocBuilder<ServiceBloc, ServiceState>(
//       builder: (context, state) {
//         return state.when(
//           loading: () => Container(
//             height: 40,
//             decoration: BoxDecoration(
//               border: Border.all(color: Colors.grey.shade300),
//               borderRadius: BorderRadius.circular(8),
//             ),
//             child: const Center(child: SizedBox(width: 16, height: 16, child: CircularProgressIndicator(strokeWidth: 2))),
//           ),
//           error: (error) => Container(
//             height: 40,
//             decoration: BoxDecoration(
//               border: Border.all(color: Colors.red.shade300),
//               borderRadius: BorderRadius.circular(8),
//             ),
//             child: Center(child: Text('Error loading services', style: TextStyle(color: Colors.red.shade600, fontSize: 11))),
//           ),
//           loaded: (services) {
//             if (selectedServiceId == null && services.isNotEmpty) {
//               WidgetsBinding.instance.addPostFrameCallback((_) {
//                 setState(() => selectedServiceId = services.first.id);
//                 _loadProductsForService(services.first.id);
//               });
//             }
//             return Container(
//               height: 40,
//               padding: const EdgeInsets.symmetric(horizontal: 12),
//               decoration: BoxDecoration(
//                 border: Border.all(color: Colors.grey.shade300),
//                 borderRadius: BorderRadius.circular(8),
//               ),
//               child: DropdownButtonHideUnderline(
//                 child: DropdownButton<int>(
//                   value: selectedServiceId,
//                   isExpanded: true,
//                   icon: Icon(Icons.keyboard_arrow_down, size: 20, color: Colors.grey.shade600),
//                   style: const TextStyle(fontSize: 13, color: Colors.black87),
//                   items: services
//                       .map((service) => DropdownMenuItem(
//                             value: service.id,
//                             child: Text(service.name, style: const TextStyle(fontSize: 13)),
//                           ))
//                       .toList(),
//                   onChanged: (value) {
//                     if (value != null) {
//                       setState(() => selectedServiceId = value);
//                       _loadProductsForService(value);
//                     }
//                   },
//                 ),
//               ),
//             );
//           },
//         );
//       },
//     );
//   }

//   Widget _buildProductList() {
//     return Row(
//       children: [
//         // Available products list
//         Expanded(
//           flex: 3,
//           child: BlocBuilder<SelectProductBloc, SelectProductState>(
//             bloc: _selectProductBloc,
//             builder: (context, state) {
//               return state.when(
//                 loading: () => const Center(child: CircularProgressIndicator(strokeWidth: 2, color: AppColors.purple)),
//                 error: (error) => Center(
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Icon(Icons.error_outline, size: 32, color: Colors.red.shade300),
//                       const SizedBox(height: 8),
//                       Text(error, style: TextStyle(fontSize: 11, color: Colors.grey.shade600), textAlign: TextAlign.center),
//                     ],
//                   ),
//                 ),
//                 loaded: (products, _, __, ___, ____, _____, ______, _______, ________, _________, __________, ___________, ____________, _____________, ______________) {
//                   if (products.isEmpty) {
//                     return Center(
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Icon(Icons.inventory_2_outlined, size: 40, color: Colors.grey.shade300),
//                           const SizedBox(height: 8),
//                           Text('No products available', style: TextStyle(fontSize: 12, color: Colors.grey.shade500)),
//                         ],
//                       ),
//                     );
//                   }
//                   return ListView.separated(
//                     padding: const EdgeInsets.all(8),
//                     itemCount: products.length,
//                     separatorBuilder: (_, __) => const Divider(height: 1),
//                     itemBuilder: (context, index) {
//                       final product = products[index];
//                       return _buildProductItem(product);
//                     },
//                   );
//                 },
//               );
//             },
//           ),
//         ),
//         Container(width: 1, color: Colors.grey.shade200),
//         // Selected products
//         Expanded(
//           flex: 2,
//           child: Column(
//             children: [
//               Container(
//                 padding: const EdgeInsets.all(12),
//                 child: Row(
//                   children: [
//                     const Text('Selected Items', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
//                     const Spacer(),
//                     ValueListenableBuilder<List<ProductSelectedModel>>(
//                       valueListenable: selectedProductsNotifier,
//                       builder: (context, products, _) {
//                         return Container(
//                           padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
//                           decoration: BoxDecoration(
//                             color: AppColors.purple.withOpacity(0.1),
//                             borderRadius: BorderRadius.circular(10),
//                           ),
//                           child: Text(
//                             '${products.length} items',
//                             style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: AppColors.purple),
//                           ),
//                         );
//                       },
//                     ),
//                   ],
//                 ),
//               ),
//               const Divider(height: 1),
//               Expanded(child: _buildSelectedProductsList()),
//             ],
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildProductItem(dynamic product) {
//     final name = product.name ?? 'Unknown';
//     final image = product.image;
//     final variants = product.variants ?? [];

//     return InkWell(
//       onTap: () => _showVariantDialog(product),
//       child: Padding(
//         padding: const EdgeInsets.symmetric(vertical: 8),
//         child: Row(
//           children: [
//             Container(
//               width: 50,
//               height: 50,
//               decoration: BoxDecoration(
//                 color: Colors.grey.shade100,
//                 borderRadius: BorderRadius.circular(6),
//               ),
//               child: image != null
//                   ? ClipRRect(
//                       borderRadius: BorderRadius.circular(6),
//                       child: Image.network(image, fit: BoxFit.cover, errorBuilder: (_, __, ___) => Icon(Icons.image, size: 24, color: Colors.grey.shade400)),
//                     )
//                   : Icon(Icons.image, size: 24, color: Colors.grey.shade400),
//             ),
//             const SizedBox(width: 12),
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(name, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500)),
//                   const SizedBox(height: 4),
//                   Text('${variants.length} variants available', style: TextStyle(fontSize: 11, color: Colors.grey.shade600)),
//                 ],
//               ),
//             ),
//             Container(
//               padding: const EdgeInsets.all(6),
//               decoration: BoxDecoration(
//                 color: AppColors.purple,
//                 borderRadius: BorderRadius.circular(6),
//               ),
//               child: const Icon(Icons.add, size: 16, color: Colors.white),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   void _showVariantDialog(dynamic product) {
//     final variants = product.variants ?? [];
//     if (variants.isEmpty) {
//       context.showSnackBar('No variants available', isError: true);
//       return;
//     }

//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: Text('Select Variant - ${product.name}', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
//         content: SizedBox(
//           width: 400,
//           child: ListView.separated(
//             shrinkWrap: true,
//             itemCount: variants.length,
//             separatorBuilder: (_, __) => const Divider(height: 1),
//             itemBuilder: (context, index) {
//               final variant = variants[index];
//               final attribute = variant.attribute ?? 'Variant ${index + 1}';
//               final price = variant.price ?? 0;

//               return ListTile(
//                 contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//                 title: Text(attribute, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500)),
//                 subtitle: Text(price.toCurrency(), style: const TextStyle(fontSize: 12, color: AppColors.purple, fontWeight: FontWeight.w600)),
//                 trailing: IconButton(
//                   onPressed: () {
//                     _addProductVariant(product, variant);
//                     Navigator.pop(context);
//                   },
//                   icon: Container(
//                     padding: const EdgeInsets.all(4),
//                     decoration: BoxDecoration(
//                       color: AppColors.purple,
//                       borderRadius: BorderRadius.circular(4),
//                     ),
//                     child: const Icon(Icons.add, size: 16, color: Colors.white),
//                   ),
//                 ),
//               );
//             },
//           ),
//         ),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context),
//             child: const Text('Cancel'),
//           ),
//         ],
//       ),
//     );
//   }

//   void _addProductVariant(dynamic product, dynamic variant) {
//     final products = List<ProductSelectedModel>.from(selectedProductsNotifier.value);

//     // Create ProductInfoModel from variant
//     final productInfo = ProductInfoModel(
//       id: product.id,
//       productId: product.id,
//       variantId: variant.id,
//       name: product.name ?? 'Unknown',
//       image: product.image,
//       variantAttribute: variant.attribute,
//       quantity: 1,
//       amount: variant.price ?? 0,
//     );

//     // Check if already exists
//     final existingIndex = products.indexWhere((p) => p.variant.variantId == variant.id);

//     if (existingIndex != -1) {
//       final existing = products[existingIndex];
//       products[existingIndex] = existing.copyWith(quantity: existing.quantity + 1);
//     } else {
//       final isSales = selectedBookingType == BookingType.sales;
//       final price = variant.price ?? 0;

//       products.add(ProductSelectedModel(
//         variant: productInfo,
//         quantity: 1,
//         amount: price,
//       ));
//     }

//     selectedProductsNotifier.value = products;
//     context.showSnackBar('Added ${variant.attribute ?? "item"} to selection');
//   }

//   Widget _buildSelectedProductsList() {
//     return ValueListenableBuilder<List<ProductSelectedModel>>(
//       valueListenable: selectedProductsNotifier,
//       builder: (context, products, _) {
//         if (products.isEmpty) {
//           return Center(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Icon(Icons.shopping_cart_outlined, size: 32, color: Colors.grey.shade300),
//                 const SizedBox(height: 8),
//                 Text('No items selected', style: TextStyle(fontSize: 11, color: Colors.grey.shade500)),
//               ],
//             ),
//           );
//         }
//         return ListView.separated(
//           padding: const EdgeInsets.all(8),
//           itemCount: products.length,
//           separatorBuilder: (_, __) => const Divider(height: 1),
//           itemBuilder: (context, index) => _buildSelectedProductRow(products[index]),
//         );
//       },
//     );
//   }

//   Widget _buildSelectedProductRow(ProductSelectedModel product) {
//     final total = product.amount * product.quantity;
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 6),
//       child: Row(
//         children: [
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(product.variant.name, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500), maxLines: 1, overflow: TextOverflow.ellipsis),
//                 if (product.variant.variantAttribute != null)
//                   Text(product.variant.variantAttribute!, style: TextStyle(fontSize: 10, color: Colors.grey.shade600)),
//               ],
//             ),
//           ),
//           const SizedBox(width: 8),
//           Row(
//             children: [
//               InkWell(
//                 onTap: () => _decrementQuantity(product),
//                 child: Container(
//                   padding: const EdgeInsets.all(3),
//                   decoration: BoxDecoration(
//                     color: Colors.grey.shade200,
//                     borderRadius: BorderRadius.circular(3),
//                   ),
//                   child: const Icon(Icons.remove, size: 12),
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 8),
//                 child: Text('${product.quantity}', style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500)),
//               ),
//               InkWell(
//                 onTap: () => _incrementQuantity(product),
//                 child: Container(
//                   padding: const EdgeInsets.all(3),
//                   decoration: BoxDecoration(
//                     color: AppColors.purple.withOpacity(0.1),
//                     borderRadius: BorderRadius.circular(3),
//                   ),
//                   child: const Icon(Icons.add, size: 12, color: AppColors.purple),
//                 ),
//               ),
//             ],
//           ),
//           const SizedBox(width: 8),
//           SizedBox(
//             width: 60,
//             child: Text(total.toCurrency(), textAlign: TextAlign.right, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
//           ),
//           IconButton(
//             onPressed: () => _removeProduct(product),
//             icon: Icon(Icons.close, size: 14, color: Colors.grey.shade500),
//             padding: EdgeInsets.zero,
//             constraints: const BoxConstraints(),
//           ),
//         ],
//       ),
//     );
//   }

//   void _incrementQuantity(ProductSelectedModel product) {
//     final products = List<ProductSelectedModel>.from(selectedProductsNotifier.value);
//     final index = products.indexWhere((p) => p.variant.variantId == product.variant.variantId);
//     if (index != -1) {
//       products[index] = product.copyWith(quantity: product.quantity + 1);
//       selectedProductsNotifier.value = products;
//     }
//   }

//   void _decrementQuantity(ProductSelectedModel product) {
//     if (product.quantity <= 1) {
//       _removeProduct(product);
//       return;
//     }
//     final products = List<ProductSelectedModel>.from(selectedProductsNotifier.value);
//     final index = products.indexWhere((p) => p.variant.variantId == product.variant.variantId);
//     if (index != -1) {
//       products[index] = product.copyWith(quantity: product.quantity - 1);
//       selectedProductsNotifier.value = products;
//     }
//   }

//   void _removeProduct(ProductSelectedModel product) {
//     final products = List<ProductSelectedModel>.from(selectedProductsNotifier.value);
//     products.removeWhere((p) => p.variant.variantId == product.variant.variantId);
//     selectedProductsNotifier.value = products;
//   }

//   Widget _buildPaymentCard() {
//     return Container(
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(10),
//         border: Border.all(color: Colors.grey.shade200),
//       ),
//       child: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const Text('Payment Details', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.black87)),
//             const SizedBox(height: 12),
//             _buildCompactAmountField(controller: advanceAmountController, label: 'Advance'),
//             const SizedBox(height: 8),
//             if (selectedBookingType == BookingType.booking) ...[
//               _buildCompactAmountField(controller: securityAmountController, label: 'Security'),
//               const SizedBox(height: 8),
//             ],
//             _buildCompactAmountField(controller: discountAmountController, label: 'Discount'),
//             const SizedBox(height: 12),
//             _buildAdditionalChargesSection(),
//             const SizedBox(height: 12),
//             _buildPaymentMethodSection(),
//             const SizedBox(height: 12),
//             if (selectedBookingType == BookingType.booking) _buildDeliveryStatusSection(),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildCompactAmountField({required TextEditingController controller, required String label}) {
//     return Row(
//       children: [
//         SizedBox(width: 70, child: Text(label, style: TextStyle(fontSize: 11, color: Colors.grey.shade700))),
//         Expanded(
//           child: Container(
//             height: 30,
//             decoration: BoxDecoration(
//               border: Border.all(color: Colors.grey.shade300, width: 1),
//               borderRadius: BorderRadius.circular(6),
//             ),
//             child: TextField(
//               controller: controller,
//               keyboardType: TextInputType.number,
//               style: const TextStyle(fontSize: 12),
//               decoration: InputDecoration(
//                 prefixText: '₹ ',
//                 prefixStyle: TextStyle(fontSize: 12, color: Colors.grey.shade600),
//                 border: InputBorder.none,
//                 contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildAdditionalChargesSection() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Text('Additional Charges', style: TextStyle(fontSize: 11, color: Colors.grey.shade700)),
//             InkWell(
//               onTap: _addAdditionalCharge,
//               child: Container(
//                 padding: const EdgeInsets.all(3),
//                 decoration: BoxDecoration(
//                   color: AppColors.purple.withOpacity(0.1),
//                   borderRadius: BorderRadius.circular(4),
//                 ),
//                 child: const Icon(Icons.add, size: 14, color: AppColors.purple),
//               ),
//             ),
//           ],
//         ),
//         const SizedBox(height: 4),
//         ValueListenableBuilder<List<AdditionalChargesModel>>(
//           valueListenable: additionalChargesNotifier,
//           builder: (context, charges, _) {
//             if (charges.isEmpty) {
//               return Container(
//                 padding: const EdgeInsets.all(8),
//                 decoration: BoxDecoration(
//                   color: Colors.grey.shade50,
//                   borderRadius: BorderRadius.circular(6),
//                   border: Border.all(color: Colors.grey.shade200),
//                 ),
//                 child: Center(child: Text('No additional charges', style: TextStyle(fontSize: 10, color: Colors.grey.shade500))),
//               );
//             }
//             return Column(
//               children: charges.map((charge) {
//                 return Container(
//                   margin: const EdgeInsets.only(bottom: 4),
//                   padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
//                   decoration: BoxDecoration(
//                     color: Colors.grey.shade50,
//                     borderRadius: BorderRadius.circular(6),
//                     border: Border.all(color: Colors.grey.shade200),
//                   ),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text(charge.name ?? 'Charge', style: const TextStyle(fontSize: 11)),
//                       Row(
//                         children: [
//                           Text('₹${charge.amount ?? 0}', style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600)),
//                           const SizedBox(width: 4),
//                           InkWell(
//                             onTap: () => _removeCharge(charge),
//                             child: Icon(Icons.close, size: 12, color: Colors.grey.shade500),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 );
//               }).toList(),
//             );
//           },
//         ),
//       ],
//     );
//   }

//   Widget _buildPaymentMethodSection() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text('Payment Method', style: TextStyle(fontSize: 11, color: Colors.grey.shade700)),
//         const SizedBox(height: 4),
//         Row(
//           children: [
//             Expanded(child: _buildPaymentMethodOption(label: 'UPI', value: PaymentMethod.gPay, icon: Icons.account_balance_wallet_outlined)),
//             const SizedBox(width: 8),
//             Expanded(child: _buildPaymentMethodOption(label: 'Cash', value: PaymentMethod.cash, icon: Icons.money_outlined)),
//           ],
//         ),
//       ],
//     );
//   }

//   Widget _buildPaymentMethodOption({required String label, required PaymentMethod value, required IconData icon}) {
//     final isSelected = paymentMethod == value;
//     return InkWell(
//       onTap: () => setState(() => paymentMethod = value),
//       borderRadius: BorderRadius.circular(6),
//       child: Container(
//         padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
//         decoration: BoxDecoration(
//           color: isSelected ? AppColors.purple.withOpacity(0.1) : Colors.grey.shade50,
//           borderRadius: BorderRadius.circular(6),
//           border: Border.all(
//             color: isSelected ? AppColors.purple : Colors.grey.shade300,
//             width: isSelected ? 1.5 : 1,
//           ),
//         ),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Icon(icon, size: 14, color: isSelected ? AppColors.purple : Colors.grey.shade600),
//             const SizedBox(width: 4),
//             Text(
//               label,
//               style: TextStyle(
//                 fontSize: 11,
//                 fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
//                 color: isSelected ? AppColors.purple : Colors.grey.shade700,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildDeliveryStatusSection() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text('Delivery Status', style: TextStyle(fontSize: 11, color: Colors.grey.shade700)),
//         const SizedBox(height: 4),
//         Container(
//           height: 32,
//           padding: const EdgeInsets.symmetric(horizontal: 8),
//           decoration: BoxDecoration(
//             border: Border.all(color: Colors.grey.shade300, width: 1),
//             borderRadius: BorderRadius.circular(6),
//           ),
//           child: DropdownButtonHideUnderline(
//             child: DropdownButton<DeliveryStatus>(
//               value: deliveryStatus,
//               isExpanded: true,
//               icon: Icon(Icons.keyboard_arrow_down, size: 18, color: Colors.grey.shade600),
//               style: const TextStyle(fontSize: 12, color: Colors.black87),
//               items: DeliveryStatus.values
//                   .map((status) => DropdownMenuItem(
//                         value: status,
//                         child: Text(status.name, style: const TextStyle(fontSize: 12)),
//                       ))
//                   .toList(),
//               onChanged: (value) {
//                 if (value != null) setState(() => deliveryStatus = value);
//               },
//             ),
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildSummaryCard() {
//     return Container(
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(10),
//         border: Border.all(color: Colors.grey.shade200),
//       ),
//       child: Column(
//         children: [
//           ListenableBuilder(
//             listenable: Listenable.merge([
//               selectedProductsNotifier,
//               additionalChargesNotifier,
//               advanceAmountController,
//               discountAmountController,
//             ]),
//             builder: (context, _) {
//               final products = selectedProductsNotifier.value;
//               final additionalCharges = additionalChargesNotifier.value;
//               final advanceAmount = advanceAmountController.text.trim().toIntOrNull() ?? 0;
//               final discountAmount = discountAmountController.text.trim().toIntOrNull() ?? 0;

//               final productTotal = products.fold<int>(0, (sum, product) => sum + (product.amount * product.quantity));
//               final additionalTotal = additionalCharges.fold<int>(0, (sum, charge) => sum + (charge.amount ?? 0));
//               final totalPayable = productTotal + additionalTotal - discountAmount;
//               final remainingAmount = totalPayable - advanceAmount;

//               return Column(
//                 children: [
//                   _buildSummaryRow('Subtotal', productTotal),
//                   if (additionalTotal > 0) _buildSummaryRow('+ Additional', additionalTotal),
//                   if (discountAmount > 0) _buildSummaryRow('- Discount', discountAmount, isNegative: true),
//                   const Divider(height: 12),
//                   _buildSummaryRow('Paid', advanceAmount, valueColor: AppColors.green),
//                   _buildSummaryRow('Balance', remainingAmount > 0 ? remainingAmount : 0, valueColor: AppColors.purple, isBold: true),
//                 ],
//               );
//             },
//           ),
//           const SizedBox(height: 12),
//           SizedBox(
//             width: double.infinity,
//             height: 40,
//             child: ElevatedButton(
//               onPressed: _handleConfirmBooking,
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: AppColors.purple,
//                 foregroundColor: Colors.white,
//                 shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
//                 elevation: 0,
//               ),
//               child: const Text('Confirm Booking', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildSummaryRow(String label, int amount, {Color? valueColor, bool isBold = false, bool isNegative = false}) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 2),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Text(
//             label,
//             style: TextStyle(
//               fontSize: 11,
//               fontWeight: isBold ? FontWeight.w600 : FontWeight.w400,
//               color: Colors.grey.shade700,
//             ),
//           ),
//           Text(
//             '${isNegative ? '-' : ''}${amount.abs().toCurrency()}',
//             style: TextStyle(
//               fontSize: isBold ? 14 : 12,
//               fontWeight: isBold ? FontWeight.w700 : FontWeight.w500,
//               color: valueColor ?? Colors.black87,
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   void _selectReturnDate(BuildContext context) async {
//     final picked = await showDatePicker(
//       context: context,
//       initialDate: returnDate,
//       firstDate: pickupDate,
//       lastDate: DateTime.now().add(const Duration(days: 365 * 2)),
//     );
//     if (picked != null) {
//       setState(() {
//         returnDate = picked;
//         returnDateController.text = picked.format();
//       });
//     }
//   }

//   void _selectCoolingPeriodDate(BuildContext context) async {
//     final picked = await showDatePicker(
//       context: context,
//       initialDate: returnDate.add(Duration(days: coolingPeriodDuration)),
//       firstDate: returnDate,
//       lastDate: DateTime.now().add(const Duration(days: 365 * 2)),
//     );
//     if (picked != null) {
//       setState(() {
//         coolingPeriodDate = picked;
//         coolingPeriodDateController.text = picked.format();
//       });
//     }
//   }

//   void _selectTime(BuildContext context, {required bool isPickup}) async {
//     final initialTime = isPickup ? (pickupTime ?? TimeOfDay.now()) : (returnTime ?? TimeOfDay.now());
//     final picked = await showTimePicker(context: context, initialTime: initialTime);
//     if (picked != null) {
//       setState(() {
//         if (isPickup) {
//           pickupTime = picked;
//           pickupTimeController.text = picked.formatToTime();
//         } else {
//           returnTime = picked;
//           returnTimeController.text = picked.formatToTime();
//         }
//       });
//     }
//   }

//   void _addAdditionalCharge() async {
//     final nameController = TextEditingController();
//     final amountController = TextEditingController();

//     final result = await showDialog<AdditionalChargesModel>(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: const Text('Add Charge', style: TextStyle(fontSize: 16)),
//         content: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             TextField(
//               controller: nameController,
//               decoration: const InputDecoration(labelText: 'Name', hintText: 'e.g., Delivery'),
//             ),
//             const SizedBox(height: 12),
//             TextField(
//               controller: amountController,
//               keyboardType: TextInputType.number,
//               decoration: const InputDecoration(labelText: 'Amount', prefixText: '₹ '),
//             ),
//           ],
//         ),
//         actions: [
//           TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
//           ElevatedButton(
//             onPressed: () {
//               final name = nameController.text.trim();
//               final amount = int.tryParse(amountController.text);
//               if (name.isNotEmpty && amount != null && amount > 0) {
//                 Navigator.pop(context, AdditionalChargesModel(name: name, amount: amount));
//               }
//             },
//             style: ElevatedButton.styleFrom(backgroundColor: AppColors.purple),
//             child: const Text('Add'),
//           ),
//         ],
//       ),
//     );

//     if (result != null) {
//       final charges = List<AdditionalChargesModel>.from(additionalChargesNotifier.value);
//       charges.add(result);
//       additionalChargesNotifier.value = charges;
//     }
//   }

//   void _removeCharge(AdditionalChargesModel charge) {
//     final charges = List<AdditionalChargesModel>.from(additionalChargesNotifier.value);
//     charges.remove(charge);
//     additionalChargesNotifier.value = charges;
//   }

//   void _handleConfirmBooking() {
//     if (!_formKey.currentState!.validate()) {
//       context.showSnackBar('Please fill all required fields', isError: true);
//       return;
//     }

//     final products = selectedProductsNotifier.value;
//     if (products.isEmpty) {
//       context.showSnackBar('Please select at least one item', isError: true);
//       return;
//     }

//     final request = _buildBookingRequest();
//     log('Booking Request: ${request.toJson()}');

//     context.showSnackBar('Booking created successfully!');
//   }

//   RequestBookingModel _buildBookingRequest() {
//     final products = selectedProductsNotifier.value;
//     final additionalCharges = additionalChargesNotifier.value;

//     return RequestBookingModel(
//       clientId: selectedClientId,
//       staffId: selectedStaffId,
//       client: null,
//       address: clientAddressController.text.trim(),
//       pickupDate: pickupDate.format(),
//       returnDate: returnDate.format(),
//       coolingPeriodDate: coolingPeriodDate?.format(),
//       advanceAmount: advanceAmountController.text.trim().toIntOrNull(),
//       securityAmount: securityAmountController.text.trim().toIntOrNull(),
//       discountAmount: discountAmountController.text.trim().toIntOrNull(),
//       paymentMethod: paymentMethod,
//       deliveryStatus: deliveryStatus,
//       products: products,
//       additionalCharges: additionalCharges.isNotEmpty ? additionalCharges : null,
//       pickupTime: pickupTime,
//       returnTime: returnTime,
//     );
//   }
// }

// extension TimeOfDayExtension on TimeOfDay {
//   String formatTime12Hour() {
//     final hour = hourOfPeriod;
//     final minute = this.minute.toString().padLeft(2, '0');
//     final period = this.period == DayPeriod.am ? 'AM' : 'PM';
//     return '$hour:$minute $period';
//   }
// }
