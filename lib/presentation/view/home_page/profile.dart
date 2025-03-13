import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:aksesin/data/models/user_model.dart';
import 'package:aksesin/presentation/provider/auth_provider.dart';

class ProfileScreen extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    return Scaffold(
     appBar: AppBar(
        title: Text("Ini Profile"),
        actions: [
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () async {
              await authProvider.logout(context);
            },
          )
        ],
      ),
      body: FutureBuilder<UserModel>(
        future: authProvider.getCurrentUserProfile(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return Center(child: Text('No user data found.'));
          } else {
            UserModel user = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Username: ${user.username}', style: TextStyle(fontSize: 18)),
                  SizedBox(height: 8),
                  Text('Email: ${user.email}', style: TextStyle(fontSize: 18)),
                  SizedBox(height: 8),
                  Text('Disability Options: ${user.disabilityOptions.join(', ')}', style: TextStyle(fontSize: 18)),
                  SizedBox(height: 8),
                  user.photoUrl != null
                      ? Image.network(user.photoUrl!)
                      : Icon(Icons.account_circle, size: 100),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
