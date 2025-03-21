import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class forgotpass extends StatefulWidget {
  const forgotpass({super.key});
  @override
  _forgotpassState createState() => _forgotpassState();
}

class _forgotpassState extends State<forgotpass> {
  final FocusNode _emailFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _emailFocusNode.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _emailFocusNode.dispose();
    super.dispose();
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
        title: Text(''),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        color: Color(0xFFFFFAFA), // Change background color here
        padding: const EdgeInsets.all(16.0),
        child: Stack(
          children: <Widget>[
            Positioned(
              top: 50, // Customize the position as needed
              left: 0,
              right: 0,
              child: Center(
                child: Image.asset(
                  'assets/images/gembok.png', // Ensure the path is correct
                  width: 400,
                  height: 400,
                ),
              ),
            ),
            Positioned(
              top: 425, // Adjust to position below the image
              left: 18,
              child: Text(
                'Lupa Kata Sandi?',
                style: TextStyle(
                  fontSize: 27,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Positioned(
              top: 470, // Adjust to position below the bold heading
              left: 18,
              right: 18,
              child: Container(
                width: MediaQuery.of(context).size.width -
                    30, // Ensure text does not go out of bounds
                child: Text(
                  'Tenang, kami siap membantu! Masukkan email untuk mengirim OTP dan reset kata sandi.',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                      height: 500), // Adjust to position below the smaller text
                  TextField(
                    focusNode: _emailFocusNode,
                    decoration: InputDecoration(
                      labelText: 'Masukkan email Anda',
                      labelStyle: TextStyle(
                          color: Colors.grey), // Set label text color to grey
                      border: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.circular(10.0), // Rounded border
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(
                          color: Colors
                              .blue, // Change outline color to blue when focused
                        ),
                      ),
                      prefixIcon: Icon(
                        Icons.email,
                        color: _emailFocusNode.hasFocus
                            ? Colors.blue
                            : Colors
                                .grey, // Change icon color to blue when focused
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        context.go('/otp-page');
                      },
                      child: Text('Selanjutnya',
                          style: TextStyle(color: Colors.white)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _emailFocusNode.hasFocus
                            ? Colors
                                .blue // Change button color to blue when focused
                            : Color(0xFFCFCFCF), // Default button color
                        padding: EdgeInsets.symmetric(vertical: 16.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
