import 'package:flutter_riverpod/flutter_riverpod.dart';

class Notification {
  final String id;
  final String notificationType;
  final String notificationContent;
  final String senderName;
  final String createdAt;
  final String typeNotifyFlag;
  final String proposalId;
  final String coverLetter;
  final String statusFlag;

  Notification({
    required this.id,
    required this.notificationType,
    required this.notificationContent,
    required this.senderName,
    required this.createdAt,
    required this.typeNotifyFlag,
    required this.proposalId,
    required this.coverLetter,
    required this.statusFlag,
  });

  Notification.fromJson(Map<dynamic, dynamic> json)
      : id = json['id'],
        notificationType = json['notificationType'],
        notificationContent = json['notificationContent'],
        senderName = json['senderName'],
        createdAt = json['createdAt'],
        typeNotifyFlag = json['typeNotifyFlag'],
        proposalId = json['proposalId'],
        coverLetter = json['coverLetter'],
        statusFlag = json['statusFlag'];

  Map<dynamic, dynamic> toJson() {
    return {
      'id': id,
      'notificationType': notificationType,
      'notificationContent': notificationContent,
      'senderName': senderName,
      'createdAt': createdAt,
      'typeNotifyFlag': typeNotifyFlag,
      'proposalId': proposalId,
      'coverLetter': coverLetter,
      'statusFlag': statusFlag,
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
    String typeNotifyFlag,
    String proposalId,
    String coverLetter,
    String statusFlag,
  ) {
    state = [
      ...state,
      Notification(
        id: id,
        notificationType: notificationType,
        notificationContent: notificationContent,
        senderName: senderName,
        createdAt: createdAt,
        typeNotifyFlag: typeNotifyFlag,
        proposalId: proposalId,
        coverLetter: coverLetter,
        statusFlag: statusFlag,
      )
    ];
  }

  void clearNotificationData() {
    state = [];
  }
}

final notificationProvider = StateNotifierProvider<NotificationNotifier, List<Notification>>(
  (ref) => NotificationNotifier(),
);
