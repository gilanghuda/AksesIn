import 'package:aksesin/presentation/widget/button.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SosDiterimaDialog extends StatelessWidget {
  final String? locationName;

  const SosDiterimaDialog({Key? key, this.locationName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black.withOpacity(0.7),
      body: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: const EdgeInsets.only(top: 60, left: 24, right: 24),
              child: Text(
                'Akses Darurat',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [         
                Icon(
                  Icons.warning,
                  color: Colors.orange,
                  size: 240,
                ),
                SizedBox(height: 20),
                Text(
                  'SOS DITERIMA!',
                  style: TextStyle(
                    color: Colors.orange,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'Temanmu dalam keadaan darurat!\nArahkan bantuan segera.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 10),
                if (locationName != null)
                  Text(
                    'Lokasi: $locationName',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
              ],
            ),
          ),
          Positioned(
            bottom: 30,
            left: 24,
            right: 24,
            child: CustomButton(
              text: 'Cek Lokasi',
              backgroundColor: Colors.red,
              onPressed: () {
                context.go('/map', extra: {'destinationAddress': locationName, 'isSosReceived': true});
              },
            ),
          ),
        ],
      ),
    );
  }
}
