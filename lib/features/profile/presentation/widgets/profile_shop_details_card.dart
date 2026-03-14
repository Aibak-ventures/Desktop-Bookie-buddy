import 'package:bookie_buddy_web/utils/extensions/number_extensions.dart';
import 'package:bookie_buddy_web/core/models/user_model/user_model.dart';
import 'package:bookie_buddy_web/core/theme/app_colors.dart';
import 'package:bookie_buddy_web/core/ui/widgets/custom_network_image.dart';
import 'package:bookie_buddy_web/core/view_model/user_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileShopDetailsCard extends StatelessWidget {
  const ProfileShopDetailsCard({super.key});

  @override
  Widget build(BuildContext context) {
    final height = 150.0.h;
    return SizedBox(
      height: 250,
      child: BlocBuilder<UserCubit, UserModel?>(
        builder: (context, user) {
          final profile = user?.shopDetails.image;
          final businessName = user?.shopDetails.name ?? 'Business name';
          final address = user?.shopDetails.address ?? 'Address: Not Available';
          return Stack(
            children: [
              // Main container with clipped background circles
              Container(
                margin: 16.padding,
                child: ClipRRect(
                  borderRadius: 20.radiusBorder,
                  child: Stack(
                    children: [
                      // Background circles - now clipped within the container
                      Positioned(
                        left: 30,
                        bottom: -70,
                        child: Container(
                          height: height,
                          width: height,
                          decoration: const BoxDecoration(
                            color: Color.fromARGB(255, 228, 224, 224),
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                      Positioned(
                        right: -70,
                        top: -40,
                        child: Container(
                          height: height,
                          width: height,
                          decoration: const BoxDecoration(
                            color: Color.fromARGB(255, 228, 224, 224),
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                      // Main content container
                      Container(
                        padding: 20.padding,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              const Color(0xFF4C0FFF).withValues(alpha: 0.4),
                              const Color(0xFF015DFF).withValues(alpha: 0.4),
                            ],
                            stops: const [0.0, 1.0],
                          ),
                          borderRadius: 20.radiusBorder,
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFF6C5CE7)
                                  .withValues(alpha: 0.3),
                              blurRadius: 20,
                              offset: const Offset(0, 8),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            // "My profile" label
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'My profile',
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  color: AppColors.black,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            16.height,
                            // Profile content
                            Row(
                              children: [
                                // Profile Picture/Logo Section

                                Container(
                                  width: 100,
                                  height: 100,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                        color:
                                            Colors.black.withValues(alpha: 0.1),
                                        blurRadius: 10,
                                        offset: const Offset(0, 4),
                                      ),
                                    ],
                                  ),
                                  child: ClipOval(
                                    child: profile == null
                                        ? _buildDefaultAvatar()
                                        : CustomNetworkImage(
                                            filterQuality: FilterQuality.high,
                                            imageUrl: profile,
                                            errorWidget: (_, url, error) {
                                              return _buildDefaultAvatar();
                                            },
                                          ),
                                    // OverflowBox(
                                    //     alignment: Alignment.center,
                                    //     minWidth: 0,
                                    //     minHeight: 0,
                                    //     maxWidth: 130,
                                    //     maxHeight: 130,
                                    //     child: FittedBox(
                                    //       alignment: Alignment.center,
                                    //       fit: BoxFit.cover,
                                    //       child: CustomNetworkImage(
                                    //         filterQuality:
                                    //             FilterQuality.high,
                                    //         imageUrl: profile,
                                    //         errorWidget: (_, url, error) {
                                    //           return _buildDefaultAvatar();
                                    //         },
                                    //       ),
                                    //     ),
                                    //   ),
                                  ),
                                ),

                                20.width,

                                // Text Information Section
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      // Business/User Name
                                      Text(
                                        businessName,
                                        style: TextStyle(
                                          fontSize: 22.sp,
                                          fontWeight: FontWeight.bold,
                                          color: AppColors.black,
                                        ),
                                      ),

                                      4.height,

                                      // Location
                                      Text(
                                        address,
                                        style: TextStyle(
                                          fontSize: 14.sp,
                                          color: const Color(0xFF444444),
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildDefaultAvatar() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[300],
        shape: BoxShape.circle,
      ),
      child: Icon(
        Icons.person,
        size: 50.sp,
        color: Colors.grey[600],
      ),
    );
  }
}

// Shimmer version for loading state
class ProfileCardShimmer extends StatelessWidget {
  const ProfileCardShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: 16.padding,
      padding: 20.padding,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.grey[300]!,
            Colors.grey[200]!,
            Colors.grey[300]!,
          ],
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          // Profile Picture Shimmer
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: Colors.grey[400],
              shape: BoxShape.circle,
            ),
          ),

          const SizedBox(width: 20),

          // Text Information Shimmer
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 14,
                  width: 80,
                  decoration: BoxDecoration(
                    color: Colors.grey[400],
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                const SizedBox(height: 12),
                Container(
                  height: 22,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.grey[400],
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  height: 14,
                  width: 120,
                  decoration: BoxDecoration(
                    color: Colors.grey[400],
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
