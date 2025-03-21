import 'package:aksesin/presentation/widget/styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../provider/notification_provider.dart';
import '../../provider/auth_provider.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  String? userId;

  @override
  void initState() {
    super.initState();
    userId = Provider.of<AuthProvider>(context, listen: false).authService.getCurrentUser()?.uid;
    if (userId != null) {
      Future.microtask(()=>_fetchNotifications());
    }
  }

  Future<void> _fetchNotifications() async {
    if (userId != null) {
      await Provider.of<NotificationProvider>(context, listen: false).fetchNotifications(userId!);
    }
  }

  String getTimeInfo(DateTime createdAt) {
    final now = DateTime.now();
    final difference = now.difference(createdAt);

    if (difference.inDays == 0) {
      return 'Hari ini';
    } else if (difference.inDays == 1) {
      return 'Kemarin';
    } else if (difference.inDays < 7) {
      return '${difference.inDays} hari yang lalu';
    } else if (difference.inDays < 30) {
      return '${(difference.inDays / 7).floor()} minggu yang lalu';
    } else {
      return '${(difference.inDays / 30).floor()} bulan yang lalu';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Notifications',
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'Montserrat',
          ),
        ),
        backgroundColor: AppColors.primaryColor,
      ),
      body: userId == null
          ? Center(
              child: Text(
                'No user logged in',
                style: TextStyle(
                  fontFamily: 'Montserrat',
                ),
              ),
            )
          : Consumer<NotificationProvider>(
              builder: (context, provider, child) {
                if (provider.isLoading) {
                  return Center(child: CircularProgressIndicator());
                }

                if (provider.notifications.isEmpty) {
                  print("apa ini");
                  print(provider.notifications);
                  print(provider);
                  return Center(
                    child: Text(
                      'No notifications available',
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                      ),
                    ),
                  );
                }

                return ListView.builder(
                  itemCount: provider.notifications.length,
                  itemBuilder: (context, index) {
                    final notification = provider.notifications[index];
                    return Column(
                      children: [
                        ListTile(
                          leading: Icon(Icons.person), 
                          title: Text(
                            notification.body,
                            style: TextStyle(
                              fontFamily: 'Montserrat',
                            ),
                          ),
                          trailing: Text(
                            getTimeInfo(notification.createdAt),
                            style: TextStyle(
                              fontFamily: 'Montserrat',
                            ),
                          ),
                        ),
                        Divider(), 
                      ],
                    );
                  },
                );
              },
            ),
    );
  }
}
