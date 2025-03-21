import 'package:flutter/material.dart';
import '../../domain/entities/notification.dart' as entity;
import '../../domain/usecases/get_notification.dart';

class NotificationProvider with ChangeNotifier {
  final GetNotification getNotification;

  NotificationProvider({required this.getNotification});

  List<entity.Notification> _notifications = [];
  List<entity.Notification> get notifications => _notifications;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> fetchNotifications(String userId) async {
    _isLoading = true;
    notifyListeners();

    try {
      print("Fetching notifications for userId: $userId");
      _notifications = await getNotification(userId);
      print("Notifications fetched: ${_notifications.length}");
    } catch (e) {
      // Handle error
      print('Error fetching notifications: $e');
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> addNotification(String userId, String userName, String action, String content) async {
    await getNotification.addNotification(userId, userName, action, content);
    notifyListeners();
    await fetchNotifications(userId);
    notifyListeners();
  }
}
