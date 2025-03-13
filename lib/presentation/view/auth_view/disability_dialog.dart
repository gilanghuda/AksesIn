import 'package:aksesin/presentation/view/auth_view/button_disability_section.dart';
import 'package:flutter/material.dart';

class DisabilityDialog extends StatefulWidget {
  @override
  _DisabilityDialogState createState() => _DisabilityDialogState();
}

class _DisabilityDialogState extends State<DisabilityDialog> {
  List<String> _selectedOptions = [];

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Pilih Kebutuhanmu'),
      content: SingleChildScrollView(
        child: ButtonDisabilitySection(
          onSelectedOptionsChanged: (selectedOptions) {
            setState(() {
              _selectedOptions = selectedOptions;
            });
          },
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(_selectedOptions);
          },
          child: Text('OK'),
        ),
      ],
    );
  }
}
