part of '../pages/old_new_booking_screen.dart';

extension BookingDateSectionBuilders on OldNewBookingScreenState {
  Future<void> _selectDate({required bool isPickup}) async {
    final isSales = selectedBookingType == BookingType.sales;
    final isOldBooking = selectedBookingType == BookingType.oldBooking;
    final today = DateTime.now().dateOnly;
    final oldBookingMinDate = DateTime(2015);

    if (isPickup) {
      final picked = await showDatePicker(
        context: context,
        initialDate: pickupDate,
        firstDate: isOldBooking
            ? oldBookingMinDate
            : DateTime.now().subtract(const Duration(days: 365)),
        lastDate: (isSales || isOldBooking)
            ? DateTime.now()
            : DateTime.now().add(const Duration(days: 365)),
        builder: (context, child) {
          return Theme(
            data: Theme.of(context).copyWith(
              colorScheme: const ColorScheme.light(primary: Color(0xFF6132E4)),
            ),
            child: child!,
          );
        },
      );

      if (picked != null) {
        setState(() {
          pickupDate = picked;

          if (isSales) {
            decreaseStockForPastDate = false;
          }

          if (picked.dateOnly.isAfter(returnDate.dateOnly)) {
            returnDate = isOldBooking
                ? picked
                : picked.add(const Duration(days: 1));
          }

          // Keep coolingPeriodDate in sync whenever pickup date changes.
          // Must run after both pickupDate and returnDate are finalized above.
          if (coolingPeriodDate != null) {
            _updateCoolingPeriod();
          }
        });

        _loadProductsForService(selectedServiceId);
        if (_searchOverlayEntry != null) _searchAllProductsForOverlay();
      }
    } else {
      if (isOldBooking) {
        final minReturnDate = pickupDate.dateOnly;
        final initialReturnDate = returnDate.dateOnly.isBefore(minReturnDate)
            ? minReturnDate
            : returnDate.dateOnly.isAfter(today)
            ? today
            : returnDate.dateOnly;

        final picked = await showDatePicker(
          context: context,
          initialDate: initialReturnDate,
          firstDate: minReturnDate,
          lastDate: today,
          builder: (context, child) {
            return Theme(
              data: Theme.of(context).copyWith(
                colorScheme: const ColorScheme.light(
                  primary: Color(0xFF6132E4),
                ),
              ),
              child: child!,
            );
          },
        );

        if (picked != null) {
          setState(() {
            returnDate = picked;
          });
          _loadProductsForService(selectedServiceId);
          if (_searchOverlayEntry != null) _searchAllProductsForOverlay();
        }
        return;
      }

      final minReturnDate = pickupDate.dateOnly.isAfter(today)
          ? pickupDate.dateOnly
          : today;

      final picked = await showDatePicker(
        context: context,
        initialDate: minReturnDate.isAfter(returnDate.dateOnly)
            ? minReturnDate
            : returnDate,
        firstDate: minReturnDate,
        lastDate: DateTime.now().add(const Duration(days: 365)),
        builder: (context, child) {
          return Theme(
            data: Theme.of(context).copyWith(
              colorScheme: const ColorScheme.light(primary: Color(0xFF6132E4)),
            ),
            child: child!,
          );
        },
      );

      if (picked != null) {
        setState(() {
          returnDate = picked;

          if (coolingPeriodDate != null) {
            _updateCoolingPeriod();
          }
        });

        _loadProductsForService(selectedServiceId);
        if (_searchOverlayEntry != null) _searchAllProductsForOverlay();
      }
    }
  }

