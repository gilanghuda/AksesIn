import 'package:flutter/material.dart';

class OnboardingProvider with ChangeNotifier {
  final PageController pageController = PageController();
  int currentPage = 0;

  void nextPage() {
    if (currentPage < 3) {
      pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      currentPage++;
      notifyListeners();
    }
  }

  void previousPage() {
    if (currentPage > 0) {
      pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      currentPage--;
      notifyListeners();
    }
  }

  void jumpToPage(int page) {
    pageController.jumpToPage(page);
    currentPage = page;
    notifyListeners();
  }

  void setPage(int page) {
    currentPage = page;
    notifyListeners();
  }

  void resetOnboarding() {
    pageController.jumpToPage(0);
    currentPage = 0;
    notifyListeners();
  }
}
