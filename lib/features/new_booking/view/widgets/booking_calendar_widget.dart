import 'package:bookie_buddy_web/core/extensions/date_time_extensions.dart';
import 'package:bookie_buddy_web/core/theme/app_colors.dart';
import 'package:bookie_buddy_web/core/ui/widgets/custom_textfield.dart';
import 'package:bookie_buddy_web/core/ui/widgets/staff_search_name_field.dart';
import 'package:bookie_buddy_web/core/view_model/cubit_client/client_cubit.dart';
import 'package:bookie_buddy_web/core/view_model/cubit_staff_search/staff_search_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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

  final ValueChanged<int?> onStaffSelected;
  final ValueChanged<int?> onClientSelected;

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
    required this.isSearchClientEnabled,
    required this.onSearchClientToggle,
    required this.onStaffSelected,
    required this.onClientSelected,
    required this.onCoolingPeriodTimeChanged,
  });

  @override
  State<BookingCalendarWidget> createState() => _BookingCalendarWidgetState();
}

class _BookingCalendarWidgetState extends State<BookingCalendarWidget> {
  late DateTime focusedDay;
  late DateTime selectedDay;
  bool isSelectingPickup = true; // true = pickup, false = return

  @override
  void initState() {
    super.initState();
    focusedDay = widget.pickupDate;
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
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
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
                      _buildDateTimeRow(
                        label: 'Pickup date',
                        date: widget.pickupDate,
                        time: widget.pickupTime,
                        onDateTap: () => _selectDate(true),
                        onTimeTap: () => _selectTime(true),
                        iconData: Icons.calendar_today_outlined,
                      ),
                      const SizedBox(height: 12),
                      // Return date and time
                      _buildDateTimeRow(
                        label: 'Return date',
                        date: widget.returnDate,
                        time: widget.returnTime,
                        onDateTap: () => _selectDate(false),
                        onTimeTap: () => _selectTime(false),
                        iconData: Icons.calendar_today_outlined,
                      ),
                      const SizedBox(height: 12),
                      // Cooling period
                      _buildCoolingPeriodRow(),
                        const SizedBox(height: 72),
                      
                         
                       SizedBox(width: 360,
                        
                        child: _compactField(widget.clientAddressController, 'Place', Icons.location_on_outlined)),
   const SizedBox(height: 12),
                        _buildStaffDetailsCard(),
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
          ? _buildClientSearchField()
          : _buildClientManualFields(),
    );
  }
    Widget _buildClientSearchField() {
    return BlocBuilder<ClientCubit, ClientState>(
      builder: (context, state) {
        return Column(
          children: [
            SizedBox(
              height: 34,
              child: CustomTextField(
                validator: (value) {
                  
                },
                controller: widget.clientNameController,
                hintText: 'Search client',
                prefixIcon: const Icon(Icons.search, size: 16),
                // style: const TextStyle(fontSize: 12),
                onChanged: (v) {
                  if (v.length >= 3) {
                    context.read<ClientCubit>().searchClient(v);
                  }
                },
              ),
            ),
            if (state.suggestions.isNotEmpty) ...[
              const SizedBox(height: 6),
              Container(
                height: 120,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: ListView.builder(
                  itemCount: state.suggestions.length,
                  itemBuilder: (_, i) {
                    final c = state.suggestions[i];
                    return ListTile(
                      dense: true,
                      visualDensity: const VisualDensity(vertical: -3),
                      title:
                          Text(c.name, style: const TextStyle(fontSize: 11)),
                      subtitle: Text(c.phone1.toString(),
                          style: TextStyle(
                              fontSize: 10, color: Colors.grey.shade600)),
                      onTap: () {
                        widget.clientNameController.text = c.name;
                        widget.clientPhone1Controller.text =
                            c.phone1.toString();
                        widget.clientPhone2Controller.text =
                            c.phone2?.toString() ?? '';
                        widget.onClientSelected(c.id);
                        context.read<ClientCubit>().selectClient(c);
                      },
                    );
                  },
                ),
              ),
            ],
          ],
        );
      },
    );
  }

