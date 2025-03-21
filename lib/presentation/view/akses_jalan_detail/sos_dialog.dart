import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:aksesin/presentation/widget/button.dart'; 
import 'package:cloud_firestore/cloud_firestore.dart';

class SosDialog extends StatefulWidget {
  final String userId;
  final bool status;

  SosDialog({required this.userId, required this.status});

  @override
  _SosDialogState createState() => _SosDialogState();
}

class _SosDialogState extends State<SosDialog> {
  @override
  void initState() {
    super.initState();
    _updateSosStatus(widget.status);
  }

  Future<void> _updateSosStatus(bool status) async {
    print("PAS DISINI USER ID NYA: ${widget.userId}");
    await FirebaseFirestore.instance.collection('user_locations').doc(widget.userId).update({'sos': status});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black.withOpacity(0.7),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'AksesDarurat',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 4),
                  ),
                ),
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.orange,
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Text(
              'MODE SOS AKTIF!',
              style: TextStyle(
                color: Colors.orange,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Kami sudah mengirimkan notifikasi darurat dan\n'
              'membagikan lokasimu secara real-time.\n'
              'Bantuan sedang dalam perjalanan!',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
              ),
            ),
            SizedBox(height: 30),
            CustomButton(
              text: 'Batal SOS',
              onPressed: () async {
                await _updateSosStatus(false);
                context.pop();
              },
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16,
              verticalPadding: 15,
              horizontalPadding: 50,
            ),
          ],
        ),
      ),
    );
  }
}
