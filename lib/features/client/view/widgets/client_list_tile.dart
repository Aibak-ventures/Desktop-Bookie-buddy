import 'package:bookie_buddy_web/utils/extensions/number_extensions.dart';
import 'package:bookie_buddy_web/core/theme/app_colors.dart';
import 'package:bookie_buddy_web/features/add_booking/models/client_model/client_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class ClientListTile extends StatelessWidget {
  final ClientModel client;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final bool isGrid;

  const ClientListTile({
    super.key,
    required this.client,
    required this.onEdit,
    required this.onDelete,
    required this.isGrid,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: 12.radiusBorder,
        border: Border.all(color: AppColors.grey200),
        boxShadow: [
          BoxShadow(
            color: AppColors.grey200,
            blurRadius: 4,
          ),
        ],
      ),
      padding: 12.padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top row: Icon + Name + Menu
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 44.w,
                height: 44.w,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: 8.radiusBorder,
                ),
                child: Icon(
                  Icons.person_rounded,
                  color: AppColors.white,
                  size: 24.sp,
                ),
              ),
              12.width,
              Expanded(
                child: Text(
                  client.name,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              PopupMenuButton<String>(
                onSelected: (value) {
                  if (value == 'edit') onEdit();
                  if (value == 'delete') onDelete();
                },
                itemBuilder: (context) => [
                  const PopupMenuItem(
                    value: 'edit',
                    child: const Row(
                      spacing: 5,
                      children: [
                        Icon(
                          Icons.edit_outlined,
                          color: AppColors.purple,
                        ),
                        Text('Edit'),
                      ],
                    ),
                  ),
                  const PopupMenuItem(
                    value: 'delete',
                    child: const Row(
                      spacing: 5,
                      children: [
                        Icon(
                          Icons.delete_outline,
                          color: AppColors.redTomato,
                        ),
                        Text('Delete'),
                      ],
                    ),
                  ),
                ],
                padding: EdgeInsets.zero,
                child: Icon(Icons.more_vert_rounded, size: 20.sp),
              ),
            ],
          ),
          8.height,

          // Phone 1 & 2
          // isGrid
          //     ? Column(
          //         children: [
          //           _buildPhone(
          //             context: context,
          //             phoneNumber: client.phone1,
          //             label: 'Phone 1',
          //           ),
          //           if (client.phone2 != null &&
          //               client.phone2!.toString().isNotEmpty) ...[
          //             8.width,
          //             _buildPhone(
          //               context: context,
          //               phoneNumber: client.phone2!,
          //               label: 'Phone 2',
          //             ),
          //           ],
          //         ],
          //       )
          //     :
          Row(
            children: [
              Expanded(
                child: _buildPhone(
                  context: context,
                  phoneNumber: client.phone1,
                  label: 'Phone 1',
                ),
              ),
              if (client.phone2 != null &&
                  client.phone2!.toString().isNotEmpty) ...[
                8.width,
                Expanded(
                  child: _buildPhone(
                    context: context,
                    phoneNumber: client.phone2!,
                    label: 'Phone 2',
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPhone({
    required BuildContext context,
    required int phoneNumber,
    required String label,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 14),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: 10.radiusBorder,
        border: Border.all(color: AppColors.grey200, width: 1),
      ),
      child: Row(
        children: [
          Icon(
            Icons.phone_rounded,
            size: 18.sp,
            color: AppColors.grey600,
          ),
          8.width,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                    color: AppColors.grey600,
                  ),
                ),
                2.height,
                Text(
                  phoneNumber.toString(),
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey.shade700,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ClientListTileShimmer extends StatelessWidget {
  const ClientListTileShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: 12.radiusBorder,
        border: Border.all(color: AppColors.grey200),
      ),
      padding: 12.padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 44.w,
                height: 44.w,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: 8.radiusBorder,
                ),
                child: Icon(
                  Icons.person_rounded,
                  color: AppColors.white,
                  size: 24.sp,
                ),
              ),
              12.width,
              Expanded(child: shimmerBox(width: double.infinity, height: 16)),
              8.width,
              shimmerBox(width: 20.sp, height: 20.sp, radius: 4),
            ],
          ),
          8.height,
          Row(
            children: [
              Expanded(child: shimmerBox(height: 58, radius: 10)),
              8.width,
              Expanded(child: shimmerBox(height: 58, radius: 10)),
            ],
          ),
        ],
      ),
    );
  }

  Widget shimmerBox({double? width, double? height, int? radius}) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: radius == null ? null : radius.radiusBorder,
        ),
      ),
    );
  }
}
