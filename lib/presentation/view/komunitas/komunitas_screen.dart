import 'package:aksesin/data/models/user_model.dart';
import 'package:aksesin/presentation/provider/auth_provider.dart';
import 'package:aksesin/presentation/provider/notification_provider.dart';
import 'package:aksesin/presentation/widget/styles.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'search_post_section.dart';
import '../../provider/komunitas_provider.dart';

class KomunitasScreen extends StatefulWidget {
  const KomunitasScreen({super.key});

  @override
  State<KomunitasScreen> createState() => _KomunitasScreenState();
}

class _KomunitasScreenState extends State<KomunitasScreen> {
  List<String> _selectedCategories = ['All'];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
    });
  }

  void _updateCategory(String categories) {
    setState(() {
      _selectedCategories = categories.split(', ');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(16.0),
                bottomRight: Radius.circular(16.0),
              ),
            ),
            padding: const EdgeInsets.all(16.0),
            child: SearchPostSection(onCategorySelected: _updateCategory),
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: _selectedCategories.contains('All')
                  ? FirebaseFirestore.instance.collection('komunitas').snapshots()
                  : FirebaseFirestore.instance
                      .collection('komunitas')
                      .where('category', whereIn: _selectedCategories)
                      .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return Center(child: Text('No posts available', style: TextStyle(fontFamily: 'Montserrat')));
                }
                final komunitasList = snapshot.data!.docs;
                return ListView.builder(
                  padding: const EdgeInsets.all(8.0),
                  itemCount: komunitasList.length,
                  itemBuilder: (context, index) {
                    final komunitas = komunitasList[index];
                    final createdAt = DateFormat('dd MMM yyyy, HH:mm').format(komunitas['createdAt'].toDate());
                    return _buildPost(
                      context,
                      komunitas['username'],
                      createdAt,
                      komunitas['content'],
                      komunitas['likesCount'],
                      komunitas['commentsCount'],
                      images: List<String>.from(komunitas['images'] ?? []),
                      profilePicture: komunitas['userProfileImage'],
                      komunitasId: komunitas.id,
                      likedBy: List<String>.from(komunitas['likedBy'] ?? []),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        shape: CircleBorder(),
        backgroundColor: AppColors.primaryColor,
        onPressed: () {
          context.push('/post-komunitas');
        },
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Widget _buildPost(BuildContext context, String author, String date, String content, int likes, int comments, {List<String>? images, required String profilePicture, required String komunitasId, required List<String> likedBy}) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    return FutureBuilder<UserModel>(
      future: authProvider.getCurrentUserProfile(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}', style: TextStyle(fontFamily: 'Montserrat')));
        } else if (!snapshot.hasData) {
          return Center(child: Text('No user data found.', style: TextStyle(fontFamily: 'Montserrat')));
        } else {
          UserModel currentUser = snapshot.data!;

          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8.0),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundImage: NetworkImage(profilePicture.isNotEmpty ? profilePicture : 'assets/default_avatar.png'),
                      ),
                      const SizedBox(width: 8.0),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(author, style: const TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Montserrat')),
                          Text(date, style: const TextStyle(color: Colors.grey, fontFamily: 'Montserrat')),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 8.0),
                  Text(content, style: TextStyle(fontFamily: 'Montserrat')),
                  if (images != null && images.isNotEmpty) ...[
                    const SizedBox(height: 8.0),
                    Column(
                      children: images.map((image) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4.0),
                        child: Image.network(image, errorBuilder: (context, error, stackTrace) {
                          return Text('Could not load image', style: TextStyle(fontFamily: 'Montserrat'));
                        }),
                      )).toList(),
                    ),
                  ],
                  const SizedBox(height: 8.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          IconButton(
                            icon: Icon(
                              Icons.thumb_up,
                              color: likedBy.contains(currentUser.id) ? Colors.blue : null,
                            ),
                            onPressed: () {
                              if (likedBy.contains(currentUser.id)) {
                                _updateLikes(komunitasId, likes - 1, currentUser.id, unlike: true);
                              } else {
                                _updateLikes(komunitasId, likes + 1, currentUser.id);
                              }
                            },
                          ),
                          Text('$likes', style: TextStyle(fontFamily: 'Montserrat')),
                        ],
                      ),
                      Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.comment),
                            onPressed: () {
                              _showCommentsDialog(context, komunitasId, currentUser.id);
                            },
                          ),
                          Text('$comments', style: TextStyle(fontFamily: 'Montserrat')),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        }
      },
    );
  }

  void _updateLikes(String komunitasId, int newLikesCount, String userId, {bool unlike = false}) async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final userProfile = await authProvider.getCurrentUserProfile();
    final userName = userProfile.username;
    final komunitasDoc = await FirebaseFirestore.instance.collection('komunitas').doc(komunitasId).get();
    final content = komunitasDoc['content'];

    if (unlike) {
      await Provider.of<KomunitasProvider>(context, listen: false).unlikeKomunitas(komunitasId, newLikesCount, userId);
    } else {
      await Provider.of<KomunitasProvider>(context, listen: false).updateLikes(komunitasId, newLikesCount, userId);
      await Provider.of<NotificationProvider>(context, listen: false).addNotification(
        komunitasDoc['userId'],
        userName,
        'menyukai postingan Anda',
        content
      );
    }
    setState(() {});
  }

  void _showCommentsDialog(BuildContext context, String komunitasId, String userId) {
    context.push('/comments/$komunitasId');
  }
}