import 'package:bookie_buddy_web/core/common/entities/user_entity/user_entity.dart';
import 'package:bookie_buddy_web/features/auth/presentation/bloc/user_cubit/user_cubit.dart';
import 'package:bookie_buddy_web/features/shop/domain/entities/shop_entity/shop_entity.dart';
import 'package:bookie_buddy_web/features/shop/presentation/bloc/shop_list_bloc/shop_list_bloc.dart';
import 'package:bookie_buddy_web/utils/extensions/context_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Shows shop selector menu and handles shop switching
Future<void> showShopSelector(BuildContext context, UserEntity user) async {
  if (!context.mounted) return;

  // Capture all context-dependent references BEFORE any await.
  // The calling widget's context becomes stale after ShopListBloc emits
  // its loaded state, which triggers a BlocBuilder rebuild.
  final bloc = context.read<ShopListBloc>();
  final userCubit = context.read<UserCubit>();
  final navigator = Navigator.of(context, rootNavigator: true);

  // Capture the button's screen position before any async work.
  // After the dialog closes, the original render box may be detached
  // due to BlocBuilder rebuilding, so we store absolute coordinates now.
  final renderBox = context.findRenderObject() as RenderBox?;
  final buttonPosition = renderBox?.localToGlobal(Offset.zero);
  final buttonSize = renderBox?.size ?? Size.zero;

  bloc.add(ShopListEvent.loadShops());

  final shops = await showDialog<List<ShopEntity>?>(
    context: context,
    barrierDismissible: false,
    builder: (_) => BlocListener<ShopListBloc, ShopListState>(
      listener: (ctx, state) {
        state.maybeWhen(
          orElse: () {},
          loaded: (shops, currentShopId) => Navigator.pop(ctx, shops),
          error: (error) {
            Navigator.pop(ctx);
            ctx.showSnackBar(error, isError: true);
          },
        );
      },
      child: const Center(child: CircularProgressIndicator()),
    ),
  );

  if (shops == null || shops.isEmpty) return;

  // Use stored absolute position (render box may be detached after rebuild).
  final dx = buttonPosition?.dx ?? 0;
  final dy = buttonPosition?.dy ?? 0;

  final selectedShopId = await showMenu<int>(
    context: navigator.context,
    position: RelativeRect.fromLTRB(
      dx,
      dy + buttonSize.height + 8,
      dx + 300,
      dy,
    ),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    items: shops.map((shop) {
      final isCurrentShop = shop.id == user.shopDetails.id;
      return PopupMenuItem<int>(
        value: shop.id,
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.grey.shade200,
                image: shop.image != null
                    ? DecorationImage(
                        image: NetworkImage(shop.image!),
                        fit: BoxFit.cover,
                      )
                    : null,
              ),
              child: shop.image == null
                  ? Icon(Icons.store, color: Colors.grey.shade400, size: 20)
                  : null,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    shop.name,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  if (shop.address.isNotEmpty)
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
              ),
            ),
            if (isCurrentShop)
              Icon(Icons.check_circle, color: Colors.green.shade600, size: 20),
          ],
        ),
      );
    }).toList(),
  );

  if (selectedShopId == null || selectedShopId == user.shopDetails.id) return;

  navigator.push(
    PageRouteBuilder(
      opaque: false,
      barrierDismissible: false,
      pageBuilder: (_, __, ___) =>
          const Center(child: CircularProgressIndicator()),
    ),
  );
  try {
    bloc.add(
      ShopListEvent.changeAccount(
        shops.firstWhere((s) => s.id == selectedShopId),
      ),
    );
    await userCubit.switchShop(selectedShopId, null);
    navigator.pop();
    if (navigator.context.mounted) {
      navigator.context.showSnackBar('Shop switched successfully');
    }
  } catch (e) {
    navigator.pop();
    if (navigator.context.mounted) {
      navigator.context.showSnackBar(
        'Failed to switch shop: $e',
        isError: true,
      );
    }
  }
}

/// Reusable shop switcher button for expanded sidebar
class ShopSwitcherButtonExpanded extends StatelessWidget {
  const ShopSwitcherButtonExpanded({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCubit, UserEntity?>(
      builder: (context, user) {
        if (user == null) return const SizedBox.shrink();
        final hasMultipleShops = user.haveMultipleShops;
        if (!hasMultipleShops) return const SizedBox.shrink();

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () => showShopSelector(context, user),
              borderRadius: BorderRadius.circular(12),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFF6C5CE7).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: const Color(0xFF6C5CE7).withValues(alpha: 0.3),
                    width: 1,
                  ),
                ),
                child: Row(
                  children: [
                    // Shop logo
                    Container(
                      width: 32,
                      height: 32,
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
                          ? Icon(
                              Icons.store,
                              color: Colors.grey.shade400,
                              size: 18,
                            )
                          : null,
                    ),
                    const SizedBox(width: 12),
                    // Shop name and location
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            user.shopDetails.name,
                            style: const TextStyle(
                              color: Color(0xFF6C5CE7),
                              fontWeight: FontWeight.w600,
                              fontSize: 13,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 2),
                          Text(
                            user.shopDetails.place ?? user.shopDetails.address,
                            style: TextStyle(
                              color: const Color(
                                0xFF6C5CE7,
                              ).withValues(alpha: 0.7),
                              fontSize: 11,
                              fontWeight: FontWeight.w500,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                    Icon(
                      Icons.swap_horiz_rounded,
                      color: const Color(0xFF6C5CE7),
                      size: 20,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

/// Reusable shop switcher button for collapsed sidebar
class ShopSwitcherButtonCollapsed extends StatelessWidget {
  const ShopSwitcherButtonCollapsed({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCubit, UserEntity?>(
      builder: (context, user) {
        if (user == null) return const SizedBox.shrink();
        final hasMultipleShops = user.haveMultipleShops;
        if (!hasMultipleShops) return const SizedBox.shrink();

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () => showShopSelector(context, user),
              borderRadius: BorderRadius.circular(12),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 14),
                decoration: BoxDecoration(
                  color: const Color(0xFF6C5CE7).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: const Color(0xFF6C5CE7).withValues(alpha: 0.3),
                    width: 1,
                  ),
                ),
                child: Icon(
                  Icons.swap_horiz_rounded,
                  color: const Color(0xFF6C5CE7),
                  size: 20,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
