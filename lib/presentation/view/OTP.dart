import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Add this import
import 'dart:async'; // Add this import
import 'package:flutter/gestures.dart'; // Add this import

class OTP extends StatefulWidget {
  const OTP({super.key});
  @override
  _OTPState createState() => _OTPState();
}

class _OTPState extends State<OTP> {
  final FocusNode _emailFocusNode = FocusNode();
  final List<FocusNode> _otpFocusNodes = List.generate(4, (_) => FocusNode());
  final List<TextEditingController> _otpControllers =
      List.generate(4, (_) => TextEditingController());
  late Timer _timer;
  int _remainingTime = 300; // 5 minutes in seconds

  @override
  void initState() {
    super.initState();
    _emailFocusNode.addListener(() {
      setState(() {});
    });
    for (var focusNode in _otpFocusNodes) {
      focusNode.addListener(() {
        setState(() {});
      });
    }
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _startTimer(); // Automatically start the timer when the page is loaded
    });
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_remainingTime > 0) {
        setState(() {
          _remainingTime--;
        });
      } else {
        _timer.cancel();
      }
    });
  }

  void _resetTimer() {
    setState(() {
      _remainingTime = 300; // Reset to 5 minutes
    });
    _startTimer();
  }

  String _formatTime(int seconds) {
    final minutes = seconds ~/ 60;
    final remainingSeconds = seconds % 60;
    return '$minutes:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  bool _areAllBoxesFilled() {
    return _otpControllers.every((controller) => controller.text.isNotEmpty);
  }

  @override
  void dispose() {
    _emailFocusNode.dispose();
    for (var focusNode in _otpFocusNodes) {
      focusNode.dispose();
    }
    for (var controller in _otpControllers) {
      controller.dispose();
    }
    _timer.cancel();
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
              top: 90, // 50 pixels higher from the previous position
              left: 0,
              right: 0,
              child: Center(
                child: Text(
                  'Verifikasi OTP',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            Positioned(
              top: 130, // 40 pixels below the header
              left: 0,
              right: 0,
              child: Center(
                child: Text(
                  'Masukkan OTP yang telah dikirim ke alamat email Anda',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Positioned(
              top: 200, // Move down by 30 pixels
              left: 0,
              right: 0,
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: List.generate(4, (index) {
                    return Container(
                      width: 80, // Set width to 80 pixels
                      height: 80, // Set height to 80 pixels
                      decoration: BoxDecoration(
                        color: Color(0xFFC7E2FF), // Set base color to C7E2FF
                        border: Border.all(
                          color: _otpFocusNodes[index].hasFocus ||
                                  _otpControllers[index].text.isNotEmpty
                              ? Color(0xFF007AFF)
                              : Color(
                                  0xFFC7E2FF), // Change border color when focused or has input
                          width: 2.0, // Set border width to 2 pixels
                        ),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Center(
                        child: TextField(
                          focusNode: _otpFocusNodes[index],
                          controller: _otpControllers[index],
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.number,
                          maxLength: 1,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ], // Ensure only numbers are input
                          style: TextStyle(
                            color:
                                Color(0xFF007AFF), // Set font color to 007AFF
                            fontWeight: FontWeight.w900, // Make font 2x bolder
                            fontSize: 24, // Make font bigger
                          ),
                          decoration: InputDecoration(
                            counterText: '',
                            border: InputBorder.none,
                          ),
                          onTap: () {
                            setState(() {}); // Ensure color changes on tap
                          },
                          onChanged: (value) {
                            if (value.isNotEmpty && index < 3) {
                              FocusScope.of(context)
                                  .requestFocus(_otpFocusNodes[index + 1]);
                            }
                            setState(
                                () {}); // Ensure color stays changed on input
                          },
                        ),
                      ),
                    );
                  }),
                ),
              ),
            ),
            Positioned(
              top: 310, // 30 pixels lower than before
              left: 0,
              right: 0,
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      _formatTime(_remainingTime),
                      style: TextStyle(
                        fontSize: 20, // Make timer font smaller
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF007AFF), // Set timer color to 007AFF
                      ),
                    ),
                    SizedBox(width: 10),
                    Text(
                      'tersisa',
                      style: TextStyle(
                        fontSize: 20, // Make text font smaller
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF007AFF), // Set text color to 007AFF
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 360, // 50 pixels below the timer
              left: 0,
              right: 0,
              child: Center(
                child: RichText(
                  text: TextSpan(
                    text: 'Belum menerima OTP? ',
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0xFF666666), // Change text color to 666666
                    ),
                    children: [
                      TextSpan(
                        text: 'Kirim Ulang',
                        style: TextStyle(
                          fontSize: 16,
                          color: Color(
                              0xFF3395FF), // Set clickable text color to 3395FF
                          fontWeight: FontWeight.bold,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            _resetTimer(); // Reset the timer when clicked
                          },
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              top: 420, // Position the button below the "Kirim Ulang" text
              left: 0,
              right: 0,
              child: Center(
                child: SizedBox(
                  width: 368,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: _areAllBoxesFilled()
                        ? () {
                            // Handle verification logic here
                          }
                        : null,
                    child: Text('Verifikasi',
                        style: TextStyle(color: Colors.white)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _areAllBoxesFilled()
                          ? Color(
                              0xFF0064D1) // Change button color to 0064D1 when all boxes are filled
                          : Color(0xFFCFCFCF), // Default button color
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
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
