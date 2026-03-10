import 'package:bookie_buddy_web/utils/extensions/context_extensions.dart';
import 'package:bookie_buddy_web/utils/extensions/number_extensions.dart';
import 'package:bookie_buddy_web/core/theme/app_colors.dart';
import 'package:bookie_buddy_web/features/profile/view_model/contact_support_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class ContactAndSupportScreen extends StatelessWidget {
  const ContactAndSupportScreen({super.key});
  final viewModel = const ContactSupportViewModel();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contact & Support'),
      ),
      body: Padding(
        padding: 16.padding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _CustomTile(
              icon: const Icon(
                Icons.email,
                color: AppColors.purple,
                size: 30,
              ),
              title: 'Connect via Email',
              onTap: () async {
                try {
                  await viewModel.launchEmail();
                } catch (e) {
                  context.showSnackBar(
                    'Failed to launch email app',
                    isError: true,
                  );
                }
              },
            ),
            _CustomTile(
              icon: SvgPicture.asset(
                'assets/icons/whatsapp.svg',
                colorFilter: const ColorFilter.mode(
                  Color(0xFF25D366), // WhatsApp green color
                  BlendMode.srcIn,
                ),
                semanticsLabel: 'WhatsApp Icon',
                width: 30,
                height: 30,
              ),
              title: 'Connect via WhatsApp',
              onTap: viewModel.launchWhatsApp,
            ),
          ],
        ),
      ),
    );
  }
}

class _CustomTile extends StatelessWidget {
  const _CustomTile({
    required this.icon,
    required this.title,
    this.onTap,
  });
  final Widget icon;
  final String title;
  final VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: 10.padding,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: 10.radiusBorder,
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
            blurRadius: 5,
          ),
        ],
      ),
      child: ListTile(
        leading: icon,
        title: Text(
          title,
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
        onTap: onTap,
      ),
    );
  }
}
