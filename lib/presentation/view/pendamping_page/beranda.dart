import 'package:aksesin/presentation/view/akses_jalan_detail/akses_jalan_detail.dart';
import 'package:aksesin/presentation/view/pendamping_page/akses_teman.dart';
import 'package:aksesin/presentation/widget/button.dart';
import 'package:aksesin/presentation/widget/styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:aksesin/presentation/provider/auth_provider.dart';

class BerandaScreen extends StatefulWidget {
  const BerandaScreen({super.key});

  @override
  State<BerandaScreen> createState() => _BerandaScreenState();
}

class _BerandaScreenState extends State<BerandaScreen> {
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final displayName = authProvider.userDisplayName ?? 'User';

    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/backgroundHome.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SafeArea(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Halo, $displayName 👋',
                      style: AppTextStyles.bodyText.copyWith(
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Yuk, mulai dampingi perjalanan hari ini!',
                      style: AppTextStyles.heading1.copyWith(
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomButton(
                          text: 'AksesTeman',
                          icon: Image.asset(
                            'assets/images/ob2.png',
                            width: 24, 
                            height: 24, 
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AksesTemanScreen(),
                              ),
                            );
                          },
                          backgroundColor: Colors.white,
                          textColor: Colors.black,
                          borderRadius: 10,
                          width: 150,
                        ),
                        SizedBox(width: 16),
                        CustomButton(
                          text: 'AksesJalan',
                          icon: Image.asset(
                            'assets/images/ob1.png',
                            width: 24, 
                            height: 24, 
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AksesJalanDetailScreen(location: ''),
                              ),
                            );
                          },
                          backgroundColor: Colors.white,
                          textColor: Colors.black,
                          borderRadius: 10,
                          width: 150,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
