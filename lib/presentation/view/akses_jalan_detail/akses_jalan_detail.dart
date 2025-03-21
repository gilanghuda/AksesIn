import 'package:flutter/material.dart';
import 'input_loc_section.dart';

class AksesJalanDetailScreen extends StatelessWidget {
  final String location;

  const AksesJalanDetailScreen({super.key, required this.location});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(16.0),
                bottomRight: Radius.circular(16.0),
              ),
            ),
            padding: const EdgeInsets.all(16.0),
            child: InputLocSection(),
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.all(16),
              children: [
                Text('Riwayat', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, fontFamily: 'Montserrat')),
                ListTile(
                  title: Text('Hyde Cafe (Rooftop Trix House)', style: TextStyle(fontFamily: 'Montserrat')),
                  subtitle: Text('Jalan Terusan Cikampek, Penanggungan, Kota Malang', style: TextStyle(fontFamily: 'Montserrat')),
                  trailing: Text('Buka - Tutup 22.00'),
                ),
                ListTile(
                  title: Text('7 Seven Chicken', style: TextStyle(fontFamily: 'Montserrat')),
                  subtitle: Text('Jalan Soekarno Hatta, Mojolangu, Kota Malang', style: TextStyle(fontFamily: 'Montserrat')),
                  trailing: Text('Buka 24 jam'),
                ),
                ListTile(
                  title: Text('Ubud Cottages Malang', style: TextStyle(fontFamily: 'Montserrat')),
                  subtitle: Text('Jalan Bendungan Sigura-Gura Barat, Karangbesuki, Kota Malang', style: TextStyle(fontFamily: 'Montserrat')),
                  trailing: Text('Buka'),
                ),
                ListTile(
                  title: Text('Po Kang', style: TextStyle(fontFamily: 'Montserrat')),
                  subtitle: Text('Jalan Bondowoso, Gadang Kasri, Kota Malang', style: TextStyle(fontFamily: 'Montserrat')),
                  trailing: Text('Buka'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
