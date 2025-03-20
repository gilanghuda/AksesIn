import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/notification.dart';

class NotificationFirestoreService {
  final CollectionReference _notificationCollection = FirebaseFirestore.instance.collection('notifications');

  Future<List<Map<String, dynamic>>> getNotifications(String userId) async {
    try {
      print("Fetching notifications for userId: $userId");
      QuerySnapshot snapshot = await _notificationCollection.where('userId', isEqualTo: userId).get();
      print("Query completed. Documents found: ${snapshot.docs.length}");
      return snapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        data['id'] = doc.id;
        print("data: $data");
        return data;
      }).toList();
    } catch (e) {
      print("Error fetching notifications: $e");
      return [];
    }
  }

  Future<void> addNotification(String userId, String userName, String action, String content) async {
    await _notificationCollection.add({
      'userId': userId,
      'title': 'New Activity',
      'body': '$userName $action. $content',
      'createdAt': Timestamp.now(),
    });
  }
}
