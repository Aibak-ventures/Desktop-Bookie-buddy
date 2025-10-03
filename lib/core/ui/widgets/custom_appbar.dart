import 'package:bookie_buddy_web/core/extensions/context_extensions.dart';
import 'package:bookie_buddy_web/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar(
    this.text, {
    super.key,
    this.leadingIcon,
    this.onLeadingPressed,
    this.leadingIconColor,
    this.trailingIcon,
    this.onTrailingPressed,
    this.trailingIconColor,
  });

  final String text;
  final Widget? leadingIcon;
  final VoidCallback? onLeadingPressed;
  final Color? leadingIconColor;
  final Widget? trailingIcon;
  final VoidCallback? onTrailingPressed;
  final Color? trailingIconColor;

  @override
  Widget build(BuildContext context) => AppBar(
      backgroundColor: AppColors.white,
      elevation: 0,
      leading: leadingIcon != null
          ? IconButton(
              icon: IconTheme(
                data: IconThemeData(color: leadingIconColor ?? Colors.black),
                child: leadingIcon!,
              ),
              onPressed: onLeadingPressed ??
                  () {
                    context.pop();
                  },
            )
          : null,
      title: Text(text),
      actions: [
        if (trailingIcon != null)
          IconButton(
            icon: IconTheme(
              data: IconThemeData(color: trailingIconColor ?? Colors.black),
              child: trailingIcon!,
            ),
            onPressed: onTrailingPressed,
          ),
      ],
    );

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
