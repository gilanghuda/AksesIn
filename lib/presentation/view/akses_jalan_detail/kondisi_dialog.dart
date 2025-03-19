import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class KondisiDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Container(
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Kondisi',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () {
                    context.pop();
                  },
                ),
              ],
            ),
            SizedBox(height: 20),
            Text(
              'Lalu lintas',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Container(
              height: 100,
              color: Colors.grey[300],
              child: Center(child: Text('Grafik lalu lintas')),
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Icon(Icons.accessibility, color: Colors.orange),
                SizedBox(width: 10),
                Text('Rute ramah disabilitas.'),
              ],
            ),
            SizedBox(height: 20),
            Text(
              'Waktu populer: Sabtu',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Container(
              height: 100,
              color: Colors.grey[300],
              child: Center(child: Text('Grafik waktu populer')),
            ),
          ],
        ),
      ),
    );
  }
}
