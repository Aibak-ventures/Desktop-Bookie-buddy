import 'package:bookie_buddy_web/core/constants/app_assets.dart';
import 'package:bookie_buddy_web/core/extensions/context_extensions.dart';
import 'package:bookie_buddy_web/core/extensions/number_extensions.dart';
import 'package:bookie_buddy_web/core/extensions/widget_extensions.dart';
import 'package:bookie_buddy_web/core/theme/app_colors.dart';
import 'package:bookie_buddy_web/core/ui/widgets/custom_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ServiceCard extends StatelessWidget {
  final String serviceName;
  final String? icon;
  final VoidCallback onTap;
  final bool isGrid;

  const ServiceCard({
    super.key,
    required this.serviceName,
    required this.onTap,
    required this.icon,
    this.isGrid = false,
  });

  @override
  Widget build(BuildContext context) => Padding(
      padding: 24.paddingOnly(
        bottom: true,
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            width: isGrid ? 0.3.widthR : null,
            decoration: BoxDecoration(
              color: AppColors.purpleLight,
              borderRadius: 10.radiusBorder,
              boxShadow: [
                BoxShadow(
                  color: AppColors.grey200,
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: isGrid
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildIcon(),
                      Padding(
                        padding: 16.padding,
                        child: _buildName(),
                      ),
                    ],
                  )
                : Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.w, vertical: 25.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      spacing: 10,
                      children: [
                        _buildName(),
                      ],
                    ),
                  ),
          ),
          if (!isGrid)
            Positioned(
              right: 8,
              bottom: 0,
              child: _buildIcon(),
            ),
        ],
      ).onTap(onTap),
    );

  Text _buildName() => Text(
      serviceName,
      style: TextStyle(
        fontSize: 20.sp,
        fontWeight: FontWeight.w600,
      ),
      softWrap: true,
      textAlign: TextAlign.center,
    );

  Widget _buildIcon() => icon != null
        ? CustomNetworkImage(
            imageUrl: icon!,
            height: 100,
            errorWidget: (context, url, error) => Image.asset(
                AppAssets.product3d,
                height: 100,
              ),
          )
        : Image.asset(
            AppAssets.product3d,
            height: 100,
          );
}

class ServiceCardMini extends StatelessWidget {
  final String serviceName;
  final String? icon;
  final VoidCallback onTap;
  final bool isSelected;

  const ServiceCardMini({
    required this.serviceName,
    required this.onTap,
    required this.icon,
    this.isSelected = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final double iconHeight = 50.w;
    return Container(
      margin: 10.paddingOnly(right: true, bottom: true),
      padding: context.isMobile ? (15, 5).padding : (25, 10).padding,
      decoration: BoxDecoration(
        color: AppColors.purpleLight,
        borderRadius: 10.radiusBorder,
        boxShadow: [
          BoxShadow(
            color: AppColors.grey200,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
        gradient: isSelected
            ? const LinearGradient(
                colors: [
                  Color.fromARGB(255, 124, 164, 233),
                  Color.fromARGB(255, 155, 125, 237),
                ],
              )
            : null,
      ),
      child: Padding(
        padding: 10.padding,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 10,
          children: [
            icon != null
                ? CustomNetworkImage(
                    imageUrl: icon!,
                    height: iconHeight,
                    width: iconHeight,
                    errorWidget: (context, url, error) => Image.asset(
                        AppAssets.product3d,
                        height: iconHeight,
                        width: iconHeight,
                      ),
                  )
                : Image.asset(
                    AppAssets.product3d,
                    height: iconHeight,
                    width: iconHeight,
                  ),
            ShaderMask(
              blendMode: BlendMode.srcIn,
              shaderCallback: (bounds) => LinearGradient(
                  colors: isSelected
                      ? [
                          Colors.white,
                          Colors.white,
                        ]
                      : const [
                          Color(0xFF5B97FF),
                          Color(0xFF8255FF),
                        ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ).createShader(bounds),
              child: Text(
                serviceName,
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                ),

                // softWrap: true,
                textAlign: TextAlign.center,
                // overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    ).onTap(onTap);
  }
}
