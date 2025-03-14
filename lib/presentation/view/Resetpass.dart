import 'package:flutter/material.dart';

class Resetpass extends StatefulWidget {
  const Resetpass({super.key});
  @override
  _Resetpass createState() => _Resetpass();
}

class _Resetpass extends State<Resetpass> {
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final FocusNode _newPasswordFocusNode = FocusNode();
  final FocusNode _confirmPasswordFocusNode = FocusNode();
  bool _isNewPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;
  bool _passwordsMatch = true;

  @override
  void dispose() {
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    _newPasswordFocusNode.dispose();
    _confirmPasswordFocusNode.dispose();
    super.dispose();
  }

  void _validatePasswords() {
    setState(() {
      _passwordsMatch =
          _newPasswordController.text == _confirmPasswordController.text;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Container(
          margin: EdgeInsets.all(8.0),
          decoration:
              BoxDecoration(shape: BoxShape.circle, color: Color(0xFF66AFFF)),
          child: IconButton(
            icon: Icon(Icons.arrow_back_ios_new_outlined, color: Colors.white),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(
          left: 16.0,
          right: 16.0,
          top: 200.0, // Move elements 50 pixels higher
          bottom: MediaQuery.of(context).viewInsets.bottom +
              16.0, // Adjust for keyboard
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment:
              CrossAxisAlignment.start, // Align texts to the left
          children: <Widget>[
            Text(
              'Kata Sandi Baru',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18), // Make text bigger
            ),
            SizedBox(height: 10),
            Focus(
              onFocusChange: (hasFocus) {
                setState(() {});
              },
              child: TextField(
                controller: _newPasswordController,
                focusNode: _newPasswordFocusNode,
                obscureText: !_isNewPasswordVisible,
                onChanged: (text) => _validatePasswords(),
                decoration: InputDecoration(
                  labelText: _passwordsMatch
                      ? 'Masukkan Kata Sandi Baru Anda'
                      : 'Kata Sandi Tidak Sama',
                  labelStyle: TextStyle(
                      color: _passwordsMatch
                          ? (_newPasswordFocusNode.hasFocus
                              ? Color(0xFF007AFF)
                              : Color(0xFF858585))
                          : Colors.red), // Set text color
                  prefixIcon: Icon(Icons.lock,
                      color: _passwordsMatch
                          ? (_newPasswordFocusNode.hasFocus
                              ? Color(0xFF007AFF)
                              : Color(0xFF858585))
                          : Colors.red), // Add lock icon
                  suffixIcon: IconButton(
                    icon: Icon(
                      _isNewPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: _passwordsMatch
                          ? (_newPasswordFocusNode.hasFocus
                              ? Color(0xFF007AFF)
                              : Color(0xFF858585))
                          : Colors.red,
                    ),
                    onPressed: () {
                      setState(() {
                        _isNewPasswordVisible = !_isNewPasswordVisible;
                      });
                    },
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(
                      color: _passwordsMatch
                          ? (_newPasswordFocusNode.hasFocus
                              ? Color(0xFF007AFF)
                              : Color(0xFF858585))
                          : Colors.red,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(
                      color: _passwordsMatch ? Color(0xFF007AFF) : Colors.red,
                    ),
                  ),
                  contentPadding: EdgeInsets.symmetric(
                      vertical: 10.0), // Make text box slimmer
                ),
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Konfirmasi Kata Sandi',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18), // Make text bigger and bold
            ),
            SizedBox(height: 10),
            Focus(
              onFocusChange: (hasFocus) {
                setState(() {});
              },
              child: TextField(
                controller: _confirmPasswordController,
                focusNode: _confirmPasswordFocusNode,
                obscureText: !_isConfirmPasswordVisible,
                onChanged: (text) => _validatePasswords(),
                decoration: InputDecoration(
                  labelText: _passwordsMatch
                      ? 'Masukkan Lagi Kata Sandi Anda'
                      : 'Kata Sandi Tidak Sama',
                  labelStyle: TextStyle(
                      color: _passwordsMatch
                          ? (_confirmPasswordFocusNode.hasFocus
                              ? Color(0xFF007AFF)
                              : Color(0xFF858585))
                          : Colors.red), // Set text color
                  prefixIcon: Icon(Icons.lock,
                      color: _passwordsMatch
                          ? (_confirmPasswordFocusNode.hasFocus
                              ? Color(0xFF007AFF)
                              : Color(0xFF858585))
                          : Colors.red), // Add lock icon
                  suffixIcon: IconButton(
                    icon: Icon(
                      _isConfirmPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: _passwordsMatch
                          ? (_confirmPasswordFocusNode.hasFocus
                              ? Color(0xFF007AFF)
                              : Color(0xFF858585))
                          : Colors.red,
                    ),
                    onPressed: () {
                      setState(() {
                        _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
                      });
                    },
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(
                      color: _passwordsMatch
                          ? (_confirmPasswordFocusNode.hasFocus
                              ? Color(0xFF007AFF)
                              : Color(0xFF858585))
                          : Colors.red,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(
                      color: _passwordsMatch ? Color(0xFF007AFF) : Colors.red,
                    ),
                  ),
                  contentPadding: EdgeInsets.symmetric(
                      vertical: 10.0), // Make text box slimmer
                ),
              ),
            ),
            SizedBox(height: 20),
            SizedBox(
              width: 368,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  // Handle password reset logic here
                },
                child: Text('Reset Password',
                    style: TextStyle(color: Colors.white)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF0064D1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
