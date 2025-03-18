import 'package:aksesin/data/models/user_model.dart';
import 'package:aksesin/presentation/provider/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'search_post_section.dart';
import '../../provider/komunitas_provider.dart';

class KomunitasScreen extends StatefulWidget {
  const KomunitasScreen({super.key});

  @override
  State<KomunitasScreen> createState() => _KomunitasScreenState();
}

class _KomunitasScreenState extends State<KomunitasScreen> {
  String _selectedCategory = 'All';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
    });
  }

  void _updateCategory(String category) {
    setState(() {
      _selectedCategory = category;
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
              stream: _selectedCategory == 'All'
                  ? FirebaseFirestore.instance.collection('komunitas').snapshots()
                  : FirebaseFirestore.instance
                      .collection('komunitas')
                      .where('category', isEqualTo: _selectedCategory)
                      .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return Center(child: Text('No posts available'));
                }
                final komunitasList = snapshot.data!.docs;
                return ListView.builder(
                  padding: const EdgeInsets.all(8.0),
                  itemCount: komunitasList.length,
                  itemBuilder: (context, index) {
                    final komunitas = komunitasList[index];
                    return _buildPost(
                      context,
                      komunitas['username'],
                      komunitas['createdAt'].toDate().toString(),
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
        onPressed: () {
          context.push('/post-komunitas');
        },
        child: const Icon(Icons.add),
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
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData) {
          return Center(child: Text('No user data found.'));
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
                        backgroundImage: NetworkImage(profilePicture),
                      ),
                      const SizedBox(width: 8.0),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(author, style: const TextStyle(fontWeight: FontWeight.bold)),
                          Text(date, style: const TextStyle(color: Colors.grey)),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 8.0),
                  Text(content),
                  if (images != null && images.isNotEmpty) ...[
                    const SizedBox(height: 8.0),
                    Column(
                      children: images.map((image) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4.0),
                        child: Image.network(image, errorBuilder: (context, error, stackTrace) {
                          return Text('Could not load image');
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
                          Text('$likes'),
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
                          Text('$comments'),
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
    if (unlike) {
      await Provider.of<KomunitasProvider>(context, listen: false).unlikeKomunitas(komunitasId, newLikesCount, userId);
    } else {
      await Provider.of<KomunitasProvider>(context, listen: false).updateLikes(komunitasId, newLikesCount, userId);
    }
    setState(() {});
  }

  void _showCommentsDialog(BuildContext context, String komunitasId, String userId) {
    context.push('/comments/$komunitasId');
  }
}