import '../entities/notification.dart';

abstract class NotificationRepository {
  Future<List<Notification>> getNotifications(String userId);
  Future<void> addNotification(String userId, String userName, String action, String content);
}
