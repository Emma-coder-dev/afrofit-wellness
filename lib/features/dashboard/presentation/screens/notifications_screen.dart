import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import '../../../../core/theme/color_palette.dart';
import '../../../../shared/widgets/custom_app_bar.dart';
import '../../../../shared/widgets/empty_state.dart';
import '../../../../shared/services/local_storage_service.dart';
import '../../data/models/notification_model.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  List<NotificationModel> notifications = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadNotifications();
  }

  Future<void> _loadNotifications() async {
    setState(() => isLoading = true);

    try {
      // Load notifications from storage
      final notifData = await LocalStorageService.getDailyLog('notifications');
      
      if (notifData != null && notifData['items'] != null) {
        final items = notifData['items'] as List<dynamic>;
        notifications = items
            .map((item) => NotificationModel.fromJson(item as Map<String, dynamic>))
            .toList();
        
        // Sort by timestamp (newest first)
        notifications.sort((a, b) => b.timestamp.compareTo(a.timestamp));
      } else {
        // Generate sample notifications for demo
        notifications = _generateSampleNotifications();
        await _saveNotifications();
      }

      setState(() => isLoading = false);
    } catch (e) {
      setState(() => isLoading = false);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error loading notifications: $e')),
        );
      }
    }
  }

  List<NotificationModel> _generateSampleNotifications() {
    final now = DateTime.now();
    return [
      NotificationModel(
        id: const Uuid().v4(),
        title: '🎉 Welcome to AfroFit!',
        message: 'Start your fitness journey today. Log your first meal or workout!',
        type: 'achievement',
        timestamp: now.subtract(const Duration(minutes: 5)),
      ),
      NotificationModel(
        id: const Uuid().v4(),
        title: '💪 Time for Your Workout',
        message: 'Your personalized workout is ready. Let\'s get moving!',
        type: 'workout',
        timestamp: now.subtract(const Duration(hours: 2)),
      ),
      NotificationModel(
        id: const Uuid().v4(),
        title: '🍽️ Don\'t Forget to Log Your Meals',
        message: 'Track your nutrition to stay on target with your goals.',
        type: 'meal',
        timestamp: now.subtract(const Duration(hours: 4)),
      ),
      NotificationModel(
        id: const Uuid().v4(),
        title: '💧 Stay Hydrated',
        message: 'Remember to drink water throughout the day. Tap to log water intake.',
        type: 'progress',
        timestamp: now.subtract(const Duration(hours: 6)),
      ),
      NotificationModel(
        id: const Uuid().v4(),
        title: '📊 Weekly Progress Update',
        message: 'Great week! You completed 4 workouts and stayed within your calorie goals.',
        type: 'progress',
        timestamp: now.subtract(const Duration(days: 1)),
      ),
    ];
  }

  Future<void> _saveNotifications() async {
    try {
      final notifData = {
        'items': notifications.map((n) => n.toJson()).toList(),
      };
      await LocalStorageService.saveDailyLog('notifications', notifData);
    } catch (e) {
      // Silent fail
    }
  }

  Future<void> _markAsRead(NotificationModel notification) async {
    setState(() {
      final index = notifications.indexOf(notification);
      if (index != -1) {
        notifications[index] = notification.copyWith(isRead: true);
      }
    });
    await _saveNotifications();
  }

  Future<void> _markAllAsRead() async {
    setState(() {
      notifications = notifications
          .map((n) => n.copyWith(isRead: true))
          .toList();
    });
    await _saveNotifications();
    
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('All notifications marked as read')),
      );
    }
  }

  Future<void> _deleteNotification(NotificationModel notification) async {
    setState(() {
      notifications.remove(notification);
    });
    await _saveNotifications();
    
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Notification deleted')),
      );
    }
  }

  Future<void> _clearAll() async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Clear All Notifications?'),
        content: const Text('This will delete all notifications permanently.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            style: TextButton.styleFrom(foregroundColor: ColorPalette.error),
            child: const Text('Clear All'),
          ),
        ],
      ),
    );

    if (confirm == true) {
      setState(() {
        notifications.clear();
      });
      await _saveNotifications();
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('All notifications cleared')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    final unreadCount = notifications.where((n) => !n.isRead).length;

    return Scaffold(
      appBar: CustomAppBar(
        title: 'Notifications',
        showBackButton: true,
        actions: [
          if (notifications.isNotEmpty) ...[
            if (unreadCount > 0)
              TextButton(
                onPressed: _markAllAsRead,
                child: const Text('Mark all read'),
              ),
            PopupMenuButton<String>(
              onSelected: (value) {
                if (value == 'clear') {
                  _clearAll();
                }
              },
              itemBuilder: (context) => [
                const PopupMenuItem(
                  value: 'clear',
                  child: Row(
                    children: [
                      Icon(Icons.delete_outline, color: ColorPalette.error),
                      SizedBox(width: 8),
                      Text('Clear all'),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
      body: notifications.isEmpty
          ? EmptyState(
              icon: Icons.notifications_off_outlined,
              title: 'No Notifications',
              message: 'You\'re all caught up! We\'ll notify you about important updates.',
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: notifications.length,
              itemBuilder: (context, index) {
                final notification = notifications[index];
                return _NotificationCard(
                  notification: notification,
                  onTap: () => _markAsRead(notification),
                  onDelete: () => _deleteNotification(notification),
                );
              },
            ),
    );
  }
}

class _NotificationCard extends StatelessWidget {
  final NotificationModel notification;
  final VoidCallback onTap;
  final VoidCallback onDelete;

  const _NotificationCard({
    required this.notification,
    required this.onTap,
    required this.onDelete,
  });

  IconData _getIconForType(String type) {
    switch (type) {
      case 'workout':
        return Icons.fitness_center;
      case 'meal':
        return Icons.restaurant;
      case 'progress':
        return Icons.trending_up;
      case 'achievement':
        return Icons.emoji_events;
      default:
        return Icons.notifications;
    }
  }

  Color _getColorForType(String type) {
    switch (type) {
      case 'workout':
        return ColorPalette.secondary;
      case 'meal':
        return ColorPalette.primary;
      case 'progress':
        return ColorPalette.accent;
      case 'achievement':
        return ColorPalette.warning;
      default:
        return ColorPalette.primary;
    }
  }

  String _getTimeAgo(DateTime timestamp) {
    final now = DateTime.now();
    final difference = now.difference(timestamp);

    if (difference.inDays > 7) {
      return '${timestamp.day}/${timestamp.month}/${timestamp.year}';
    } else if (difference.inDays > 0) {
      return '${difference.inDays}d ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours}h ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes}m ago';
    } else {
      return 'Just now';
    }
  }

  @override
  Widget build(BuildContext context) {
    final color = _getColorForType(notification.type);

    return Dismissible(
      key: Key(notification.id),
      direction: DismissDirection.endToStart,
      background: Container(
        margin: const EdgeInsets.only(bottom: 12),
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        decoration: BoxDecoration(
          color: ColorPalette.error,
          borderRadius: BorderRadius.circular(12),
        ),
        child: const Icon(
          Icons.delete_outline,
          color: Colors.white,
          size: 28,
        ),
      ),
      onDismissed: (_) => onDelete(),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: notification.isRead 
              ? Colors.white 
              : color.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: notification.isRead 
                ? Colors.grey.shade200 
                : color.withValues(alpha: 0.3),
            width: notification.isRead ? 1 : 2,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.03),
              blurRadius: 5,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(12),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Icon
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: color.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      _getIconForType(notification.type),
                      color: color,
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 16),
                  
                  // Content
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                notification.title,
                                style: TextStyle(
                                  fontWeight: notification.isRead 
                                      ? FontWeight.w600 
                                      : FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                            if (!notification.isRead)
                              Container(
                                width: 8,
                                height: 8,
                                decoration: BoxDecoration(
                                  color: color,
                                  shape: BoxShape.circle,
                                ),
                              ),
                          ],
                        ),
                        const SizedBox(height: 6),
                        Text(
                          notification.message,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey.shade700,
                            height: 1.4,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          _getTimeAgo(notification.timestamp),
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey.shade500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}