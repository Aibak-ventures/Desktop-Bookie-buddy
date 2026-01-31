import 'package:bookie_buddy_web/core/app_input_validators.dart';
import 'package:bookie_buddy_web/core/extensions/date_time_extensions.dart';
import 'package:bookie_buddy_web/core/extensions/number_extensions.dart';
import 'package:bookie_buddy_web/core/theme/app_colors.dart';
import 'package:bookie_buddy_web/core/ui/widgets/custom_textfield.dart';
import 'package:bookie_buddy_web/core/ui/widgets/staff_search_name_field.dart';
import 'package:bookie_buddy_web/core/view_model/cubit_client/client_cubit.dart';
import 'package:bookie_buddy_web/core/view_model/cubit_staff_search/staff_search_cubit.dart';
import 'package:bookie_buddy_web/features/add_booking/models/client_model/client_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:table_calendar/table_calendar.dart';

class BookingCalendarWidget extends StatefulWidget {
  final DateTime pickupDate;
  final DateTime returnDate;
  final DateTime? coolingPeriodDate;
  final TimeOfDay? pickupTime;
  final TimeOfDay? returnTime;
  final TimeOfDay? coolingPeriodTime;
  final ValueChanged<DateTime> onPickupDateChanged;
  final ValueChanged<DateTime> onReturnDateChanged;
  final ValueChanged<DateTime?> onCoolingPeriodDateChanged;
  final ValueChanged<TimeOfDay?> onPickupTimeChanged;
  final ValueChanged<TimeOfDay?> onReturnTimeChanged;
  final ValueChanged<TimeOfDay?> onCoolingPeriodTimeChanged;
  final bool isSearchClientEnabled;
  final ValueChanged<bool> onSearchClientToggle;
  final TextEditingController staffNameController;
  final TextEditingController clientNameController;
  final TextEditingController clientPhone1Controller;
  final TextEditingController clientPhone2Controller;
  final TextEditingController clientAddressController;
  final TextEditingController? descriptionController;

  final ValueChanged<int?> onStaffSelected;
  final ValueChanged<int?> onClientSelected;

  // Sales mode flag
  final bool isSalesMode;

  const BookingCalendarWidget({
    super.key,
    required this.pickupDate,
    required this.returnDate,
    this.coolingPeriodDate,
    this.pickupTime,
    this.returnTime,
    this.coolingPeriodTime,
    required this.onPickupDateChanged,
    required this.onReturnDateChanged,
    required this.onCoolingPeriodDateChanged,
    required this.onPickupTimeChanged,
    required this.onReturnTimeChanged,
    required this.staffNameController,
    required this.clientNameController,
    required this.clientPhone1Controller,
    required this.clientPhone2Controller,
    required this.clientAddressController,
    this.descriptionController,
    required this.isSearchClientEnabled,
    required this.onSearchClientToggle,
    required this.onStaffSelected,
    required this.onClientSelected,
    required this.onCoolingPeriodTimeChanged,
    this.isSalesMode = false,
  });

  @override
  State<BookingCalendarWidget> createState() => _BookingCalendarWidgetState();
}

class _BookingCalendarWidgetState extends State<BookingCalendarWidget> {
  late DateTime focusedDay;
  late DateTime selectedDay;
  bool isSelectingPickup = true; // true = pickup, false = return

  // Focus nodes for explicit traversal
  final _nameFocus = FocusNode();
  final _phone1Focus = FocusNode();
  final _phone2Focus = FocusNode();
  final _addressFocus = FocusNode();

