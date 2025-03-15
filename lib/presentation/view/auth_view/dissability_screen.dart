import 'package:flutter/material.dart';
import 'package:aksesin/presentation/widget/button.dart';
import 'package:go_router/go_router.dart';
import 'button_disability_section.dart';

class DissabilityScreen extends StatefulWidget {
  final String option;

  const DissabilityScreen({
    super.key,
    required this.option,
  });

  @override
  _DissabilityScreenState createState() => _DissabilityScreenState();
}

class _DissabilityScreenState extends State<DissabilityScreen> {
  List<String> _selectedOptions = [];
  bool isSelected = false;

  @override
  void initState() {
    super.initState();
    isSelected = false; 
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Pilih Kebutuhanmu untuk Menyesuaikan Akunmu',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            ButtonDisabilitySection(
              onSelectedOptionsChanged: (selectedOptions) {
                setState(() {
                  _selectedOptions = selectedOptions;
                });
              },
            ),
            const SizedBox(height: 32),
            CustomButton(
              text: 'Daftar',
              onPressed: () {
                context.go('/register', extra: _selectedOptions);
              },
            ),
          ],
        ),
      ),
    );
  }
}
