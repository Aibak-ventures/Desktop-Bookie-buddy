import 'package:bookie_buddy_web/core/theme/app_colors.dart';
import 'package:material_ui/material_ui.dart';

class ApplyTaxSwitch extends StatelessWidget {
  const ApplyTaxSwitch({
    super.key,
    required this.value,
    required this.onChanged,
    this.itemName = 'order',
  });

  final bool value;
  final ValueChanged<bool> onChanged;
  final String itemName;

  @override
  Widget build(BuildContext context) => Row(
    children: [
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Apply Tax',
              style: TextStyle(
                fontSize: 12,
                color: Colors.black87,
                fontFamily: 'Inter',
              ),
            ),
            Text(
              'Turn off to leave your shop tax out of this $itemName',
              style: TextStyle(
                fontSize: 10,
                color: Colors.grey.shade600,
                fontFamily: 'Inter',
              ),
            ),
          ],
        ),
      ),
      const SizedBox(width: 4),
      Transform.scale(
        scale: 0.75,
        child: Switch(
          value: value,
          onChanged: onChanged,
          activeThumbColor: AppColors.purple,
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
      ),
    ],
  );
}
