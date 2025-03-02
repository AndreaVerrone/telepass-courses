import 'package:flutter/material.dart';
import 'package:telepass_courses/constants.dart';

enum NotificationType {
  normal(primaryColorDark),
  warning(Colors.red),
  success(Colors.green);

  final Color titleColor;

  const NotificationType(this.titleColor);
}

class NotificationData {
  final String title;
  final String description;
  final DateTime date;
  final NotificationType type;

  NotificationData({
    required this.title,
    required this.description,
    required this.date,
    required this.type,
  });
}

class NotificationService {
  final List<NotificationData> _notifications = [
    NotificationData(
      title: "Corso in scadenza",
      description:
          "Progettazione e sviluppo di sistemi di pedaggio elettronico",
      date: DateTime.now(),
      type: NotificationType.warning,
    ),
    NotificationData(
      title: "Badge in arrivo",
      description: "Complimenti, hai completato 25 corsi!",
      date: DateTime.now(),
      type: NotificationType.success,
    ),
    NotificationData(
      title: "Nuovo corso caricato",
      description:
          "Progettazione e sviluppo di sistemi di pedaggio elettronico",
      date: DateTime.now().subtract(const Duration(days: 2)),
      type: NotificationType.normal,
    ),
    NotificationData(
      title: "Nuovo documento caricato",
      description: "Come modificare la targa associata al dispositivo Telepass",
      date: DateTime.now().subtract(const Duration(days: 2)),
      type: NotificationType.normal,
    ),
    NotificationData(
      title: "Corso in scadenza",
      description:
          "Progettazione e sviluppo di sistemi di pedaggio elettronico",
      date: DateTime.now().subtract(const Duration(days: 2)),
      type: NotificationType.warning,
    ),
    NotificationData(
      title: "Corso in scadenza",
      description:
          "Progettazione e sviluppo di sistemi di pedaggio elettronico",
      date: DateTime.now().subtract(const Duration(days: 20)),
      type: NotificationType.warning,
    ),
  ];

  List<NotificationData> getTodayNotifications() {
    return _notifications
        .where(
          (notification) =>
              DateTime.now().difference(notification.date).inDays < 1,
        )
        .toList();
  }

  List<NotificationData> getThisWeekNotifications() {
    return _notifications.where((notification) {
      final difference = DateTime.now().difference(notification.date).inDays;
      return difference >= 1 && difference < 7;
    }).toList();
  }
}
