import 'package:aksesin/presentation/view/Profile.dart';
import 'package:aksesin/presentation/view/komunitas/komunitas_screen.dart';
import 'package:aksesin/presentation/view/home_page/akses_jalan.dart';
import 'package:aksesin/presentation/view/pendamping_page/beranda.dart';
import 'package:aksesin/presentation/widget/styles.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  final bool isPendamping;

  const HomeScreen({super.key, required this.isPendamping});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: [
          widget.isPendamping ? BerandaScreen() : AksesJalanScreen(),
          KomunitasScreen(),
          Profile(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: true,
        showUnselectedLabels: false, 
        type: BottomNavigationBarType.fixed,
        selectedItemColor: AppColors.primaryColor,
        unselectedItemColor: Colors.blueGrey,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: widget.isPendamping ? Icon(Icons.home) : Icon(Icons.explore),
            label: widget.isPendamping ? 'Beranda' : 'AksesJalan',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.message),
            label: 'Komunitas',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
