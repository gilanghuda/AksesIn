import 'package:aksesin/presentation/view/auth_view/dissability_screen.dart';
import 'package:aksesin/presentation/view/komunitas/komunitas_screen.dart';
import 'package:aksesin/presentation/view/komunitas/post_komunitas_screen.dart';
import 'package:aksesin/presentation/view/onboarding1.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:aksesin/presentation/view/auth_view/login_screen.dart';
import 'package:aksesin/presentation/view/auth_view/register_screen.dart';
import 'package:aksesin/presentation/view/home_page/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart'; 
import 'package:aksesin/presentation/view/komunitas/comment_komunitas.dart';

final GoRouter router = GoRouter(
  routes: [
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
              final bool? onboardingCompleted = prefs.getBool('onboardingCompleted');
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
      path: '/dissability',
      builder: (context, state) => const DissabilityScreen(option: ''),
    ),
    GoRoute(
      path: '/dissability/:option',
      builder: (context, state) {
        final option = state.pathParameters['option'] ?? '';
        return DissabilityScreen(option: option);
      },
    ),
    GoRoute(
      path: '/register',
      builder: (context, state) {
        final options = state.extra as List<String>?;
        return RegisterScreen(options: options);
      },
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
      path: '/komunitas',
      builder: (context, state) => const KomunitasScreen(),
    ),
    GoRoute(
      path: '/post-komunitas',
      builder: (context, state) => PostKomunitasScreen(),
    ),
    GoRoute(
      path: '/comments/:komunitasId',
      builder: (context, state) {
        final komunitasId = state.pathParameters['komunitasId']!;
        return CommentKomunitas(komunitasId: komunitasId);
      },
    ),
  ],
);
