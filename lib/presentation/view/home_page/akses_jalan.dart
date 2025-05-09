import 'package:aksesin/presentation/widget/styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:aksesin/presentation/provider/auth_provider.dart';
import 'package:go_router/go_router.dart';

class AksesJalanScreen extends StatefulWidget {
  const AksesJalanScreen({super.key});

  @override
  State<AksesJalanScreen> createState() => _AksesJalanScreenState();
}

class _AksesJalanScreenState extends State<AksesJalanScreen> {
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
                        fontFamily: 'Montserrat', // Apply Montserrat font
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Mau kemana hari ini?',
                      style: AppTextStyles.heading1.copyWith(
                        color: Colors.white,
                        fontFamily: 'Montserrat', // Apply Montserrat font
                      ),
                    ),
                    SizedBox(height: 16),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.search, color: Colors.grey),
                          SizedBox(width: 8),
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                context.push('/akses-jalan-detail', extra: '');
                              },
                              child: AbsorbPointer(
                                child: TextField(
                                  decoration: InputDecoration(
                                    hintText: 'Cari Lokasi',
                                    border: InputBorder.none,
                                    hintStyle: TextStyle(
                                      fontFamily: 'Montserrat', // Apply Montserrat font
                                    ),
                                  ),
                                  onSubmitted: (query) {
                                    context.push('/akses-jalan-detail', extra: query);
                                  },
                                ),
                              ),
                            ),
                          ),
                          IconButton(
                            icon: Icon(Icons.mic, color: Colors.blue),
                            onPressed: () {
                              // ini masih nanti
                            },
                          ),
                        ],
                      ),
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