  @override
  void dispose() {
    _nameFocus.dispose();
    _phone1Focus.dispose();
    _phone2Focus.dispose();
    _addressFocus.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    // Ensure focusedDay is not before now() (firstDay in calendar)
    final now = DateTime.now();
    focusedDay = widget.pickupDate.isBefore(now) ? now : widget.pickupDate;
    selectedDay = widget.pickupDate;
    context.read<StaffSearchCubit>()
      ..clearSelectedStaff()
      ..getAllStaffs();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Select dates',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
          // const SizedBox(height: 16),
          // Calendar
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 2,
                  child: Column(
                    children: [
                      _buildCalendar(),
                      // _buildCalendar(),
                      _buildClientDetailsCard(),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Show different fields based on mode
                      if (!widget.isSalesMode) ...[
                        // Booking mode: show pickup, return, and cooling period
                        _buildDateTimeRow(
                          label: 'Pickup date',
                          date: widget.pickupDate,
                          time: widget.pickupTime,
                          onDateTap: () => _selectDate(true),
                          onTimeTap: () => _selectTime(true),
                          iconData: Icons.calendar_today_outlined,
                        ),
                        const SizedBox(height: 12),
                        _buildDateTimeRow(
                          label: 'Return date',
                          date: widget.returnDate,
                          time: widget.returnTime,
                          onDateTap: () => _selectDate(false),
                          onTimeTap: () => _selectTime(false),
                          iconData: Icons.calendar_today_outlined,
                        ),
                        const SizedBox(height: 12),
                        _buildCoolingPeriodRow(),
                        const SizedBox(height: 7),
                      ],
                      if (widget.isSalesMode) ...[
                        // Sales mode: show only booked date (no time)
                        _buildBookedDateField(),
                        const SizedBox(height: 7),
                      ],

                      _compactField(widget.clientAddressController, 'Place',
                          Icons.location_on_outlined,
                          type: TextInputType.text,
                          focusNode: _addressFocus,
                          validator: (v) =>
                              AppInputValidators.address(v, isRequired: false),
                          textInputAction: TextInputAction.done),
                      // const SizedBox(height: 6),
                      _buildStaffDetailsCard(),

                      // Description field for both booking and sales mode
                      if (widget.descriptionController != null) ...[
                        // const SizedBox(height: ),
                        _buildDescriptionField(),
                      ],
                    ],
                  ),
                ),
              ],
            ),
          ),
          // const SizedBox(height: 20),
          // Pickup date and time
        ],
      ),
    );
  }

  _buildClientDetailsCard() {
    return _card(
      title: 'Client details',
      trailing: Row(
        children: [
          Text('Search client',
              style: TextStyle(fontSize: 11, color: Colors.grey.shade600)),
          const SizedBox(width: 6),
          Transform.scale(
            scale: .6,
            child: Switch(
              value: widget.isSearchClientEnabled,
              onChanged: widget.onSearchClientToggle,
              activeColor: AppColors.purple,
            ),
          ),
        ],
      ),
      child: widget.isSearchClientEnabled
          ? _buildClientSearchWithFields()
          : _buildClientManualFields(),
    );
  }

  // Combined search field with locked manual fields below
  Widget _buildClientSearchWithFields() {
    return Column(
      children: [
        _buildClientSearchField(),
        const SizedBox(height: 12),
        // Manual fields - disabled during search
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 400),
          child: Column(
            children: [
              // Client name - hidden in sales mode
              if (!widget.isSalesMode) ...[
                // _compactField(
                //   widget.clientNameController,
                //   'Name',
                //   Icons.person_outline,
                //   type: TextInputType.text,
                //   validator: AppInputValidators.name,
                //   enabled: false, // Locked during search
                // ),
                // const SizedBox(height: 8),
              ],
              _compactField(
                widget.clientPhone1Controller,
                'Phone',
                Icons.phone_outlined,
                type: TextInputType.phone,
                validator: AppInputValidators.phoneNumber,
                enabled: false, // Locked during search
              ),
              // Phone 2 - hidden in sales mode
              if (!widget.isSalesMode) ...[
                // const SizedBox(height: 8),
                _compactField(
                  widget.clientPhone2Controller,
                  'Phone 2',
                  Icons.phone_outlined,
                  type: TextInputType.phone,
                  validator: (value) =>
                      AppInputValidators.phoneNumber(value, isRequired: false),
                  enabled: false, // Locked during search
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildClientSearchField() {
    return BlocBuilder<ClientCubit, ClientState>(
      builder: (context, state) {
        return TypeAheadField<ClientModel>(
          controller: widget.clientNameController,
          debounceDuration: const Duration(milliseconds: 200),
          hideOnEmpty: false,
          hideWithKeyboard: false,
          hideOnUnfocus: true,
          hideOnSelect: true,
          builder: (context, controller, focusNode) => TextFormField(
            focusNode:
                focusNode, // TypeAhead uses its own focus node for the text field
            controller: controller,
            textInputAction: TextInputAction.next,
            onFieldSubmitted: (_) => _phone1Focus.requestFocus(),
            validator: AppInputValidators.name,
            style: const TextStyle(fontSize: 13),
            decoration: InputDecoration(
              hintText: 'Search client',
              hintStyle: const TextStyle(
                  fontSize: 13, color: AppColors.textQuaternary, fontFamily: 'Inter'),
              prefixIcon: const Icon(Icons.search, size: 16),
              suffixIcon: ValueListenableBuilder(
                valueListenable: controller,
                builder: (_, value, __) => value.text.isEmpty
                    ? const SizedBox.shrink()
                    : IconButton(
                        icon: const Icon(Icons.clear, size: 14),
                        onPressed: () {
                          controller.clear();
                          context.read<ClientCubit>().clearSelected();
                        },
                      ),
              ),
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 14),
              isDense: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide:
                    const BorderSide(color: AppColors.grey300, width: 1.0),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide:
                    const BorderSide(color: AppColors.grey300, width: 1.0),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide:
                    const BorderSide(color: AppColors.purple, width: 1.5),
              ),
            ),
          ),
          suggestionsCallback: (query) async {
            if (query.isEmpty) return [];
            return await context.read<ClientCubit>().searchClient(query);
          },
          itemBuilder: (context, client) => ListTile(
            dense: true,
            visualDensity: const VisualDensity(vertical: -3),
            title: Text(client.name, style: const TextStyle(fontSize: 13)),
            subtitle: Text(
              client.phone1.toString(),
              style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
            ),
          ),
          onSelected: (client) {
            widget.clientNameController.text = client.name;
            widget.clientPhone1Controller.text = client.phone1.toString();
            widget.clientPhone2Controller.text =
                client.phone2?.toString() ?? '';
            // Auto-fill address if available
            // if (client.address != null && client.a!.isNotEmpty) {
            //   widget.clientAddressController.text = client.address!;
            // }
            widget.onClientSelected(client.id);
            context.read<ClientCubit>().selectClient(client);
          },
          decorationBuilder: (context, child) => DecoratedBox(
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: 8.radiusBorder,
              border: BoxBorder.all(color: AppColors.grey300),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 4,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: child,
          ),
          emptyBuilder: (_) => const SizedBox(
            height: 70,
            child: Center(
              child: Text('No clients found', style: TextStyle(fontSize: 11)),
            ),
          ),
          errorBuilder: (_, error) => SizedBox(
            height: 70,
            child: Center(
              child: Text(
                error.toString(),
                style: const TextStyle(fontSize: 11, color: Colors.red),
              ),
            ),
          ),
          loadingBuilder: (_) => const Padding(
            padding: EdgeInsets.all(8),
            child: Center(
              child: SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(strokeWidth: 2),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildClientManualFields() {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 400),
      child: Column(
        children: [
          // Client name - hidden in sales mode
          if (!widget.isSalesMode) ...[
            _compactField(
              widget.clientNameController,
              'Name',
              Icons.person_outline,
              type: TextInputType.text,
              validator: AppInputValidators.name,
              focusNode: _nameFocus,
              onFieldSubmitted: (_) => _phone1Focus.requestFocus(),
              textInputAction: TextInputAction.next,
            ),
            const SizedBox(height: 8),
          ],
          _compactField(
            widget.clientPhone1Controller,
            'Phone',
            Icons.phone_outlined,
            type: TextInputType.phone,
            validator: AppInputValidators.phoneNumber,
            focusNode: _phone1Focus,
            onFieldSubmitted: (_) => !widget.isSalesMode
                ? _phone2Focus.requestFocus()
                : _addressFocus.requestFocus(),
            textInputAction: TextInputAction.next,
          ),
          // Phone 2 - hidden in sales mode
          if (!widget.isSalesMode) ...[
            const SizedBox(height: 8),
            _compactField(
              widget.clientPhone2Controller,
              'Phone 2',
              Icons.phone_outlined,
              type: TextInputType.phone,
              validator: (value) =>
                  AppInputValidators.phoneNumber(value, isRequired: false),
              focusNode: _phone2Focus,
              onFieldSubmitted: (_) => _addressFocus.requestFocus(),
              textInputAction: TextInputAction.next,
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildStaffDetailsCard() {
    return _card(
      // title: '',
      child: BlocListener<StaffSearchCubit, StaffSearchState>(
        listener: (context, state) =>
            widget.onStaffSelected(state.selectedStaff?.id),
        child: StaffSearchNameField(
          nameController: widget.staffNameController,
        ),
      ),
    );
  }

  Widget _buildDescriptionField() {
    return _card(
      title: 'Description',
      child: Container(
        height: 80,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey.shade300, width: 1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: TextField(
          controller: widget.descriptionController,
          maxLines: 4,
          style: const TextStyle(
            fontSize: 13,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w500,
          ),
          decoration: const InputDecoration(
            border: InputBorder.none,
            isCollapsed: true,
            hintText: 'Enter notes here...',
            hintStyle: TextStyle(
                fontSize: 13, color: AppColors.grey400, fontFamily: 'Inter'),
          ),
        ),
      ),
    );
  }

  Widget _compactField(
    TextEditingController c,
    String hint,
    IconData icon, {
    TextInputType type = TextInputType.text,
    String? Function(String?)? validator,
    bool enabled = true,
    TextInputAction? textInputAction,
    FocusNode? focusNode,
    ValueChanged<String>? onFieldSubmitted,
  }) {
    return TextFormField(
      controller: c,
      focusNode: focusNode,
      keyboardType: type,
      textInputAction: textInputAction,
      onFieldSubmitted:
          onFieldSubmitted ?? (_) => FocusScope.of(context).nextFocus(),
      validator: validator,
      enabled: enabled,
      style: TextStyle(
        fontSize: 13,
        fontFamily: 'Inter',
        fontWeight: FontWeight.w500,
        color: enabled ? Colors.black : Colors.grey.shade500,
      ),
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.grey.shade300, width: 1),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.grey.shade300, width: 1),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.grey200, width: 1),
        ),
        filled: !enabled,
        fillColor: enabled ? null : Colors.grey.shade50,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.purple, width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Colors.red, width: 1),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Colors.red, width: 1.5),
        ),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 10, vertical: 14),
        prefixIcon: Icon(icon, size: 16, color: Colors.grey.shade600),
        hintText: hint,
        hintStyle: const TextStyle(
          fontSize: 13,
          color: AppColors.textQuaternary,
          fontFamily: 'Inter',
          fontWeight: FontWeight.w400,
        ),
        isDense: true,
        errorStyle: const TextStyle(fontSize: 0, height: 0),
        errorMaxLines: 1,
      ),
    );
  }

  Widget _card({String? title, Widget? trailing, required Widget child}) {
    return Container(
      padding: const EdgeInsets.all(0),
      decoration: BoxDecoration(
        color: Colors.white,
        // borderRadius: BorderRadius.circular(10),
        // border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(title ?? '',
                  style: const TextStyle(
                    color: AppColors.textQuaternary,
                    fontSize: 11,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                  )),
              const Spacer(),
              if (trailing != null) trailing,
            ],
          ),
          // const SizedBox(height: 8),
          child,
        ],
      ),
    );
  }

  Widget _buildCalendar() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.purple.withOpacity(0.05),
        border: Border.all(color: AppColors.purple.withOpacity(0.25), width: 1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: TableCalendar(
        firstDay: DateTime.now(),
        lastDay: DateTime.now().add(const Duration(days: 365 * 2)),
        focusedDay: focusedDay,
        selectedDayPredicate: (day) =>
            isSameDay(day, widget.pickupDate) ||
            isSameDay(day, widget.returnDate),
        rangeStartDay: widget.pickupDate,
        rangeEndDay: widget.returnDate,
        rangeSelectionMode: RangeSelectionMode.disabled,
        calendarFormat: CalendarFormat.month,
        headerStyle: HeaderStyle(
          formatButtonVisible: false,
          titleCentered: true,
          leftChevronIcon:
              Icon(Icons.chevron_left, size: 16, color: Colors.grey.shade600),
          rightChevronIcon:
              Icon(Icons.chevron_right, size: 16, color: Colors.grey.shade600),
          titleTextStyle:
              const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
          headerPadding: const EdgeInsets.symmetric(vertical: 4),
        ),
        calendarStyle: CalendarStyle(
          todayDecoration: BoxDecoration(
            color: AppColors.green.withOpacity(.25),
            shape: BoxShape.circle,
          ),
          selectedDecoration: const BoxDecoration(
              color: AppColors.purple, shape: BoxShape.circle),
          rangeStartDecoration: const BoxDecoration(
              color: AppColors.purple, shape: BoxShape.circle),
          rangeEndDecoration: const BoxDecoration(
              color: AppColors.purple, shape: BoxShape.circle),
          rangeHighlightColor: AppColors.purple.withOpacity(.15),
          outsideDaysVisible: false,
          cellMargin: const EdgeInsets.all(2),
          defaultTextStyle: const TextStyle(fontSize: 11),
          weekendTextStyle: const TextStyle(fontSize: 11),
        ),
        daysOfWeekStyle: DaysOfWeekStyle(
          weekdayStyle: TextStyle(fontSize: 10, color: Colors.grey.shade600),
          weekendStyle: TextStyle(fontSize: 10, color: Colors.grey.shade600),
        ),
        rowHeight: 32,
        daysOfWeekHeight: 20,
        onDaySelected: (day, fDay) {
          setState(() {
            focusedDay = fDay;
            selectedDay = day;
          });
          if (isSelectingPickup) {
            widget.onPickupDateChanged(day);
            if (widget.returnDate.isBefore(day)) {
              widget.onReturnDateChanged(day.add(const Duration(days: 1)));
            }
          } else {
            if (day.isAfter(widget.pickupDate) ||
                isSameDay(day, widget.pickupDate)) {
              widget.onReturnDateChanged(day);
            }
          }
        },
        onPageChanged: (fDay) => setState(() => focusedDay = fDay),
      ),
    );
  }

  Widget _buildDateTimeRow({
    required String label,
    required DateTime date,
    required TimeOfDay? time,
    required VoidCallback onDateTap,
    required VoidCallback onTimeTap,
    required IconData iconData,
  }) {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: _buildDateField(
            label: label,
            value: date.format(),
            icon: iconData,
            onTap: onDateTap,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildTimeField(
            label: 'time',
            value: time?.format(context) ?? '-:-- PM',
            onTap: onTimeTap,
          ),
        ),
      ],
    );
  }

  Widget _buildDateField({
    required String label,
    required String value,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        height: 48,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey.shade300, width: 1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Icon(icon, size: 16, color: AppColors.purple),
            const SizedBox(width: 8),
            Text(
              value,
              style: const TextStyle(
                fontSize: 13,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
            const Spacer(),
            Icon(Icons.keyboard_arrow_down,
                size: 18, color: Colors.grey.shade400),
          ],
        ),
      ),
    );
  }

  Widget _buildTimeField({
    required String label,
    required String value,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        height: 48,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey.shade300, width: 1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                value,
                style: const TextStyle(
                  fontSize: 13,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
            ),
            Icon(Icons.keyboard_arrow_down,
                size: 18, color: Colors.grey.shade400),
          ],
        ),
      ),
    );
  }

  Widget _buildCoolingPeriodRow() {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: InkWell(
            onTap: _selectCoolingPeriodDate,
            borderRadius: BorderRadius.circular(8),
            child: Container(
              height: 48,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.grey.shade300, width: 1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Icon(Icons.calendar_today_outlined,
                      size: 16, color: AppColors.purple),
                  const SizedBox(width: 8),
                  Text(
                    widget.coolingPeriodDate?.format() ?? 'Cooling period',
                    style: TextStyle(
                      fontSize: 13,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w500,
                      color: widget.coolingPeriodDate != null
                          ? Colors.black
                          : const AppColors.textQuaternary,
                    ),
                  ),
                  const Spacer(),
                  Icon(Icons.keyboard_arrow_down,
                      size: 18, color: Colors.grey.shade400),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: InkWell(
            onTap: _selectCoolingPeriodTime,
            borderRadius: BorderRadius.circular(8),
            child: Container(
              height: 48,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.grey.shade300, width: 1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      widget.coolingPeriodTime?.format(context) ?? '-:-- PM',
                      style: TextStyle(
                        fontSize: 13,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w500,
                        color: widget.coolingPeriodTime != null
                            ? Colors.black
                            : const AppColors.textQuaternary,
                      ),
                    ),
                  ),
                  Icon(Icons.keyboard_arrow_down,
                      size: 18, color: Colors.grey.shade400),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  /// Build booked date field for sales mode (date only, no time)
  Widget _buildBookedDateField() {
    return _buildDateField(
      label: 'Booked date',
      value: widget.pickupDate.format(),
      icon: Icons.calendar_today_outlined,
      onTap: () => _selectBookedDate(),
    );
  }

  void _selectDate(bool isPickup) async {
    setState(() {
      isSelectingPickup = isPickup;
    });

    final initialDate = isPickup ? widget.pickupDate : widget.returnDate;
    final firstDate = isPickup
        ? DateTime.now().subtract(const Duration(days: 30))
        : widget.pickupDate;

    final picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: firstDate,
      lastDate: DateTime.now().add(const Duration(days: 365 * 2)),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: AppColors.purple,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      if (isPickup) {
        widget.onPickupDateChanged(picked);
        if (widget.returnDate.isBefore(picked)) {
          widget.onReturnDateChanged(picked.add(const Duration(days: 1)));
        }
      } else {
        widget.onReturnDateChanged(picked);
      }
    }
  }

  void _selectTime(bool isPickup) async {
    final initialTime = isPickup
        ? widget.pickupTime ?? TimeOfDay.now()
        : widget.returnTime ?? TimeOfDay.now();

    final picked = await showTimePicker(
      context: context,
      initialTime: initialTime,
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: AppColors.purple,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      if (isPickup) {
        widget.onPickupTimeChanged(picked);
      } else {
        widget.onReturnTimeChanged(picked);
      }
    }
  }

  void _selectCoolingPeriodDate() async {
    final initialDate = widget.coolingPeriodDate ??
        widget.returnDate.add(const Duration(days: 1));

    final picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: widget.returnDate,
      lastDate: DateTime.now().add(const Duration(days: 365 * 2)),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: AppColors.purple,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      widget.onCoolingPeriodDateChanged(picked);
    }
  }

  void _selectCoolingPeriodTime() async {
    final initialTime = widget.coolingPeriodTime ?? TimeOfDay.now();

    final picked = await showTimePicker(
      context: context,
      initialTime: initialTime,
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: AppColors.purple,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      widget.onCoolingPeriodTimeChanged(picked);
    }
  }

  /// Date picker for booked date in sales mode
  void _selectBookedDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: widget.pickupDate,
      firstDate: DateTime.now().subtract(const Duration(days: 30)),
      lastDate: DateTime.now().add(const Duration(days: 365 * 2)),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: AppColors.purple,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      widget.onPickupDateChanged(picked);
    }
  }
}

