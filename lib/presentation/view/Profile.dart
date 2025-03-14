import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  double _editButtonWidth = 250.0; // Default width for the edit button
  bool _isVibrationEnabled = false; // State for Fitur getar switch
  bool _isTalkbackEnabled = true; // State for Fitur talkback switch
  int currentIndex = 2; // Define currentIndex variable

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFFAFA), // Change background color to FFFAFA
      body: Stack(
        children: <Widget>[
          Container(
            height: 200,
            decoration: BoxDecoration(
              color: Color(0xFF0064D1),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: <Widget>[
                SizedBox(
                    height:
                        60), // Adjust the height to position the content below the AppBar
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Profil',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white, // Change color to black
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(8.0), // Reduce padding
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Row(
                    crossAxisAlignment:
                        CrossAxisAlignment.start, // Align items to the top
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 10), // Adjust top padding
                        child: CircleAvatar(
                          radius: 30, // Reduce profile picture size
                          backgroundImage:
                              AssetImage('assets/profile_picture.png'),
                        ),
                      ),
                      SizedBox(
                          width: 10), // Reduce space between picture and text
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left:
                                  10.0), // Add padding to move text to the right
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment:
                                MainAxisAlignment.center, // Center align text
                            children: <Widget>[
                              Text(
                                'Ahmad',
                                style: TextStyle(
                                  fontSize: 18, // Reduce font size
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Row(
                                children: [
                                  Icon(Icons.accessible_forward,
                                      size: 14,
                                      color: Color(
                                          0xFF666666)), // Change to blind person icon
                                  SizedBox(
                                      width:
                                          5), // Add space between icon and text
                                  Text(
                                    'Tuna Netra',
                                    style: TextStyle(
                                      fontSize: 14, // Reduce font size
                                      color: Color(
                                          0xFF666666), // Change color to 666666
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                'ahmadburhan@gmail.com',
                                style: TextStyle(
                                  fontSize: 14, // Reduce font size
                                  color: Color(
                                      0xFF666666), // Change color to 666666
                                ),
                              ),
                              SizedBox(height: 5), // Reduce space above button
                              SizedBox(
                                width: _editButtonWidth,
                                child: ElevatedButton(
                                  onPressed: () {
                                    // Handle edit profile
                                  },
                                  child: Text(
                                    'Edit Profil',
                                    style: TextStyle(
                                      color: Colors
                                          .white, // Change font color to white
                                    ),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Color(
                                        0xFF0064D1), // Change button color to 0064D1
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                          15.0), // Less rounded corners
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                SizedBox(height: 20), // Add whitespace above Pengaturan
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Pengaturan',
                    style: TextStyle(
                      fontSize: 22, // Change font size to 22
                      fontWeight: FontWeight.bold,
                      color: Colors.black, // Change color to black
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  padding: EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    children: <Widget>[
                      ListTile(
                        leading:
                            Icon(Icons.vibration, color: Color(0xFF0064D1)),
                        title: Text('Fitur getar',
                            style: TextStyle(color: Color(0xFF666666))),
                        trailing: Switch(
                          value: _isVibrationEnabled,
                          onChanged: (value) {
                            setState(() {
                              _isVibrationEnabled = value;
                            });
                          },
                          activeColor:
                              Colors.white, // Change circle color to white
                          activeTrackColor: Color(
                              0xFF0064D1), // Change background color to 0064D1
                          inactiveThumbColor: Colors
                              .white, // Change inactive circle color to white
                          inactiveTrackColor: Color(
                              0XFF9E9E9E), // Change inactive background color
                          // Remove materialTapTargetSize to remove outline
                        ),
                      ),
                      Divider(),
                      ListTile(
                        leading:
                            Icon(Icons.accessibility, color: Color(0xFF0064D1)),
                        title: Text('Fitur talkback',
                            style: TextStyle(color: Color(0xFF666666))),
                        trailing: Switch(
                          value: _isTalkbackEnabled,
                          onChanged: (value) {
                            setState(() {
                              _isTalkbackEnabled = value;
                            });
                          },
                          activeColor:
                              Colors.white, // Change circle color to white
                          activeTrackColor: Color(
                              0xFF0064D1), // Change background color to 0064D1
                          inactiveThumbColor: Colors
                              .white, // Change inactive circle color to white
                          inactiveTrackColor: Color(
                              0XFF9E9E9E), // Change inactive background color
                          // Remove materialTapTargetSize to remove outline
                        ),
                      ),
                      Divider(),
                      ListTile(
                        leading: Icon(Icons.history, color: Color(0xFF0064D1)),
                        title: Text('Riwayat Perjalanan',
                            style: TextStyle(color: Color(0xFF666666))),
                        trailing: Icon(Icons.arrow_forward_ios,
                            color: Color(0xFF0064D1)),
                        onTap: () {
                          // Handle navigation to history
                        },
                      ),
                      Divider(), // Add additional line under Riwayat Perjalanan
                      SizedBox(
                          height:
                              90), // Add more whitespace between "Keluar" button and Riwayat Perjalanan
                      ElevatedButton(
                        onPressed: () {
                          // Handle logout
                        },
                        child: Text('Keluar',
                            style: TextStyle(color: Color(0xFF0064D1))),
                        style: ElevatedButton.styleFrom(
                          side: BorderSide(
                              color: Color(0xFF0064D1)), // Add border color
                          backgroundColor:
                              Colors.white, // Change button background to white
                          minimumSize: Size(double.infinity, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Color(0xFFFFFAFA), // Change background color to FFFAFA
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, -3), // Shadow above the footer
            ),
          ],
        ),
        child: BottomNavigationBar(
          backgroundColor: Color(0xFFFFFAFA),
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.explore, size: 30), // Increase icon size
              label: 'AksesJalan',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.chat, size: 30), // Increase icon size
              label: 'AksesKomun',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person, size: 30), // Increase icon size
              label: 'Profil',
            ),
          ],
          currentIndex: currentIndex,
          selectedItemColor:
              Color(0xFF0064D1), // Change selected item color to 0064D1
          unselectedItemColor: Colors.grey,
          onTap: (index) {
            setState(() {
              // Update the current index to change the selected item
              currentIndex = index;
            });
          },
          selectedLabelStyle: TextStyle(
            color: Color(0xFF0064D1),
            fontSize: 16, // Increase label font size
          ),
          unselectedLabelStyle: TextStyle(
            color: Colors.grey,
            fontSize: 14, // Increase label font size
          ),
        ),
      ),
    );
  }
}
