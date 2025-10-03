import 'package:bookie_buddy_web/core/extensions/color_extensions.dart';
import 'package:bookie_buddy_web/core/extensions/context_extensions.dart';
import 'package:bookie_buddy_web/core/extensions/number_extensions.dart';
import 'package:bookie_buddy_web/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomElevatedButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final String? subText;

  // Appearance
  final Color? textColor;
  final Color? backgroundColor;
  final EdgeInsetsGeometry? padding;

  // Dimensions
  final double? width;
  final double? height;

  // State
  final bool isLoading;
  final String loadingText;
  final Widget? icon;
  final bool isNormal;

  const CustomElevatedButton({
    required this.text,
    required this.onPressed,
    super.key,
    this.padding,
    this.width,
    this.height,
    this.isLoading = false,
    this.icon,
    this.loadingText = 'Loading...',
    this.isNormal = true,
    this.backgroundColor,
    this.subText,
    this.textColor,
  });
  @override
  Widget build(BuildContext context) => Center(
      child: SizedBox(
        width: width ?? context.mediaQueryWidth(0.85),
        height: height ?? context.mediaQueryHeight(0.06),
        child: ElevatedButton.icon(
          onPressed: isLoading ? () {} : onPressed,
          style: isNormal ? _buildButtonStyleNormal() : _buildButtonStyle(),
          label: subText == null
              ? _buildButtonContent(context)
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  spacing: 3,
                  children: [
                    _buildButtonContent(context),
                    Text(
                      subText!,
                      style: TextStyle(
                        color: AppColors.grey,
                        fontSize: 12.0.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    )
                  ],
                ),
          icon: icon == null || isLoading
              ? null
              : Theme(
                  data: context.theme.copyWith(
                    iconTheme: IconThemeData(
                      color: isNormal
                          ? AppColors.purple
                          : AppColors.redTomato.lighten(0.2),
                    ),
                  ),
                  child: icon!,
                ),
        ),
      ),
    );

  ButtonStyle _buildButtonStyleNormal() => ElevatedButton.styleFrom(
      padding:
          padding ?? EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.w),
      backgroundColor: AppColors.purpleLight,
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: 5.radiusBorder,
      ),
    );

  ButtonStyle _buildButtonStyle() => ElevatedButton.styleFrom(
      padding:
          padding ?? EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.w),
      backgroundColor: backgroundColor ?? AppColors.redLight.lighten(0.4),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: 5.radiusBorder,
        side: BorderSide(
          color: backgroundColor ?? AppColors.redTomato.withValues(alpha: 0.3),
        ),
      ),
    );

  Widget _buildButtonContent(BuildContext context) => Text(
      isLoading ? loadingText : text,
      style: TextStyle(
        color: isNormal
            ? AppColors.purple
            : textColor ?? AppColors.redTomato.lighten(0.2),
        fontSize: 18.sp,
        fontWeight: FontWeight.w500,
      ),
    );
}
