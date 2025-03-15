import 'package:flutter/material.dart';

class Profile1 extends StatefulWidget {
  const Profile1({super.key});
  @override
  _ProfileState1 createState() => _ProfileState1();
}

class _ProfileState1 extends State<Profile1> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  Color _buttonColor = Color(0xFFCFCFCF); // Initial button color
  Color _nameFieldBorderColor =
      Colors.grey; // Initial border color for name field
  Color _nameFieldIconColor = Colors.grey; // Initial icon color for name field
  Color _emailFieldBorderColor =
      Colors.grey; // Initial border color for email field
  Color _emailFieldIconColor =
      Colors.grey; // Initial icon color for email field
  int currentIndex = 0; // Initial index for BottomNavigationBar

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFFAFA),
      body: SingleChildScrollView(
        child: Stack(
          children: <Widget>[
            Container(
              height: 270,
              decoration: BoxDecoration(
                color: Color(0xFF0064D1),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
            ),
            Positioned(
              top: 80, // Move the back button 50px more
              left: 16,
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0XFFFFFAFA),
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  icon: Icon(Icons.arrow_back_ios_new_outlined,
                      color: Color(0xFF0064D1), size: 23),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ),
            ),
            Positioned(
              top: 140, // Position the label 15px above the main container
              left: 26,
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Edit Profil',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: <Widget>[
                  SizedBox(height: 60),
                  SizedBox(height: 15), // Add 15px of space above the main box
                  Container(
                    margin: EdgeInsets.only(
                        top: 92), // Lower the container 92 px down
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
                        Center(
                          child: Stack(
                            children: [
                              CircleAvatar(
                                radius: 50,
                                backgroundImage:
                                    AssetImage('assets/profile_picture.png'),
                              ),
                              Positioned(
                                bottom: 0,
                                right: 0,
                                child: CircleAvatar(
                                  radius: 15,
                                  backgroundColor: Colors.white,
                                  child: Icon(
                                    Icons.edit,
                                    color: Color(0xFF0064D1),
                                    size: 18,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 20),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Nama Pengguna',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(height: 5),
                        Container(
                          height: 45, // Make the text box smaller
                          child: Focus(
                            onFocusChange: (hasFocus) {
                              setState(() {
                                if (hasFocus) {
                                  _nameFieldBorderColor = Color(0xFF0064D1);
                                  _nameFieldIconColor = Color(0xFF0064D1);
                                } else {
                                  _nameFieldBorderColor = Colors.grey;
                                  _nameFieldIconColor = Colors.grey;
                                }
                              });
                            },
                            child: TextField(
                              controller: _nameController,
                              decoration: InputDecoration(
                                hintText: 'Masukkan nama pengguna',
                                hintStyle: TextStyle(
                                    height: 1.5), // Center the placeholder text
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 10), // Adjust vertical padding
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide:
                                      BorderSide(color: _nameFieldBorderColor),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide:
                                      BorderSide(color: _nameFieldBorderColor),
                                ),
                                prefixIcon: Icon(Icons.person,
                                    color: _nameFieldIconColor),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Email',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(height: 5),
                        Container(
                          height: 45, // Make the text box smaller
                          child: Focus(
                            onFocusChange: (hasFocus) {
                              setState(() {
                                if (hasFocus) {
                                  _emailFieldBorderColor = Color(0xFF0064D1);
                                  _emailFieldIconColor = Color(0xFF0064D1);
                                } else {
                                  _emailFieldBorderColor = Colors.grey;
                                  _emailFieldIconColor = Colors.grey;
                                }
                              });
                            },
                            child: TextField(
                              controller: _emailController,
                              decoration: InputDecoration(
                                hintText: 'Masukkan email',
                                hintStyle: TextStyle(
                                    height: 1.5), // Center the placeholder text
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 10), // Adjust vertical padding
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide:
                                      BorderSide(color: _emailFieldBorderColor),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide:
                                      BorderSide(color: _emailFieldBorderColor),
                                ),
                                prefixIcon: Icon(Icons.email,
                                    color: _emailFieldIconColor),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 140), // Add 50px of whitespace
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              _buttonColor = Color(
                                  0xFF0064D1); // Change button color to blue
                            });
                            Future.delayed(Duration(milliseconds: 100), () {
                              setState(() {
                                _buttonColor = Color(
                                    0xFFCFCFCF); // Change back to base color
                              });
                            });
                          },
                          child: Text(
                            'Simpan Perubahan',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18, // Make the label bigger
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                _buttonColor, // Use the dynamic button color
                            minimumSize: Size(
                                312, 45), // Set button dimensions to 312x45
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
