import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:aksesin/presentation/provider/auth_provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileState();
}

class _ProfileState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ini Profile"),
        actions: [
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () async {
              await Provider.of<AuthProvider>(context, listen: false).logout(context);
            },
          )
        ],
      ),
      body: const Center(
        child: Text("ini profile"),
      ),
    );
  }
}