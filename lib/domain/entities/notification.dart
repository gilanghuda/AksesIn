class Notification {
  final String id;
  final String userId;
  final String title;
  final String body;
  final DateTime createdAt;

  Notification({
    required this.id,
    required this.userId,
    required this.title,
    required this.body,
    required this.createdAt,
  });
}
