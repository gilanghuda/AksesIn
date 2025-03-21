import '../../domain/entities/notification.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NotificationModel extends Notification {
  NotificationModel({
    required String id,
    required String userId,
    required String title,
    required String body,
    required DateTime createdAt,
  }) : super(
          id: id,
          userId: userId,
          title: title,
          body: body,
          createdAt: createdAt,
        );

  factory NotificationModel.fromMap(Map<String, dynamic> map, String id) {
    return NotificationModel(
      id: id,
      userId: map['userId'],
      title: map['title'],
      body: map['body'],
      createdAt: (map['createdAt'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'title': title,
      'body': body,
      'createdAt': createdAt,
    };
  }
}
