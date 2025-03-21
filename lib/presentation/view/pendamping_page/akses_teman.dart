import 'package:flutter/material.dart';
import 'package:aksesin/presentation/widget/button.dart';
import 'package:go_router/go_router.dart'; 

class AksesTemanScreen extends StatelessWidget {
  final TextEditingController _userIdController = TextEditingController(); 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            context.pop();
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'AksesTeman',
              style: TextStyle(
                fontFamily: 'Montserrat',
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Masukkan kode AksesTeman untuk mulai mendampingi!',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Montserrat',
                fontSize: 16,
              ),
            ),
            SizedBox(height: 16),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(8),
              ),
              child: TextField(
                controller: _userIdController, 
                decoration: InputDecoration(
                  border: InputBorder.none,
                ),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: 24,
                ),
                keyboardType: TextInputType.text, 
              ),
            ),
            SizedBox(height: 16),
            CustomButton(
              text: 'Masuk',
              onPressed: () {
                GoRouter.of(context).push('/track-teman', extra: _userIdController.text);
              },
            ),
            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
