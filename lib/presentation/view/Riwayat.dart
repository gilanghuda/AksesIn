import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart'; // Add this import

class Riwayat extends StatelessWidget {
  const Riwayat({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_outlined, color: Colors.white),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Spacer(),
            Text(
              'Riwayat Perjalanan',
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            Spacer(flex: 2),
          ],
        ),
        backgroundColor: const Color(0xFF007AFF),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                    vertical: 7, horizontal: 24), // Adjusted padding
                decoration: BoxDecoration(
                  color: Color(0XFFEBEBEB), // Changed from primary
                  borderRadius: BorderRadius.circular(15),
                ),
                child: const Text(
                  'Hari ini',
                  style: TextStyle(
                    color: Color(0XFF0064D1), // Changed from onPrimary
                    fontSize: 14, // Adjusted font size
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                elevation: 4,
                child: SizedBox(
                  height: 143, // Adjusted height
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 8.0,
                        right: 8.0, // Reduced right padding
                        top: 8.0, // Reduced top padding
                        bottom: 8.0), // Reduced bottom padding
                    child: Row(
                      crossAxisAlignment:
                          CrossAxisAlignment.center, // Center elements vertically
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment
                              .center, // Center elements vertically
                          children: [
                            Icon(Icons.location_on_outlined,
                                color: Colors.blue,
                                size: 20), // Adjusted icon size
                            const SizedBox(height: 2), // Reduced spacing
                            Column(
                              children: List.generate(
                                  4, // Changed to 4 dots
                                  (index) => Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical:
                                                2.5), // Reduced vertical padding
                                        child: Icon(Icons.circle,
                                            size: 3,
                                            color: Color(
                                                0XFF858585)), // Adjusted icon size
                                      )),
                            ),
                            const SizedBox(height: 2), // Reduced spacing
                            Icon(Icons.place,
                                color: Colors.blue,
                                size: 20), // Adjusted icon size
                            const SizedBox(height: 2), // Reduced spacing
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 22.0), // Reduced top padding
                              child: Icon(Icons.directions_walk,
                                  color: Color(0XFF858585),
                                  size: 25), // Adjusted icon size
                            ),
                            const SizedBox(height: 2), // Reduced spacing
                          ],
                        ),
                        const SizedBox(width: 4), // Reduced spacing
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment
                                .center, // Center elements vertically
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text('Edutech Garden FILKOM UB',
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight
                                                    .bold)), // Adjusted font size and made bold
                                        Text('12:10',
                                            style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight
                                                    .bold)), // Adjusted font size and made bold
                                        const Divider(), // Added static line
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 4), // Reduced spacing
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text('Malang Town Square',
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight
                                                    .bold)), // Adjusted font size and made bold
                                        Text('12:25',
                                            style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight
                                                    .bold)), // Adjusted font size and made bold
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 4), // Reduced spacing
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 4.0), // Reduced top padding
                                    child: Row(
                                      children: [
                                        Text('1,1 km',
                                            style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight
                                                    .bold)), // Adjusted font size and made bold
                                        const SizedBox(
                                            width: 10), // Reduced spacing
                                        Icon(Icons.access_time,
                                            color: Color(0XFF858585),
                                            size: 25), // Adjusted icon size
                                        const SizedBox(
                                            width: 10), // Reduced spacing
                                        Text('15 menit',
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight
                                                    .bold)), // Adjusted font size and made bold
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 4), // Reduced spacing
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Container(
                            width: 93, // Adjusted width
                            height: 89, // Adjusted height
                            child: Image.asset(
                              'assets/images/placeholder.png', // Use a local asset image
                              fit: BoxFit
                                  .cover, // Ensure the image fits within the box
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8), // Reduced spacing
              Container(
                padding: const EdgeInsets.symmetric(
                    vertical: 7, horizontal: 24), // Adjusted padding
                decoration: BoxDecoration(
                  color: Color(0XFFEBEBEB), // Changed from primary
                  borderRadius: BorderRadius.circular(15),
                ),
                child: const Text(
                  'Kemarin',
                  style: TextStyle(
                    color: Color(0XFF0064D1), // Changed from onPrimary
                    fontSize: 14, // Adjusted font size
                  ),
                ),
              ),
              const SizedBox(height: 8), // Reduced spacing
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                elevation: 4,
                child: SizedBox(
                  height: 143, // Adjusted height
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 8.0,
                        right: 8.0, // Reduced right padding
                        top: 8.0, // Reduced top padding
                        bottom: 8.0), // Reduced bottom padding
                    child: Row(
                      crossAxisAlignment:
                          CrossAxisAlignment.center, // Center elements vertically
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment
                              .center, // Center elements vertically
                          children: [
                            Icon(Icons.location_on_outlined,
                                color: Colors.blue,
                                size: 20), // Adjusted icon size
                            const SizedBox(height: 2), // Reduced spacing
                            Column(
                              children: List.generate(
                                  4, // Changed to 4 dots
                                  (index) => Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical:
                                                2.5), // Reduced vertical padding
                                        child: Icon(Icons.circle,
                                            size: 3,
                                            color: Color(
                                                0XFF858585)), // Adjusted icon size
                                      )),
                            ),
                            const SizedBox(height: 2), // Reduced spacing
                            Icon(Icons.place,
                                color: Colors.blue,
                                size: 20), // Adjusted icon size
                            const SizedBox(height: 2), // Reduced spacing
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 22.0), // Reduced top padding
                              child: Icon(Icons.directions_walk,
                                  color: Color(0XFF858585),
                                  size: 25), // Adjusted icon size
                            ),
                            const SizedBox(height: 2), // Reduced spacing
                          ],
                        ),
                        const SizedBox(width: 4), // Reduced spacing
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment
                                .center, // Center elements vertically
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text('Edutech Garden FILKOM UB',
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight
                                                    .bold)), // Adjusted font size and made bold
                                        Text('12:10',
                                            style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight
                                                    .bold)), // Adjusted font size and made bold
                                        const Divider(), // Added static line
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 4), // Reduced spacing
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text('Malang Town Square',
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight
                                                    .bold)), // Adjusted font size and made bold
                                        Text('12:25',
                                            style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight
                                                    .bold)), // Adjusted font size and made bold
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 4), // Reduced spacing
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 4.0), // Reduced top padding
                                    child: Row(
                                      children: [
                                        Text('1,1 km',
                                            style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight
                                                    .bold)), // Adjusted font size and made bold
                                        const SizedBox(
                                            width: 10), // Reduced spacing
                                        Icon(Icons.access_time,
                                            color: Color(0XFF858585),
                                            size: 25), // Adjusted icon size
                                        const SizedBox(
                                            width: 10), // Reduced spacing
                                        Text('15 menit',
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight
                                                    .bold)), // Adjusted font size and made bold
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 4), // Reduced spacing
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Container(
                            width: 93, // Adjusted width
                            height: 89, // Adjusted height
                            child: Image.asset(
                              'assets/images/placeholder.png', // Use a local asset image
                              fit: BoxFit
                                  .cover, // Ensure the image fits within the box
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8), // Reduced spacing
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                elevation: 4,
                child: SizedBox(
                  height: 143, // Adjusted height
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 8.0,
                        right: 8.0, // Reduced right padding
                        top: 8.0, // Reduced top padding
                        bottom: 8.0), // Reduced bottom padding
                    child: Row(
                      crossAxisAlignment:
                          CrossAxisAlignment.center, // Center elements vertically
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment
                              .center, // Center elements vertically
                          children: [
                            Icon(Icons.location_on_outlined,
                                color: Colors.blue,
                                size: 20), // Adjusted icon size
                            const SizedBox(height: 2), // Reduced spacing
                            Column(
                              children: List.generate(
                                  4, // Changed to 4 dots
                                  (index) => Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical:
                                                2.5), // Reduced vertical padding
                                        child: Icon(Icons.circle,
                                            size: 3,
                                            color: Color(
                                                0XFF858585)), // Adjusted icon size
                                      )),
                            ),
                            const SizedBox(height: 2), // Reduced spacing
                            Icon(Icons.place,
                                color: Colors.blue,
                                size: 20), // Adjusted icon size
                            const SizedBox(height: 2), // Reduced spacing
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 22.0), // Reduced top padding
                              child: Icon(Icons.directions_walk,
                                  color: Color(0XFF858585),
                                  size: 25), // Adjusted icon size
                            ),
                            const SizedBox(height: 2), // Reduced spacing
                          ],
                        ),
                        const SizedBox(width: 4), // Reduced spacing
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment
                                .center, // Center elements vertically
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text('Edutech Garden FILKOM UB',
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight
                                                    .bold)), // Adjusted font size and made bold
                                        Text('12:10',
                                            style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight
                                                    .bold)), // Adjusted font size and made bold
                                        const Divider(), // Added static line
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 4), // Reduced spacing
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text('Malang Town Square',
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight
                                                    .bold)), // Adjusted font size and made bold
                                        Text('12:25',
                                            style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight
                                                    .bold)), // Adjusted font size and made bold
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 4), // Reduced spacing
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 4.0), // Reduced top padding
                                    child: Row(
                                      children: [
                                        Text('1,1 km',
                                            style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight
                                                    .bold)), // Adjusted font size and made bold
                                        const SizedBox(
                                            width: 10), // Reduced spacing
                                        Icon(Icons.access_time,
                                            color: Color(0XFF858585),
                                            size: 25), // Adjusted icon size
                                        const SizedBox(
                                            width: 10), // Reduced spacing
                                        Text('15 menit',
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight
                                                    .bold)), // Adjusted font size and made bold
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 4), // Reduced spacing
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Container(
                            width: 93, // Adjusted width
                            height: 89, // Adjusted height
                            child: Image.asset(
                              'assets/images/placeholder.png', // Use a local asset image
                              fit: BoxFit
                                  .cover, // Ensure the image fits within the box
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8), // Reduced spacing
              Container(
                padding: const EdgeInsets.symmetric(
                    vertical: 7, horizontal: 24), // Adjusted padding
                decoration: BoxDecoration(
                  color: Color(0XFFEBEBEB), // Changed from primary
                  borderRadius: BorderRadius.circular(15),
                ),
                child: const Text(
                  '10 Maret 2025',
                  style: TextStyle(
                    color: Color(0XFF0064D1), // Changed from onPrimary
                    fontSize: 14, // Adjusted font size
                  ),
                ),
              ),
              const SizedBox(height: 8), // Reduced spacing
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                elevation: 4,
                child: SizedBox(
                  height: 143, // Adjusted height
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 8.0,
                        right: 8.0, // Reduced right padding
                        top: 8.0, // Reduced top padding
                        bottom: 8.0), // Reduced bottom padding
                    child: Row(
                      crossAxisAlignment:
                          CrossAxisAlignment.center, // Center elements vertically
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment
                              .center, // Center elements vertically
                          children: [
                            Icon(Icons.location_on_outlined,
                                color: Colors.blue,
                                size: 20), // Adjusted icon size
                            const SizedBox(height: 2), // Reduced spacing
                            Column(
                              children: List.generate(
                                  4, // Changed to 4 dots
                                  (index) => Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical:
                                                2.5), // Reduced vertical padding
                                        child: Icon(Icons.circle,
                                            size: 3,
                                            color: Color(
                                                0XFF858585)), // Adjusted icon size
                                      )),
                            ),
                            const SizedBox(height: 2), // Reduced spacing
                            Icon(Icons.place,
                                color: Colors.blue,
                                size: 20), // Adjusted icon size
                            const SizedBox(height: 2), // Reduced spacing
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 22.0), // Reduced top padding
                              child: Icon(Icons.directions_walk,
                                  color: Color(0XFF858585),
                                  size: 25), // Adjusted icon size
                            ),
                            const SizedBox(height: 2), // Reduced spacing
                          ],
                        ),
                        const SizedBox(width: 4), // Reduced spacing
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment
                                .center, // Center elements vertically
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text('Edutech Garden FILKOM UB',
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight
                                                    .bold)), // Adjusted font size and made bold
                                        Text('12:10',
                                            style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight
                                                    .bold)), // Adjusted font size and made bold
                                        const Divider(), // Added static line
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 4), // Reduced spacing
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text('Malang Town Square',
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight
                                                    .bold)), // Adjusted font size and made bold
                                        Text('12:25',
                                            style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight
                                                    .bold)), // Adjusted font size and made bold
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 4), // Reduced spacing
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 4.0), // Reduced top padding
                                    child: Row(
                                      children: [
                                        Text('1,1 km',
                                            style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight
                                                    .bold)), // Adjusted font size and made bold
                                        const SizedBox(
                                            width: 10), // Reduced spacing
                                        Icon(Icons.access_time,
                                            color: Color(0XFF858585),
                                            size: 25), // Adjusted icon size
                                        const SizedBox(
                                            width: 10), // Reduced spacing
                                        Text('15 menit',
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight
                                                    .bold)), // Adjusted font size and made bold
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 4), // Reduced spacing
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Container(
                            width: 93, // Adjusted width
                            height: 89, // Adjusted height
                            child: Image.asset(
                              'assets/images/placeholder.png', // Use a local asset image
                              fit: BoxFit
                                  .cover, // Ensure the image fits within the box
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
