import 'package:bookie_buddy_web/core/enums/enums.dart';
import 'package:bookie_buddy_web/core/extensions/context_extensions.dart';
import 'package:bookie_buddy_web/core/models/available_shop_model/available_shop_model.dart';
import 'package:bookie_buddy_web/core/models/user_model/user_model.dart';
import 'package:bookie_buddy_web/core/view_model/user_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:developer' as dev;

enum BookingTabType { booking, sales, customWork }

class NewBookingAppBar extends StatefulWidget {
  final BookingTabType selectedTab;
  final Function(BookingTabType) onTabChanged;
  final VoidCallback? onBack;

  const NewBookingAppBar({
    super.key,
    required this.selectedTab,
    required this.onTabChanged,
    this.onBack,
  });

  @override
  State<NewBookingAppBar> createState() => _NewBookingAppBarState();
}

class _NewBookingAppBarState extends State<NewBookingAppBar> {
  List<AvailableShopModel> _availableShops = [];
  bool _isLoadingShops = false;

  @override
  void initState() {
    super.initState();
    _loadAvailableShops();
  }

  Future<void> _loadAvailableShops() async {
    setState(() {
      _isLoadingShops = true;
    });

    try {
      final userCubit = context.read<UserCubit>();
      final shopsData = await userCubit.fetchAvailableShops();

      if (mounted) {
        setState(() {
          _availableShops = shopsData
              .map((json) =>
                  AvailableShopModel.fromJson(json as Map<String, dynamic>))
              .toList();
          _isLoadingShops = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoadingShops = false;
        });
      }
    }
  }

  Future<void> _switchShop(int shopId) async {
    try {
      final userCubit = context.read<UserCubit>();

      // Show loading indicator
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(
          child: CircularProgressIndicator(),
        ),
      );

      // Switch shop
      await userCubit.switchShop(
          shopId, null); // TODO: Pass FCM token if needed

      if (mounted) {
        Navigator.of(context).pop(); // Close loading dialog

        // Show success message
        context.showSnackBar('Shop switched successfully');

        // Reload page to refresh data
        // TODO: Implement proper page reload or data refresh
      }
    } catch (e) {
      if (mounted) {
        Navigator.of(context).pop(); // Close loading dialog

        context.showSnackBar(
          'Failed to switch shop: $e',
          isError: true,
        );
      }
    }
  }

  void _showShopSelector(UserModel user) {
    if (_availableShops.isEmpty) return;

    showMenu(
      context: context,
      position: RelativeRect.fromLTRB(
        MediaQuery.of(context).size.width - 300,
        56,
        16,
        0,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      items: _availableShops.map((shop) {
        final isCurrentShop = shop.id == user.shopDetails.id;
        return PopupMenuItem(
          value: shop.id,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
            child: Row(
              children: [
                // Shop image
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.grey.shade200,
                    image: shop.img != null
                        ? DecorationImage(
                            image: NetworkImage(shop.img!),
                            fit: BoxFit.cover,
                          )
                        : null,
                  ),
                  child: shop.img == null
                      ? Icon(Icons.store, color: Colors.grey.shade400, size: 20)
                      : null,
                ),
                const SizedBox(width: 12),
                // Shop details
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        shop.name,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight:
                              isCurrentShop ? FontWeight.w600 : FontWeight.w500,
                          color: isCurrentShop
                              ? const AppColors.primaryDark
                              : Colors.black87,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      if (shop.address.isNotEmpty) ...[
                        const SizedBox(height: 2),
                        Text(
                          shop.address,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey.shade600,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ],
                  ),
                ),
                if (isCurrentShop)
                  const Icon(
                    Icons.check_circle,
                    color: AppColors.primaryDark,
                    size: 20,
                  ),
              ],
            ),
          ),
        );
      }).toList(),
    ).then((selectedShopId) {
      if (selectedShopId != null && selectedShopId != user.shopDetails.id) {
        _switchShop(selectedShopId as int);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCubit, UserModel?>(
      builder: (context, user) {
        dev.log(
            '🔍 User role: ${user?.role?.value}, haveMultipleShops: ${user?.haveMultipleShops}');
        final shouldShowDropdown = true;
        dev.log('🔍 Should show dropdown: $shouldShowDropdown');

        return Container(
          height: 56,
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                // Back button
                if (widget.onBack != null) ...[
                  InkWell(
                    onTap: widget.onBack,
                    borderRadius: BorderRadius.circular(4),
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Icon(
                        Icons.arrow_back_ios,
                        size: 16,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                ],
                // Tabs
                _buildTabs(),
                const Spacer(),
                // Shop selector
                if (user != null) _buildShopSelector(user, shouldShowDropdown),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildTabs() {
    return Container(
      height: 36,
      decoration: BoxDecoration(
        color: const AppColors.surfaceGrey,
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.all(2),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildTab('Booking', BookingTabType.booking),
          _buildTab('Sales', BookingTabType.sales),
          // _buildTab('Custom work', BookingTabType.customWork),
        ],
      ),
    );
  }

  Widget _buildTab(String label, BookingTabType type) {
    final isSelected = widget.selectedTab == type;
    return GestureDetector(
      onTap: () => widget.onTabChanged(type),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        decoration: BoxDecoration(
          color: isSelected ? const AppColors.primaryDark : Colors.transparent,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.grey.shade700,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
            fontSize: 13,
          ),
        ),
      ),
    );
  }

  Widget _buildShopSelector(UserModel user, bool showDropdown) {
    return InkWell(
      onTap: showDropdown ? () => _showShopSelector(user) : null,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Shop image
            Container(
              width: 28,
              height: 28,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                color: Colors.grey.shade200,
                image: user.shopDetails.image != null
                    ? DecorationImage(
                        image: NetworkImage(user.shopDetails.image!),
                        fit: BoxFit.cover,
                      )
                    : null,
              ),
              child: user.shopDetails.image == null
                  ? Icon(Icons.store, color: Colors.grey.shade400, size: 16)
                  : null,
            ),
            const SizedBox(width: 8),
            // Shop name and location
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  user.shopDetails.name,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  user.shopDetails.place ?? user.shopDetails.address,
                  style: TextStyle(
                    fontSize: 11,
                    color: Colors.grey.shade600,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
            if (showDropdown) ...[
              const SizedBox(width: 8),
              Icon(
                Icons.keyboard_arrow_down,
                size: 20,
                color: Colors.grey.shade600,
              ),
            ],
          ],
        ),
      ),
    );
  }
}

