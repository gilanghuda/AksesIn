import 'package:flutter/material.dart';

class CuacaDialog extends StatelessWidget {
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
                  'Cuaca',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
            SizedBox(height: 20),
            Text(
              'Malang',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text(
              '25°',
              style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
            ),
            Text(
              'Berawan\nH: 30°  L: 21°',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    Text('25°'),
                    Icon(Icons.cloud),
                    Text('Sekarang'),
                  ],
                ),
                Column(
                  children: [
                    Text('26°'),
                    Icon(Icons.cloud),
                    Text('11'),
                  ],
                ),
                Column(
                  children: [
                    Text('26°'),
                    Icon(Icons.cloud),
                    Text('12'),
                  ],
                ),
                Column(
                  children: [
                    Text('25°'),
                    Icon(Icons.cloud),
                    Text('13'),
                  ],
                ),
                Column(
                  children: [
                    Text('24°'),
                    Icon(Icons.cloud),
                    Text('14'),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
