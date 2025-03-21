import 'package:flutter/material.dart';
import 'package:aksesin/presentation/widget/button.dart'; 

class BottomPlaceInfo extends StatelessWidget {
  final Function onStartJourney;
  final String destinationAddress;
  final String? placeDistance;
  final bool isSosReceived;

  BottomPlaceInfo({
    required this.onStartJourney,
    required this.destinationAddress,
    required this.placeDistance,
    required this.isSosReceived,
  });

  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
      ),
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                destinationAddress, 
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Montserrat',
                ),
              ),
              SizedBox(height: 10),
              Text('${placeDistance ?? '0.0'} km', style: TextStyle(fontFamily: 'Montserrat')),
              Text(
                'Ringkasan ulasan',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Montserrat',
                ),
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Icon(Icons.sentiment_very_satisfied, color: Colors.green),
                      Text('Sangat Baik', style: TextStyle(fontFamily: 'Montserrat')),
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      Icon(Icons.sentiment_satisfied, color: Colors.lightGreen),
                      Text('Baik', style: TextStyle(fontFamily: 'Montserrat')),
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      Icon(Icons.sentiment_neutral, color: Colors.amber),
                      Text('Buruk', style: TextStyle(fontFamily: 'Montserrat')),
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      Icon(Icons.sentiment_very_dissatisfied, color: Colors.red),
                      Text('Sangat Buruk', style: TextStyle(fontFamily: 'Montserrat')),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 20),
              Row(
                children: <Widget>[
                  CircleAvatar(
                    backgroundColor: Colors.grey.shade200,
                    child: Icon(Icons.person, color: Colors.black),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      'Ahmad Kiran\nPetunjuk arah yang diberikan sangat jelas dan akurat. Sebagai pengguna kursi roda saya merasa perjalanan jauh lebih mudah dan aman.',
                      style: TextStyle(fontSize: 14.0, fontFamily: 'Montserrat'),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Row(
                children: <Widget>[
                  CircleAvatar(
                    backgroundColor: Colors.grey.shade200,
                    child: Icon(Icons.person, color: Colors.black),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      'Viviane Angeli\nSebagai tunanetra, saya sangat terbantu. Rute yang direkomendasikan juga mempertimbangkan jalur yang aman dan mudah dilalui. Keren!',
                      style: TextStyle(fontSize: 14.0, fontFamily: 'Montserrat'),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Center(
                child: CustomButton(
                  text: 'Mulai perjalanan',
                  onPressed: () {
                    Navigator.pop(context);
                    onStartJourney();
                  },
                  backgroundColor: isSosReceived ? Colors.red : Colors.blue,
                  textColor: Colors.white,
                  fontSize: 20.0,
                  borderRadius: 20.0,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () => _showBottomSheet(context),
      onVerticalDragUpdate: (details) {
        if (details.primaryDelta! < -7) {
          _showBottomSheet(context);
        }
      },
      child: Align(
        alignment: Alignment.bottomCenter,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: Container(
              padding: EdgeInsets.all(10.0),
              width: width, 
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10.0,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    destinationAddress, 
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Montserrat',
                    ),
                  ),
                  SizedBox(height: 10),
                  Text('${placeDistance ?? '0.0'} km', style: TextStyle(fontFamily: 'Montserrat')),
                  SizedBox(height: 20),
                  CustomButton(
                    text: 'Mulai Perjalanan',
                    onPressed: () {
                      onStartJourney();
                    },
                    backgroundColor:  isSosReceived ? Colors.red : Colors.blue,
                    textColor: Colors.white,
                    fontSize: 20.0,
                    borderRadius: 20.0,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
