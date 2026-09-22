import 'package:bookie_buddy_web/core/common/entities/user_entity/user_entity.dart';
import 'package:bookie_buddy_web/features/auth/presentation/bloc/user_cubit/user_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Sidebar avatar, with the user's name alongside it when [expanded].
class SidebarProfileHeader extends StatelessWidget {
  final bool expanded;

  const SidebarProfileHeader({super.key, required this.expanded});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCubit, UserEntity?>(
      builder: (context, user) {
        final userName = user?.firstName ?? 'User';
        final firstLetter = userName.isNotEmpty
            ? userName[0].toUpperCase()
            : 'U';
        final avatar = _buildAvatar(firstLetter, expanded ? 48 : 40);

        if (!expanded) return avatar;

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          child: Row(
            children: [
              avatar,
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  userName,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF2D3436),
                    letterSpacing: 0.3,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildAvatar(String letter, double size) {
    return Container(
      width: size,
      height: size,
      padding: const EdgeInsets.all(2),
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF6C5CE7), Color(0xFF00B4DB)],
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white, width: 2),
          color: Colors.white,
        ),
        child: Center(
          child: Text(
            letter,
            style: TextStyle(
              fontSize: size * 0.4,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF6C5CE7),
            ),
          ),
        ),
      ),
    );
  }
}
