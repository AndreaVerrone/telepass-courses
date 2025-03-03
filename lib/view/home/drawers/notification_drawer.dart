import 'package:flutter/material.dart';
import 'package:telepass_courses/constants.dart';
import 'package:telepass_courses/extensions.dart';
import 'package:telepass_courses/services/notification_service.dart';
import 'package:telepass_courses/view/components/separator.dart';

class NotificationDrawer extends StatelessWidget {
  const NotificationDrawer({super.key});

  static const _horizontalPadding = EdgeInsets.symmetric(horizontal: 60);

  @override
  Widget build(BuildContext context) {
    final todayNotifications = NotificationService().getTodayNotifications();
    final weeklyyNotifications =
        NotificationService().getThisWeekNotifications();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: _horizontalPadding,
          child: Text(
            "Notifiche",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
        const Separator(32),
        Expanded(
          child: ListView(
            children: [
              if (todayNotifications.isEmpty && weeklyyNotifications.isEmpty)
                const Text(
                  "Non hai nesuna notifica da vedere",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              if (todayNotifications.isNotEmpty)
                NotificationListTile(
                  title: "Oggi",
                  notifications: todayNotifications,
                  padding: _horizontalPadding,
                ),
              if (weeklyyNotifications.isNotEmpty) ...[
                const Separator(40),
                const Divider(color: primaryColor),
                const Separator(40),
                NotificationListTile(
                  title: "Questa settimana",
                  notifications: weeklyyNotifications,
                  padding: _horizontalPadding,
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}

class NotificationTile extends StatelessWidget {
  final NotificationData notification;
  const NotificationTile({super.key, required this.notification});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                notification.title.toUpperCase(),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: notification.type.titleColor,
                ),
              ),
              const Separator(4),
              Text(notification.description),
            ],
          ),
        ),
        const Separator(12),
        const Icon(Icons.arrow_forward_ios_rounded),
      ],
    );
  }
}

class NotificationListTile extends StatelessWidget {
  final String title;
  final List<NotificationData> notifications;
  final EdgeInsetsGeometry padding;

  const NotificationListTile({
    super.key,
    required this.title,
    required this.notifications,
    required this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const Separator(20),
          ...notifications
              .map<Widget>(
                (notification) => NotificationTile(notification: notification),
              )
              .interleave(const Divider(color: primaryColor))
              .interleave(const Separator(8)),
        ],
      ),
    );
  }
}
