import '../../domain/entities/notification.dart';
import '../../domain/repositories/notification_repository.dart';
import '../datasource/notification_firestore_service.dart';
import '../models/notification_model.dart';

class NotificationRepositoryImpl implements NotificationRepository {
  final NotificationFirestoreService service;

  NotificationRepositoryImpl(this.service);

  @override
  Future<List<Notification>> getNotifications(String userId) async {
    final notifications = await service.getNotifications(userId);
    return notifications.map((data) => NotificationModel.fromMap(data, data['id'])).toList();
  }

  @override
  Future<void> addNotification(String userId, String userName, String action, String content) async {
    await service.addNotification(userId, userName, action, content);
  }
}
