import 'package:flutter/material.dart';

class RegisterFlowController {
  final pageController = PageController();
  int currentStep = 0;

  void next() {
    currentStep++;
    pageController.animateToPage(
      currentStep,
      duration: const Duration(milliseconds: 300),
      curve: Curves.ease,
    );
  }

  void back() {
    if (currentStep > 0) {
      currentStep--;
      pageController.animateToPage(
        currentStep,
        duration: const Duration(milliseconds: 300),
        curve: Curves.ease,
      );
    }
  }

  void dispose() {
    pageController.dispose();
  }
}