Widget _buildClientManualFields() {
  return Column(
    children: [
      Column(
        children: [
          _compactField(widget.clientNameController, 'Name', Icons.person_outline),
          const SizedBox(height: 8),
          _compactField(widget.clientPhone1Controller, 'Phone', Icons.phone_outlined, TextInputType.phone),
          const SizedBox(height: 8),
          _compactField(widget.clientPhone2Controller, 'Phone 2', Icons.phone_outlined, TextInputType.phone),
        ],
      ),
      const SizedBox(width: 8),
  
    ],
  );
}

  Widget _buildStaffDetailsCard() {
    return _card(
      title: 'Staff details',
      child: BlocListener<StaffSearchCubit, StaffSearchState>(
        listener: (context, state) =>
            widget.onStaffSelected(state.selectedStaff?.id),
        child: StaffSearchNameField(
          nameController: widget.staffNameController,
        ),
      ),
    );
  }
  Widget _compactField(
  TextEditingController c,
  String hint,
  IconData icon, [
  TextInputType type = TextInputType.text,
]) {
  return SizedBox(
    height: 38,
    child: InkWell(
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Icon(icon, size: 16, color: Colors.grey.shade600),
            const SizedBox(width: 8),
            Expanded(
              child: TextField(
                controller: c,
                keyboardType: type,
                style: const TextStyle(fontSize: 12),
                decoration:  InputDecoration(
                  border: InputBorder.none,
                  isCollapsed: true,
                  hintText: hint,
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

 Widget _card({required String title, Widget? trailing, required Widget child}) {
    return Container(
      padding: const EdgeInsets.all(12),
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
              Text(title,
                  style: const TextStyle(
                      fontSize: 12, fontWeight: FontWeight.w600)),
              const Spacer(),
              if (trailing != null) trailing,
            ],
          ),
          const SizedBox(height: 8),
          child,
        ],
      ),
    );
  }
Widget _buildCalendar() {
  return Container(
    decoration: BoxDecoration(
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
        selectedDecoration:
            const BoxDecoration(color: AppColors.purple, shape: BoxShape.circle),
        rangeStartDecoration:
            const BoxDecoration(color: AppColors.purple, shape: BoxShape.circle),
        rangeEndDecoration:
            const BoxDecoration(color: AppColors.purple, shape: BoxShape.circle),
        rangeHighlightColor: AppColors.purple.withOpacity(.15),
        outsideDaysVisible: false,
        cellMargin: const EdgeInsets.all(2),
        defaultTextStyle: const TextStyle(fontSize: 11),
        weekendTextStyle: const TextStyle(fontSize: 11),
      ),
      daysOfWeekStyle: DaysOfWeekStyle(
        weekdayStyle:
            TextStyle(fontSize: 10, color: Colors.grey.shade600),
        weekendStyle:
            TextStyle(fontSize: 10, color: Colors.grey.shade600),
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey.shade600,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 6),
        InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(8),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Icon(icon, size: 18, color: AppColors.purple),
                const SizedBox(width: 8),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const Spacer(),
                Icon(Icons.keyboard_arrow_down,
                    size: 18, color: Colors.grey.shade500),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTimeField({
    required String label,
    required String value,
    required VoidCallback onTap,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey.shade600,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 6),
        InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(8),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    value,
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Icon(Icons.keyboard_arrow_down,
                    size: 18, color: Colors.grey.shade500),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCoolingPeriodRow() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Cooling period',
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey.shade600,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 6),
        Row(
          children: [
            Expanded(
              flex: 2,
              child: InkWell(
                onTap: _selectCoolingPeriodDate,
                borderRadius: BorderRadius.circular(8),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.calendar_today_outlined,
                          size: 18, color: AppColors.purple),
                      const SizedBox(width: 8),
                      Text(
                        widget.coolingPeriodDate?.format() ?? 'Select date',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: widget.coolingPeriodDate != null
                              ? Colors.black87
                              : Colors.grey.shade500,
                        ),
                      ),
                      const Spacer(),
                      Icon(Icons.keyboard_arrow_down,
                          size: 18, color: Colors.grey.shade500),
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
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          widget.coolingPeriodTime?.format(context) ??
                              '-:-- PM',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                            color: widget.coolingPeriodTime != null
                                ? Colors.black87
                                : Colors.grey.shade500,
                          ),
                        ),
                      ),
                      Icon(Icons.keyboard_arrow_down,
                          size: 18, color: Colors.grey.shade500),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
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
}
