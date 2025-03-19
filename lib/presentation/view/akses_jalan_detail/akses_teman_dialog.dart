import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:aksesin/presentation/provider/auth_provider.dart';
import 'package:aksesin/presentation/widget/button.dart'; // Import CustomButton

class AksesTemanDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userId = Provider.of<AuthProvider>(context).authService.getCurrentUser()?.uid ?? 'Unknown';

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'AksesTeman',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'Bagikan kode perjalananmu dengan orang terdekat untuk rasa aman ekstra!',
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                userId,
                style: TextStyle(fontSize: 18, letterSpacing: 5),
              ),
            ),
            SizedBox(height: 20),
            CustomButton( 
              text: 'Salin',
              onPressed: () {
                Clipboard.setData(ClipboardData(text: userId));
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Kode disalin ke clipboard')),
                );
              },
              backgroundColor: Colors.blue,
              textColor: Colors.white,
              fontSize: 16,
              verticalPadding: 16,
              horizontalPadding: 0,
              borderRadius: 10,
              width: double.infinity,
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  icon: Image.asset('assets/images/waIcon.png'),
                  onPressed: () {
                    //kalo butuh aja 
                  },
                ),
                IconButton(
                  icon: Image.asset('assets/images/igIcon.png'),
                  onPressed: () {
                    //kalo butuh aja 
                  },
                ),
                IconButton(
                  icon: Image.asset('assets/images/emailIcon.png'),
                  onPressed: () {
                    //kalo butuh aja 
                  },
                ),
                IconButton(
                  icon: Icon(Icons.more_horiz),
                  onPressed: () {
                    //kalo butuh aja 
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
