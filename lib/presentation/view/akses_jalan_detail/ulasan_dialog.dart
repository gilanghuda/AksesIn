import 'package:aksesin/presentation/widget/button.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class UlasanDialog extends StatefulWidget {
  @override
  _UlasanDialogState createState() => _UlasanDialogState();
}

class _UlasanDialogState extends State<UlasanDialog> {
  int? _selectedEmoji;
  final TextEditingController _controller = TextEditingController();
  bool _isSubmitted = false;

  void _submitReview() {
    setState(() {
      _isSubmitted = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: _isSubmitted ? _buildSuccessScreen() : _buildReviewForm(),
      ),
    );
  }

  Widget _buildReviewForm() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'Bagaimana perjalanan tadi?',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.generate(4, (index) {
            final icons = [
              Icons.sentiment_very_dissatisfied,
              Icons.sentiment_dissatisfied,
              Icons.sentiment_satisfied,
              Icons.sentiment_very_satisfied,
            ];
            return IconButton(
              icon: Icon(
                icons[index],
                color: _selectedEmoji == index ? Colors.blue : Colors.grey,
                size: 30,
              ),
              onPressed: () {
                setState(() {
                  _selectedEmoji = index;
                });
              },
            );
          }),
        ),
        SizedBox(height: 20),
        Align(
          alignment: Alignment.centerLeft,
          child: Text("Tulis ulasanmu disini", textAlign: TextAlign.start),
        ),
        TextField(
          controller: _controller,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          maxLines: 3,
        ),
        SizedBox(height: 20),
        CustomButton(
          text: ('Kirim'),
          onPressed: _controller.text.isEmpty ? () {} : _submitReview,
          backgroundColor:_controller.text.isEmpty ? Colors.grey :  Colors.blue,
        ),
      ],
    );
  }

  Widget _buildSuccessScreen() {
    Future.delayed(Duration(seconds: 2), () {
      context.pop();
    });

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.check_circle, color: Colors.blue, size: 50),
        SizedBox(height: 20),
        Text(
          'Ulasan Berhasil Dikirim! 🎉',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 10),
        Text(
          'Terima kasih sudah berbagi pengalamanmu dengan Aksesin!',
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
