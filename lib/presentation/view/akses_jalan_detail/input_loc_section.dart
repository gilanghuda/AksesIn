import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class InputLocSection extends StatelessWidget {
  const InputLocSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 90),
        Row(
          children: [
            Icon(Icons.location_on, color: Colors.white),
            SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Lokasi',
                  style: TextStyle(color: Colors.white, fontSize: 14, fontFamily: 'Montserrat'),
                ),
                Text(
                  'Universitas Brawijaya',
                  style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold, fontFamily: 'Montserrat'),
                ),
              ],
            ),
          ],
        ),
        SizedBox(height: 16),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 4.0,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: TextField(
            onSubmitted: (value) {
              context.push('/map', extra: {'destinationAddress': value, 'isSosReceived': false});
            },
            decoration: InputDecoration(
              hintText: 'Cari Lokasi',
              prefixIcon: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  context.pop();
                },
              ),
              suffixIcon: Icon(Icons.mic),
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(vertical: 15.0),
            ),
          ),
        ),
        SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              children: [
                Icon(Icons.home, color: Colors.white),
                SizedBox(width: 4),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Rumah', style: TextStyle(color: Colors.white, fontFamily: 'Montserrat')),
                    Text('Jl. Sigura-Gura', style: TextStyle(fontSize: 12, color: Colors.white70, fontFamily: 'Montserrat')),
                  ],
                ),
              ],
            ),
            Row(
              children: [
                Icon(Icons.business, color: Colors.white),
                SizedBox(width: 4),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Kantor', style: TextStyle(color: Colors.white, fontFamily: 'Montserrat')),
                    Text('Atur lokasi', style: TextStyle(fontSize: 12, color: Colors.white70, fontFamily: 'Montserrat')),
                  ],
                ),
              ],
            ),
            Row(
              children: [
                Icon(Icons.more_horiz, color: Colors.white),
                SizedBox(width: 4),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Lainnya', style: TextStyle(color: Colors.white, fontFamily: 'Montserrat')),
                  ],
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
