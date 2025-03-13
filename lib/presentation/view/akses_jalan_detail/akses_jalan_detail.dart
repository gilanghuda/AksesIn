import 'package:flutter/material.dart';

class AksesJalanDetailScreen extends StatelessWidget {
  final String location;

  const AksesJalanDetailScreen({Key? key, required this.location}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(location),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                TextField(
                  decoration: InputDecoration(
                    hintText: 'Cari Lokasi',
                    prefixIcon: Icon(Icons.search),
                    suffixIcon: Icon(Icons.mic),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ),
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        Icon(Icons.home, color: Colors.blue),
                        Text('Rumah'),
                      ],
                    ),
                    Column(
                      children: [
                        Icon(Icons.business, color: Colors.blue),
                        Text('Kantor'),
                      ],
                    ),
                    Column(
                      children: [
                        Icon(Icons.more_horiz, color: Colors.blue),
                        Text('Lainnya'),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          Divider(),
          Expanded(
            child: ListView(
              padding: EdgeInsets.all(16),
              children: [
                Text('Riwayat', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                ListTile(
                  title: Text('Hyde Cafe (Rooftop Trix House)'),
                  subtitle: Text('Jalan Terusan Cikampek, Penanggungan, Kota Malang'),
                  trailing: Text('Buka - Tutup 22.00'),
                ),
                ListTile(
                  title: Text('7 Seven Chicken'),
                  subtitle: Text('Jalan Soekarno Hatta, Mojolangu, Kota Malang'),
                  trailing: Text('Buka 24 jam'),
                ),
                ListTile(
                  title: Text('Ubud Cottages Malang'),
                  subtitle: Text('Jalan Bendungan Sigura-Gura Barat, Karangbesuki, Kota Malang'),
                  trailing: Text('Buka'),
                ),
                ListTile(
                  title: Text('Po Kang'),
                  subtitle: Text('Jalan Bondowoso, Gadang Kasri, Kota Malang'),
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
