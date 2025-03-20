import '../entities/notification.dart';
import '../repositories/notification_repository.dart';

class GetNotification {
  final NotificationRepository repository;

  GetNotification(this.repository);

  Future<List<Notification>> call(String userId) {
    return repository.getNotifications(userId);
  }

  Future<void> addNotification(String userId, String userName, String action, String content) {
    return repository.addNotification(userId, userName, action, content);
  }
}
