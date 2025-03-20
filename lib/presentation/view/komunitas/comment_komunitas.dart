import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../provider/komunitas_provider.dart';
import '../../provider/notification_provider.dart';

class CommentKomunitas extends StatefulWidget {
  final String komunitasId;

  CommentKomunitas({required this.komunitasId});

  @override
  _CommentKomunitasState createState() => _CommentKomunitasState();
}

class _CommentKomunitasState extends State<CommentKomunitas> {
  final TextEditingController _commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Comments'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder<List<String>>(
              future: Provider.of<KomunitasProvider>(context, listen: false).fetchComments(widget.komunitasId),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(child: Text('No comments available'));
                } else {
                  final comments = snapshot.data!;
                  return ListView.builder(
                    itemCount: comments.length,
                    itemBuilder: (context, index) {
                      final parts = comments[index].split(':');
                      final username = parts[0];
                      final commentContent = parts.length > 1 ? parts[1] : '';

                      return Card(
                        margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                        child: ListTile(
                          leading: CircleAvatar(
                            child: Text(username[0]),
                          ),
                          title: Text(username),
                          subtitle: Text(commentContent),
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _commentController,
                    decoration: InputDecoration(
                      labelText: 'Add a comment',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () async {
                    if (_commentController.text.isNotEmpty) {
                      User? user = FirebaseAuth.instance.currentUser;
                      String displayName = user?.displayName ?? 'Anonymous';
                      String comment = '$displayName: ${_commentController.text}';
                      await Provider.of<KomunitasProvider>(context, listen: false).addComment(widget.komunitasId, comment);
                      
                  
                      final komunitasDoc = await FirebaseFirestore.instance.collection('komunitas').doc(widget.komunitasId).get();
                      await Provider.of<NotificationProvider>(context, listen: false).addNotification(
                        komunitasDoc['userId'], displayName, 'mengomentari postingan Anda', comment,
                      );

                      _commentController.clear();
                      setState(() {});
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
