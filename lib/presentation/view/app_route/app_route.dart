import 'package:aksesin/presentation/view/onboarding1.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:aksesin/presentation/view/auth_view/login_screen.dart';
import 'package:aksesin/presentation/view/auth_view/register_screen.dart';
import 'package:aksesin/presentation/view/home_page/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:aksesin/presentation/view/auth1.dart'; // Import the auth1.dart file

final GoRouter router = GoRouter(
  routes: [
    // GoRoute(path: '/',
    // builder: (context, state) => const SplashScreen(),
    // ),
    GoRoute(
      path: '/',
      builder: (context, state) {
        return FutureBuilder(
          future: SharedPreferences.getInstance(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else {
              final prefs = snapshot.data as SharedPreferences;
              final bool? onboardingCompleted =
                  prefs.getBool('onboardingCompleted');
              final user = FirebaseAuth.instance.currentUser;
              if (onboardingCompleted == true) {
                if (user != null) {
                  return const HomeScreen();
                } else {
                  return const LoginScreen();
                }
              } else {
                return const Onboarding1();
              }
            }
          },
        );
      },
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: '/register',
      builder: (context, state) => const RegisterScreen(),
    ),
    GoRoute(
      path: '/home',
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: '/onboarding',
      builder: (context, state) => const Onboarding1(),
    ),
    GoRoute(
      path: '/auth1',
      builder: (context, state) => const forgotpass(), // Add this line
    ),
  ],
);
