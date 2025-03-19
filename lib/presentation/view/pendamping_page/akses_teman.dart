import 'package:flutter/material.dart';
import 'package:aksesin/presentation/widget/button.dart';

class AksesTemanScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
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
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Masukkan kode AksesTeman untuk mulai mendampingi!',
              textAlign: TextAlign.center,
              style: TextStyle(
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
                decoration: InputDecoration(
                  border: InputBorder.none,
                ),
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 24),
                keyboardType: TextInputType.text, 
              ),
            ),
            SizedBox(height: 16),
            CustomButton(
              text: 'Masuk',
              onPressed: () {
                
              },
            ),
            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
