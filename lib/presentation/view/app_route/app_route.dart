import 'package:aksesin/presentation/view/OTP.dart';
import 'package:aksesin/presentation/view/Profile1.dart';
import 'package:aksesin/presentation/view/Resetpass.dart';
import 'package:aksesin/presentation/view/akses_jalan_detail/map_navigation.dart';
import 'package:aksesin/presentation/view/auth1.dart';
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
import 'package:provider/provider.dart';
import 'package:aksesin/presentation/provider/auth_provider.dart' as aksesin_auth;
import 'package:aksesin/presentation/view/pendamping_page/track_teman.dart';
import 'package:aksesin/presentation/view/pendamping_page/akses_teman.dart';
import 'package:aksesin/presentation/view/akses_jalan_detail/akses_jalan_detail.dart';

Future<String> getDisabilityOption(BuildContext context) async {
  final userProfile = await Provider.of<aksesin_auth.AuthProvider>(context, listen: false).getCurrentUserProfile();
  return userProfile.disabilityOptions.contains('Pendamping') ? 'Pendamping' : 'User';
}

final GoRouter router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) {
        return FutureBuilder(
          future: SharedPreferences.getInstance(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(),
              );
            } else {
              final prefs = snapshot.data as SharedPreferences;
              final bool? onboardingCompleted =
                  prefs.getBool('onboardingCompleted');
              final user = FirebaseAuth.instance.currentUser;
              if (onboardingCompleted == true) {
                if (user != null) {
                  return FutureBuilder(
                    future: getDisabilityOption(context),
                    builder: (context, userProfileSnapshot) {
                      if (userProfileSnapshot.connectionState == ConnectionState.waiting) {
                        return SizedBox(
                          width: 24,
                          height: 24,
                          child: CircularProgressIndicator(),
                        );
                      } else {
                        final disabilityOption = userProfileSnapshot.data as String;
                        return HomeScreen(isPendamping: disabilityOption == 'Pendamping');
                      }
                    },
                  );
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
      builder: (context, state) {
        return FutureBuilder(
          future: getDisabilityOption(context),
          builder: (context, userProfileSnapshot) {
            if (userProfileSnapshot.connectionState == ConnectionState.waiting) {
              return SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(),
              );
            } else {
              final disabilityOption = userProfileSnapshot.data as String;
              return HomeScreen(isPendamping: disabilityOption == 'Pendamping');
            }
          },
        );
      },
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
    GoRoute(
      path: '/forgot-password',
      builder: (context, state) => const forgotpass(),
    ),
    GoRoute(
      path: '/otp-page',
      builder: (context, state) => const OTP(),
    ),
    GoRoute(
      path: '/resetpass',
      builder: (context, state) => const Resetpass(),
    ),
    GoRoute(
      path: '/edit-profile',
      builder: (context, state) => const Profile1(),
    ),
    GoRoute(
      path: '/map',
      builder: (context, state) {
        final destinationAddress = state.extra as String?;
        return MapView(destinationAddress: destinationAddress);
      },
    ),
    GoRoute(
      path: '/track-teman',
      builder: (context, state) {
        final userId = state.extra as String;
        return TrackTemanPage(userId: userId);
      },
    ),
    GoRoute(
      path: '/akses-teman',
      builder: (context, state) => AksesTemanScreen(),
    ),
    GoRoute(
      path: '/akses-jalan-detail',
      builder: (context, state) {
        final location = state.extra as String? ?? '';
        return AksesJalanDetailScreen(location: location);
      },
    ),
  ],
);
