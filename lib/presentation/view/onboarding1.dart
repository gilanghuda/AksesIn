import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Onboarding1 extends StatefulWidget {
  const Onboarding1({super.key});

  @override
  _Onboarding1State createState() => _Onboarding1State();
}

class _Onboarding1State extends State<Onboarding1> {
  final PageController pageController = PageController();
  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize:
            Size.fromHeight(100.0), // Increase the height of the AppBar
        child: AppBar(
          backgroundColor: const Color(0xFFC7E2FF), // Set AppBar color
          leading: Container(
            margin: const EdgeInsets.only(
                left: 17.0, top: 17.0), // Add margin to the left
            child: Stack(
              alignment: Alignment.center,
              clipBehavior: Clip.none, // Allow overflow
              children: [
                Positioned(
                  left: 2, // Adjust the left position
                  top: -2, // Adjust the top position
                  child: Container(
                    width: 40, // Width of the circle
                    height: 40, // Height of the circle
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xFF8AC2FF)
                          .withOpacity(0.25), // Circle with 25% opacity
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.arrow_back_ios_new_outlined,
                      color: Color(0xFFFFFFFF), size: 23),
                  onPressed: () {
                    // Swipe to the previous container
                    if (pageController.page! > 0) {
                      pageController.previousPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    }
                  },
                ),
              ],
            ),
          ),
          actions: [
            Container(
              margin: const EdgeInsets.only(
                  right: 17.0, top: 17.0), // Add margin to the right
              child: SizedBox(
                child: TextButton(
                  onPressed: () {
                    // Skip to the last container
                    pageController.jumpToPage(3);
                  },
                  child: const Text(
                    'Lewati',
                    style: TextStyle(
                      color: Color(0xFF007AFF), // Ensure text is visible
                      fontSize: 16, // Adjust font size
                      fontWeight: FontWeight.bold, // Adjust font weight
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      body: Container(
        padding: const EdgeInsets.only(),
        child: Column(
          children: [
            Expanded(
              child: PageView(
                controller: pageController,
                onPageChanged: (int page) {
                  setState(() {
                    currentPage = page;
                  });
                },
                children: [
                  Container(
                    color: const Color(0xFFC7E2FF),
                    child: Stack(
                      children: [
                        Align(
                          alignment: Alignment.topCenter,
                          child: Container(
                            margin: const EdgeInsets.only(
                                top: 50,
                                left: 20,
                                right: 20), // Adjust the margins as needed
                            child: Image.asset(
                              'assets/images/ob1.png', // Path to your image
                              width: 300, // Adjust the width as needed
                              height: 300, // Adjust the height as needed
                              fit: BoxFit
                                  .contain, // Use BoxFit.contain to prevent clipping
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: ClipPath(
                            clipper: UShapeClipper(),
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height / 2.25,
                              color: Colors.white,
                              child: Stack(
                                children: [
                                  Positioned(
                                    left: 0, // Customize left position
                                    right: 0, // Customize right position
                                    top: 85, // Customize top position
                                    child: Center(
                                      child: Text(
                                        'AksesJalan', // Customize header text
                                        style: TextStyle(
                                          fontSize: 25,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    left: 35, // Customize left position
                                    right: 35, // Customize right position
                                    top: 125, // Customize top position
                                    child: Center(
                                      child: Text(
                                        'Temukan jalur terbaik yang ramah untuk kursi roda, guiding blocks, dan aksesibilitas lainnya. Navigasi tanpa hambatan kini lebih mudah!', // Customize regular text
                                        style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.black,
                                        ),
                                        textAlign:
                                            TextAlign.center, // Justify tex
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    left: 0,
                                    right: 0,
                                    bottom: 185, // Customize top position
                                    child: Center(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: List.generate(4, (index) {
                                          return AnimatedContainer(
                                            duration: const Duration(
                                                milliseconds: 300),
                                            margin: const EdgeInsets.symmetric(
                                                horizontal: 4.0),
                                            width: currentPage == index
                                                ? 24.0
                                                : 8.0,
                                            height: 8.0,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(4.0),
                                              color: currentPage == index
                                                  ? const Color(0xFF007AFF)
                                                  : const Color(0xFFC7E2FF),
                                            ),
                                          );
                                        }),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    left: 0, // Customize left position
                                    right: 0, // Customize right position
                                    bottom: 90, // Customize bottom position
                                    child: CustomButton(
                                      onPressed: () {
                                        // Navigate to the next container
                                        pageController.nextPage(
                                          duration:
                                              const Duration(milliseconds: 300),
                                          curve: Curves.easeInOut,
                                        );
                                      },
                                      height: 60, // Customize height
                                      width: 365, // Customize width
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                            10), // Customize shape
                                      ),
                                      boxColor: Color(
                                          0XFFFAFAFA), // Customize box color
                                      outlineColor: Color(
                                          0xFF007AFF), // Customize outline color
                                      textStyle: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFF007AFF),
                                      ), // Customize text style
                                      child: const Text('Selanjutnya'),
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
                  Container(
                    color: const Color(0xFFC7E2FF),
                    child: Stack(
                      children: [
                        Align(
                          alignment: Alignment.topCenter,
                          child: Container(
                            margin: const EdgeInsets.only(
                                top: 50,
                                left: 20,
                                right: 20), // Adjust the margins as needed
                            child: Image.asset(
                              'assets/images/ob2.png', // Path to your image
                              width: 300, // Adjust the width as needed
                              height: 300, // Adjust the height as needed
                              fit: BoxFit
                                  .contain, // Use BoxFit.contain to prevent clipping
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: ClipPath(
                            clipper: UShapeClipper(),
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height / 2.25,
                              color: Colors.white,
                              child: Stack(
                                children: [
                                  Positioned(
                                    left: 0, // Customize left position
                                    right: 0, // Customize right position
                                    top: 85, // Customize top position
                                    child: Center(
                                      child: Text(
                                        'AksesTeman', // Customize header text
                                        style: TextStyle(
                                          fontSize: 25,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    left: 35, // Customize left position
                                    right: 35, // Customize right position
                                    top: 125, // Customize top position
                                    child: Center(
                                      child: Text(
                                        'Memastikan kamu tetap di jalur yang tepat dengan pelacak perjalanan dan lokasi secara real-time!', // Customize regular text
                                        style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.black,
                                        ),
                                        textAlign:
                                            TextAlign.center, // Justify tex
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    left: 0,
                                    right: 0,
                                    bottom: 185, // Customize top position
                                    child: Center(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: List.generate(4, (index) {
                                          return AnimatedContainer(
                                            duration: const Duration(
                                                milliseconds: 300),
                                            margin: const EdgeInsets.symmetric(
                                                horizontal: 4.0),
                                            width: currentPage == index
                                                ? 24.0
                                                : 8.0,
                                            height: 8.0,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(4.0),
                                              color: currentPage == index
                                                  ? const Color(0xFF007AFF)
                                                  : const Color(0xFFC7E2FF),
                                            ),
                                          );
                                        }),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    left: 0, // Customize left position
                                    right: 0, // Customize right position
                                    bottom: 90, // Customize bottom position
                                    child: CustomButton(
                                      onPressed: () {
                                        // Navigate to the next container
                                        pageController.nextPage(
                                          duration:
                                              const Duration(milliseconds: 300),
                                          curve: Curves.easeInOut,
                                        );
                                      },
                                      height: 60, // Customize height
                                      width: 365, // Customize width
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                            10), // Customize shape
                                      ),
                                      boxColor: Color(
                                          0XFFFAFAFA), // Customize box color
                                      outlineColor: Color(
                                          0xFF007AFF), // Customize outline color
                                      textStyle: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFF007AFF),
                                      ), // Customize text style
                                      child: const Text('Selanjutnya'),
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
                  Container(
                    color: const Color(0xFFC7E2FF),
                    child: Stack(
                      children: [
                        Align(
                          alignment: Alignment.topCenter,
                          child: Container(
                            margin: const EdgeInsets.only(
                                top: 50,
                                left: 20,
                                right: 20), // Adjust the margins as needed
                            child: Image.asset(
                              'assets/images/ob3.png', // Path to your image
                              width: 300, // Adjust the width as needed
                              height: 300, // Adjust the height as needed
                              fit: BoxFit
                                  .contain, // Use BoxFit.contain to prevent clipping
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: ClipPath(
                            clipper: UShapeClipper(),
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height / 2.25,
                              color: Colors.white,
                              child: Stack(
                                children: [
                                  Positioned(
                                    left: 0, // Customize left position
                                    right: 0, // Customize right position
                                    top: 85, // Customize top position
                                    child: Center(
                                      child: Text(
                                        'AksesDarurat', // Customize header text
                                        style: TextStyle(
                                          fontSize: 25,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    left: 35, // Customize left position
                                    right: 35, // Customize right position
                                    top: 125, // Customize top position
                                    child: Center(
                                      child: Text(
                                        'Hubungi kontak penting atau layanan darurat hanya dengan satu tombol. Keselamatanmu adalah prioritas kami.', // Customize regular text
                                        style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.black,
                                        ),
                                        textAlign:
                                            TextAlign.center, // Justify tex
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    left: 0,
                                    right: 0,
                                    bottom: 185, // Customize top position
                                    child: Center(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: List.generate(4, (index) {
                                          return AnimatedContainer(
                                            duration: const Duration(
                                                milliseconds: 300),
                                            margin: const EdgeInsets.symmetric(
                                                horizontal: 4.0),
                                            width: currentPage == index
                                                ? 24.0
                                                : 8.0,
                                            height: 8.0,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(4.0),
                                              color: currentPage == index
                                                  ? const Color(0xFF007AFF)
                                                  : const Color(0xFFC7E2FF),
                                            ),
                                          );
                                        }),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    left: 0, // Customize left position
                                    right: 0, // Customize right position
                                    bottom: 90, // Customize bottom position
                                    child: CustomButton(
                                      onPressed: () {
                                        // Navigate to the next container
                                        pageController.nextPage(
                                          duration:
                                              const Duration(milliseconds: 300),
                                          curve: Curves.easeInOut,
                                        );
                                      },
                                      height: 60, // Customize height
                                      width: 365, // Customize width
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                            10), // Customize shape
                                      ),
                                      boxColor: Color(
                                          0XFFFAFAFA), // Customize box color
                                      outlineColor: Color(
                                          0xFF007AFF), // Customize outline color
                                      textStyle: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFF007AFF),
                                      ), // Customize text style
                                      child: const Text('Selanjutnya'),
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
                  Container(
                    color: const Color(0xFFC7E2FF),
                    child: Stack(
                      children: [
                        Align(
                          alignment: Alignment.topCenter,
                          child: Container(
                            margin: const EdgeInsets.only(
                                top: 50,
                                left: 20,
                                right: 20), // Adjust the margins as needed
                            child: Image.asset(
                              'assets/images/ob4.png', // Path to your image
                              width: 300, // Adjust the width as needed
                              height: 300, // Adjust the height as needed
                              fit: BoxFit
                                  .contain, // Use BoxFit.contain to prevent clipping
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: ClipPath(
                            clipper: UShapeClipper(),
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height / 2.25,
                              color: Colors.white,
                              child: Stack(
                                children: [
                                  Positioned(
                                    left: 0, // Customize left position
                                    right: 0, // Customize right position
                                    top: 85, // Customize top position
                                    child: Center(
                                      child: Text(
                                        'AksesPandu', // Customize header text
                                        style: TextStyle(
                                          fontSize: 25,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    left: 35, // Customize left position
                                    right: 35, // Customize right position
                                    top: 125, // Customize top position
                                    child: Center(
                                      child: Text(
                                        'Navigasi lebih mudah dengan panduan suara dan getaran, dirancang khusus untuk penyandang tunanetra dan tunarungu.', // Customize regular text
                                        style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.black,
                                        ),
                                        textAlign:
                                            TextAlign.center, // Justify tex
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    left: 0,
                                    right: 0,
                                    bottom: 185, // Customize top position
                                    child: Center(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: List.generate(4, (index) {
                                          return AnimatedContainer(
                                            duration: const Duration(
                                                milliseconds: 300),
                                            margin: const EdgeInsets.symmetric(
                                                horizontal: 4.0),
                                            width: currentPage == index
                                                ? 24.0
                                                : 8.0,
                                            height: 8.0,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(4.0),
                                              color: currentPage == index
                                                  ? const Color(0xFF007AFF)
                                                  : const Color(0xFFC7E2FF),
                                            ),
                                          );
                                        }),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    left: 0, // Customize left position
                                    right: 0, // Customize right position
                                    bottom: 90, // Customize bottom position
                                    child: CustomButton(
                                      onPressed: () async {
                                        final prefs = await SharedPreferences.getInstance();
                                        await prefs.setBool('onboardingCompleted', true);
                                        context.go('/login');
                                      },
                                      height: 60, // Customize height
                                      width: 365, // Customize width
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                            10), // Customize shape
                                      ),
                                      boxColor: Color(
                                          0xFF007AFF), // Customize box color
                                      outlineColor: Color(
                                          0xFF007AFF), // Customize outline color
                                      textStyle: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0XFFFAFAFA),
                                      ), // Customize text style
                                      child: const Text('Mulai Aksesin'),
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomButton extends StatelessWidget {
  final VoidCallback onPressed;
  final double height;
  final double width;
  final OutlinedBorder shape;
  final Color boxColor;
  final Color outlineColor;
  final TextStyle textStyle;
  final Widget child;

  const CustomButton({super.key, 
    required this.onPressed,
    required this.height,
    required this.width,
    required this.shape,
    required this.boxColor,
    required this.outlineColor,
    required this.textStyle,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: height,
        width: width,
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: boxColor,
            side: BorderSide(color: outlineColor),
            shape: shape,
          ),
          child: DefaultTextStyle(
            style: textStyle,
            child: child,
          ),
        ),
      ),
    );
  }
}

class UShapeClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, 0);
    path.quadraticBezierTo(
        size.width / 2, 50, size.width, 0); // Curve outward at the top
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
