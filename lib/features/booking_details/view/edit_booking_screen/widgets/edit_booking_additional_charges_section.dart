import 'package:bookie_buddy_web/core/ui/dialogs/add_additional_charge_dialog.dart';
import 'package:bookie_buddy_web/core/ui/widgets/additional_charges_list_widget.dart';
import 'package:bookie_buddy_web/features/booking/domain/models/additional_charges_model/additional_charges_model.dart';
import 'package:bookie_buddy_web/features/booking_details/view/edit_booking_screen/widgets/edit_booking_section_column.dart';
import 'package:flutter/material.dart';

class EditBookingAdditionalChargesSection extends StatelessWidget {
  const EditBookingAdditionalChargesSection({
    super.key,
    required this.additionalChargesNotifier,
  });
  final ValueNotifier<List<AdditionalChargesModel>> additionalChargesNotifier;
  @override
  Widget build(BuildContext context) => EditBookingSectionColumn(
        title: 'Additional Charges',
        trailing: IconButton(
          onPressed: () {
            showAddAdditionalChargeDialog(
              context: context,
              additionalChargesNotifier: additionalChargesNotifier,
            );
          },
          icon: const Icon(Icons.add),
        ),
        child: AdditionalChargesListWidget(
          additionalChargesNotifier: additionalChargesNotifier,
        ),
      );
}