  Future<void> _selectBookedDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _bookedDate ?? DateTime.now(),
      firstDate: DateTime(2015),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(primary: Color(0xFF6132E4)),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() => _bookedDate = picked);
    }
  }

  Future<void> _selectTime({required bool isPickup}) async {
    final initialTime = isPickup
        ? (pickupTime ?? TimeOfDay.now())
        : (returnTime ?? TimeOfDay.now());
    final picked = await showTimePicker(
      context: context,
      initialTime: initialTime,
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(primary: Color(0xFF6132E4)),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      if (isPickup) {
        if (pickupDate.isDateToday && BookingFormValidator.isTimeInPast(picked)) {
          _showTimeError('Pickup time cannot be in the past');
          return;
        }

        setState(() {
          pickupTime = picked;
        });

        if (pickupDate.dateOnly.isAtSameMomentAs(returnDate.dateOnly) &&
            returnTime != null) {
          if (!BookingFormValidator.isReturnAfterPickup(picked, returnTime!)) {
            setState(() {
              returnTime = null;
            });
            _showTimeError(
              'Return time has been cleared as it was before the new pickup time',
            );
          }
        }

        _loadProductsForService(selectedServiceId);
      } else {
        if (returnDate.isDateToday && BookingFormValidator.isTimeInPast(picked)) {
          _showTimeError('Return time cannot be in the past');
          return;
        }

        if (pickupDate.dateOnly.isAtSameMomentAs(returnDate.dateOnly) &&
            pickupTime != null) {
          if (!BookingFormValidator.isReturnAfterPickup(pickupTime!, picked)) {
            _showTimeError('Return time must be after pickup time');
            return;
          }
        }

        setState(() {
          returnTime = picked;
        });

        _loadProductsForService(selectedServiceId);
      }
    }
  }

  Widget _buildDateSelectionSection() {
    final isSales = selectedBookingType == BookingType.sales;
    final isOldBooking = selectedBookingType == BookingType.oldBooking;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            isSales ? 'Sale date' : 'Select dates',
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 7),
          if (isSales)
            SizedBox(
              width: 400,
              child: _buildNewDateField(
                label: 'Sale date',
                value: pickupDate.format(),
                onTap: () => _selectDate(isPickup: true),
                autofocus: true,
              ),
            )
          else if (isOldBooking)
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(child: _buildOldBookedDateField()),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildNewDateField(
                    label: 'Pickup date',
                    value: pickupDate.format(),
                    onTap: () => _selectDate(isPickup: true),
                    autofocus: true,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildNewDateField(
                    label: 'Return date',
                    value: returnDate.format(),
                    onTap: () => _selectDate(isPickup: false),
                  ),
                ),
              ],
            )
          else
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  flex: 3,
                  child: _buildNewDateField(
                    label: 'Pickup date',
                    value: pickupDate.format(),
                    onTap: () => _selectDate(isPickup: true),
                    focusNode: _pickupDateFocusNode,
                    nextFocusNode: _pickupTimeFocusNode,
                    autofocus: true,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  flex: 2,
                  child: _buildNewTimeField(
                    label: 'time',
                    value: pickupTime?.format(context) ?? '--:--',
                    onTap: () => _selectTime(isPickup: true),
                    focusNode: _pickupTimeFocusNode,
                    nextFocusNode: _returnDateFocusNode,
                  ),
                ),
                const SizedBox(width: 16),

                Container(
                  height: 50,
                  width: 2,
                  margin: const EdgeInsets.only(bottom: 0),
                  decoration: BoxDecoration(color: Colors.grey.shade400),
                ),
                const SizedBox(width: 16),

                Expanded(
                  flex: 3,
                  child: _buildNewDateField(
                    label: 'Return date',
                    value: returnDate.format(),
                    onTap: () => _selectDate(isPickup: false),
                    focusNode: _returnDateFocusNode,
                    nextFocusNode: _returnTimeFocusNode,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  flex: 2,
                  child: _buildNewTimeField(
                    label: 'time',
                    value: returnTime?.format(context) ?? '--:--',
                    onTap: () => _selectTime(isPickup: false),
                    focusNode: _returnTimeFocusNode,
                    nextFocusNode: _coolingPeriodFocusNode,
                  ),
                ),

                const SizedBox(width: 16),

                Container(
                  height: 50,
                  width: 2,
                  margin: const EdgeInsets.only(bottom: 0),
                  decoration: BoxDecoration(color: Colors.grey.shade400),
                ),
                const SizedBox(width: 16),

                // Cooling Period (Days)
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Cooling period',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey.shade600,
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Text(
                                  coolingPeriodMode.isAfter
                                      ? '(after)'
                                      : '(before)',
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: Colors.grey.shade400,
                                    fontFamily: 'Inter',
                                  ),
                                ),
                              ],
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              setState(() {
                                coolingPeriodMode = coolingPeriodMode.isAfter
                                    ? CoolingPeriodMode.before
                                    : CoolingPeriodMode.after;
                              });
                              _updateCoolingPeriod();
                              _loadProductsForService(selectedServiceId);
                              if (_searchOverlayEntry != null)
                                _searchAllProductsForOverlay();
                            },
                            child: Text(
                              coolingPeriodMode.isAfter ? "After" : "Before",
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Container(
                        height: 42,
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey.shade300),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Focus(
                          focusNode: _coolingPeriodFocusNode,
                          onKeyEvent: (_, event) {
                            if (event is KeyDownEvent &&
                                (event.logicalKey ==
                                        LogicalKeyboardKey.enter ||
                                    event.logicalKey ==
                                        LogicalKeyboardKey.numpadEnter)) {
                              _searchAllProductsForOverlay();
                              _productSearchFocusNode.requestFocus();
                              return KeyEventResult.handled;
                            }
                            return KeyEventResult.ignored;
                          },
                          child: DropdownButtonHideUnderline(
                            child: Builder(
                              builder: (context) {
                                final currentDays = coolingPeriodDays;
                                final standardValues = {
                                  0,
                                  1,
                                  2,
                                  3,
                                  4,
                                  5,
                                  6,
                                  7,
                                  8,
                                  9,
                                  10,
                                };
                                final hasCustomValue =
                                    !standardValues.contains(currentDays);
                                return DropdownButton<int>(
                                  value: currentDays,
                                  isExpanded: true,
                                  icon: const Icon(
                                    Icons.keyboard_arrow_down,
                                    size: 18,
                                  ),
                                  style: const TextStyle(
                                    fontSize: 13,
                                    color: Colors.black87,
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w500,
                                  ),
                                  items: [
                                    const DropdownMenuItem(
                                      value: 0,
                                      child: Text('None'),
                                    ),
                                    if (hasCustomValue)
                                      DropdownMenuItem(
                                        value: currentDays,
                                        child: Text('$currentDays days'),
                                      ),
                                    ...List.generate(10, (index) {
                                      final days = index + 1;
                                      return DropdownMenuItem(
                                        value: days,
                                        child: Text(
                                          '$days day${days > 1 ? 's' : ''}',
                                        ),
                                      );
                                    }),
                                  ],
                                  onChanged: (val) {
                                    if (val != null) {
                                      setState(
                                        () => coolingPeriodDays = val,
                                      );
                                      _updateCoolingPeriod();
                                      _loadProductsForService(
                                        selectedServiceId,
                                      );
                                      if (_searchOverlayEntry != null)
                                        _searchAllProductsForOverlay();
                                      _productSearchFocusNode.requestFocus();
                                    }
                                  },
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }

  Widget _buildNewDateField({
    required String label,
    required String value,
    required Future<void> Function() onTap,
    FocusNode? focusNode,
    FocusNode? nextFocusNode,
    bool autofocus = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey.shade600,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        Focus(
          focusNode: focusNode,
          autofocus: autofocus,
          onKeyEvent: (_, event) {
            if (event is KeyDownEvent &&
                (event.logicalKey == LogicalKeyboardKey.enter ||
                    event.logicalKey == LogicalKeyboardKey.numpadEnter)) {
              onTap().then((_) {
                if (nextFocusNode != null) {
                  nextFocusNode.requestFocus();
                } else {
                  FocusScope.of(context).nextFocus();
                }
              });
              return KeyEventResult.handled;
            }
            return KeyEventResult.ignored;
          },
          child: InkWell(
            onTap: () {
              focusNode?.requestFocus();
              onTap().then((_) {
                if (nextFocusNode != null) {
                  nextFocusNode.requestFocus();
                } else {
                  FocusScope.of(context).nextFocus();
                }
              });
            },
            borderRadius: BorderRadius.circular(8),
            child: Container(
              height: 42,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: const Color(0xFFF9F9FC),
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.calendar_today_outlined,
                    size: 16,
                    color: const Color(0xFF9A76E8),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      value,
                      style: const TextStyle(
                        fontSize: 13,
                        color: Colors.black87,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Icon(
                    Icons.keyboard_arrow_down,
                    size: 18,
                    color: Colors.grey.shade500,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildOldBookedDateField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Booked date (optional)',
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey.shade600,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        Focus(
          onKeyEvent: (_, event) {
            if (event is KeyDownEvent &&
                (event.logicalKey == LogicalKeyboardKey.enter ||
                    event.logicalKey == LogicalKeyboardKey.numpadEnter)) {
              _selectBookedDate().then(
                (_) => FocusScope.of(context).nextFocus(),
              );
              return KeyEventResult.handled;
            }
            return KeyEventResult.ignored;
          },
          child: InkWell(
            onTap: () => _selectBookedDate().then(
              (_) => FocusScope.of(context).nextFocus(),
            ),
            borderRadius: BorderRadius.circular(8),
            child: Container(
              height: 42,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: const Color(0xFFF9F9FC),
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.calendar_today_outlined,
                    size: 16,
                    color: const Color(0xFF9A76E8),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      _bookedDate?.format() ?? 'Select booked date',
                      style: TextStyle(
                        fontSize: 13,
                        color: _bookedDate == null
                            ? Colors.grey.shade500
                            : Colors.black87,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  if (_bookedDate != null)
                    GestureDetector(
                      onTap: () => setState(() => _bookedDate = null),
                      child: Icon(
                        Icons.close,
                        size: 16,
                        color: Colors.grey.shade500,
                      ),
                    )
                  else
                    Icon(
                      Icons.keyboard_arrow_down,
                      size: 18,
                      color: Colors.grey.shade500,
                    ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildNewTimeField({
    required String label,
    required String value,
    required Future<void> Function() onTap,
    FocusNode? focusNode,
    FocusNode? nextFocusNode,
    bool autofocus = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey.shade600,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        Focus(
          focusNode: focusNode,
          autofocus: autofocus,
          onKeyEvent: (_, event) {
            if (event is KeyDownEvent &&
                (event.logicalKey == LogicalKeyboardKey.enter ||
                    event.logicalKey == LogicalKeyboardKey.numpadEnter)) {
              onTap().then((_) {
                if (nextFocusNode != null) {
                  nextFocusNode.requestFocus();
                } else {
                  FocusScope.of(context).nextFocus();
                }
              });
              return KeyEventResult.handled;
            }
            return KeyEventResult.ignored;
          },
          child: InkWell(
            onTap: () {
              focusNode?.requestFocus();
              onTap().then((_) {
                if (nextFocusNode != null) {
                  nextFocusNode.requestFocus();
                } else {
                  FocusScope.of(context).nextFocus();
                }
              });
            },
            borderRadius: BorderRadius.circular(8),
            child: Container(
              height: 42,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: const Color(0xFFF9F9FC),
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
                        color: Colors.black87,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Icon(
                    Icons.keyboard_arrow_down,
                    size: 18,
                    color: Colors.grey.shade500,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
