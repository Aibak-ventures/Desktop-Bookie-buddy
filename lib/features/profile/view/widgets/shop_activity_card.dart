import 'package:bookie_buddy_web/features/profile/models/shop_activity_model/shop_activity_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ShopActivityCard extends StatelessWidget {
  final ShopActivityModel activity;

  const ShopActivityCard({
    super.key,
    required this.activity,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        leading: _buildActionIcon(),
        title: Text(
          activity.message,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text(
              'By: ${activity.userName}',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey.shade600,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              _formatDate(activity.createdAt),
              style: TextStyle(
                fontSize: 11,
                color: Colors.grey.shade500,
              ),
            ),
          ],
        ),
        trailing: _buildActionBadge(),
      ),
    );
  }

  Widget _buildActionIcon() {
    IconData icon;
    Color color;

    switch (activity.action.toLowerCase()) {
      case 'booking_created':
      case 'booking_add':
        icon = Icons.event_note;
        color = Colors.blue;
        break;
      case 'booking_completed':
        icon = Icons.check_circle;
        color = Colors.green;
        break;
      case 'booking_cancelled':
      case 'booking_deleted':
        icon = Icons.cancel;
        color = Colors.red;
        break;
      case 'payment_added':
        icon = Icons.payment;
        color = Colors.teal;
        break;
      case 'product_added':
        icon = Icons.add_box;
        color = Colors.purple;
        break;
      case 'product_edited':
        icon = Icons.edit;
        color = Colors.orange;
        break;
      case 'sale_created':
        icon = Icons.shopping_cart;
        color = Colors.indigo;
        break;
      case 'expense_added':
        icon = Icons.money_off;
        color = Colors.deepOrange;
        break;
      default:
        icon = Icons.info;
        color = Colors.grey;
    }

    return CircleAvatar(
      backgroundColor: color.withOpacity(0.1),
      child: Icon(icon, color: color, size: 20),
    );
  }

  Widget _buildActionBadge() {
    Color badgeColor;

    switch (activity.action.toLowerCase()) {
      case 'booking_created':
      case 'booking_add':
        badgeColor = Colors.blue;
        break;
      case 'booking_completed':
        badgeColor = Colors.green;
        break;
      case 'booking_cancelled':
      case 'booking_deleted':
        badgeColor = Colors.red;
        break;
      case 'payment_added':
        badgeColor = Colors.teal;
        break;
      case 'product_added':
      case 'product_edited':
        badgeColor = Colors.purple;
        break;
      case 'sale_created':
        badgeColor = Colors.indigo;
        break;
      case 'expense_added':
        badgeColor = Colors.deepOrange;
        break;
      default:
        badgeColor = Colors.grey;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: badgeColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: badgeColor.withOpacity(0.3)),
      ),
      child: Text(
        _formatAction(activity.action),
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w600,
          color: badgeColor,
        ),
      ),
    );
  }

  String _formatAction(String action) {
    return action
        .replaceAll('_', ' ')
        .split(' ')
        .map((word) => word.isNotEmpty
            ? '${word[0].toUpperCase()}${word.substring(1).toLowerCase()}'
            : '')
        .join(' ');
  }

  String _formatDate(String dateString) {
    try {
      // Parse the date string (format: "DD-MM-YYYY HH:MM:SS")
      final parts = dateString.split(' ');
      if (parts.length >= 2) {
        final dateParts = parts[0].split('-');
        final timeParts = parts[1].split(':');
        
        if (dateParts.length == 3 && timeParts.length >= 2) {
          final date = DateTime(
            int.parse(dateParts[2]), // year
            int.parse(dateParts[1]), // month
            int.parse(dateParts[0]), // day
            int.parse(timeParts[0]), // hour
            int.parse(timeParts[1]), // minute
          );
          
          final now = DateTime.now();
          final difference = now.difference(date);
          
          if (difference.inMinutes < 1) {
            return 'Just now';
          } else if (difference.inHours < 1) {
            return '${difference.inMinutes}m ago';
          } else if (difference.inDays < 1) {
            return '${difference.inHours}h ago';
          } else if (difference.inDays < 7) {
            return '${difference.inDays}d ago';
          } else {
            return DateFormat('MMM d, yyyy').format(date);
          }
        }
      }
      return dateString;
    } catch (e) {
      return dateString;
    }
  }
}
