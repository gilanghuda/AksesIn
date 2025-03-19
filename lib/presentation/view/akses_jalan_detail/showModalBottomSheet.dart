import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

void showBottomSheet(BuildContext context, String destinationAddress, String? placeDistance) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
    ),
    builder: (BuildContext context) {
      return Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              destinationAddress,
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text('${placeDistance ?? '0.0'} km'),
            Text(
              'Ringkasan ulasan',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Icon(Icons.sentiment_very_satisfied, color: Colors.green),
                    Text('Sangat Baik'),
                  ],
                ),
                Column(
                  children: <Widget>[
                    Icon(Icons.sentiment_satisfied, color: Colors.lightGreen),
                    Text('Baik'),
                  ],
                ),
                Column(
                  children: <Widget>[
                    Icon(Icons.sentiment_neutral, color: Colors.amber),
                    Text('Buruk'),
                  ],
                ),
                Column(
                  children: <Widget>[
                    Icon(Icons.sentiment_very_dissatisfied, color: Colors.red),
                    Text('Sangat Buruk'),
                  ],
                ),
              ],
            ),
            SizedBox(height: 20),
            Row(
              children: <Widget>[
                CircleAvatar(
                  backgroundColor: Colors.grey.shade200,
                  child: Icon(Icons.person, color: Colors.black),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                    'Ahmad Kiran\nPetunjuk arah yang diberikan sangat jelas dan akurat. Sebagai pengguna kursi roda saya merasa perjalanan jauh lebih mudah dan aman.',
                    style: TextStyle(fontSize: 14.0),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Row(
              children: <Widget>[
                CircleAvatar(
                  backgroundColor: Colors.grey.shade200,
                  child: Icon(Icons.person, color: Colors.black),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                    'Viviane Angeli\nSebagai tunanetra, saya sangat terbantu. Rute yang direkomendasikan juga mempertimbangkan jalur yang aman dan mudah dilalui. Keren!',
                    style: TextStyle(fontSize: 14.0),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  context.pop();
                },
                child: Text(
                  'Mulai Perjalanan'.toUpperCase(),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    },
  );
}
