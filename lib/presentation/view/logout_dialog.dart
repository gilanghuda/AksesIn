import 'package:aksesin/presentation/widget/styles.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:aksesin/presentation/provider/auth_provider.dart';
import 'package:aksesin/presentation/widget/button.dart'; // Import CustomButton

class LogoutDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Column(
        mainAxisSize: MainAxisSize.min, // Wrap content
        children: [
          Image.asset(
            'assets/images/logout.png', 
          ),
        Text(
          'Keluar dari AksesIn?',
          style: TextStyle(fontWeight: FontWeight.bold), 
        ),
        Text(
          'Apakah Anda yakin ingin keluar?',
          style: TextStyle(fontSize: 16),
        ),
      ],
    ),
      actions: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomButton(
              text: 'Batal',
              onPressed: () {
                context.pop();
              },
              backgroundColor: Colors.white,
              textColor: AppColors.primaryColor,
              width: 100,
            ),
            CustomButton(
              text: 'Keluar',
              onPressed: () {
                Provider.of<AuthProvider>(context, listen: false).logout(context);
                context.pop();
              },
              backgroundColor: AppColors.primaryColor,
              textColor: Colors.white,
              width: 100,
            ),
          ],
        ),
      ],
    );
  }
}
