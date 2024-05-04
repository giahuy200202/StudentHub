import 'package:flutter_riverpod/flutter_riverpod.dart';

class Notification {
  final String id;
  final String notificationType;
  final String notificationContent;
  final String senderName;
  final String createdAt;

  Notification({
    required this.id,
    required this.notificationType,
    required this.notificationContent,
    required this.senderName,
    required this.createdAt,
  });

  Notification.fromJson(Map<dynamic, dynamic> json)
      : id = json['id'],
        notificationType = json['notificationType'],
        notificationContent = json['notificationContent'],
        senderName = json['senderName'],
        createdAt = json['createdAt'];

  Map<dynamic, dynamic> toJson() {
    return {
      'id': id,
      'notificationType': notificationType,
      'notificationContent': notificationContent,
      'senderName': senderName,
      'createdAt': createdAt,
    };
  }
}

class NotificationNotifier extends StateNotifier<List<Notification>> {
  NotificationNotifier() : super([]);

  void pushNotificationData(
    String id,
    String notificationType,
    String notificationContent,
    String senderName,
    String createdAt,
  ) {
    state = [
      ...state,
      Notification(
        id: id,
        notificationType: notificationType,
        notificationContent: notificationContent,
        senderName: senderName,
        createdAt: createdAt,
      )
    ];
  }

  void clearNotificationData() {
    state = [];
  }
}

final notificationProvider = StateNotifierProvider<NotificationNotifier, List<Notification>>((ref) => NotificationNotifier());
