import 'package:bookie_buddy_web/core/enums/shop_based_enums.dart';
import 'package:bookie_buddy_web/core/models/user_model/user_model.dart';
import 'package:bookie_buddy_web/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ManagePasswordSettingsTile extends StatelessWidget {
  const ManagePasswordSettingsTile({
    super.key,
    required this.setting,
    required this.isEnabled,
    required this.onChanged,
  });

  final UserPasswordSettingsModel setting;
  final bool isEnabled;
  final void Function(String? newVal) onChanged;

  @override
  Widget build(BuildContext context) => Container(
    margin: EdgeInsets.symmetric(vertical: 6.h),
    padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
    decoration: BoxDecoration(
      color: AppColors.white,
      borderRadius: BorderRadius.circular(8.r),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.1),
          blurRadius: 4.r,
          offset: Offset(0, 2.h),
        ),
      ],
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          setting.location?.name ?? '' + ':',
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15.sp),
        ),
        DropdownButton<String>(
          value: setting.role.value,
          underline: const SizedBox(),
          dropdownColor: AppColors.white,
          items: UserPasswordSettingRole.values
              .map(
                (role) => DropdownMenuItem(
                  value: role.value,
                  enabled: isEnabled,
                  child: Text(role.name),
                ),
              )
              .toList(),
          onChanged: onChanged,
        ),
      ],
    ),
  );
}
