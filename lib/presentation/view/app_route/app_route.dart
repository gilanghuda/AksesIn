import 'package:go_router/go_router.dart';
import 'package:aksesin/presentation/view/auth_view/login_screen.dart';
import 'package:aksesin/presentation/view/auth_view/register_screen.dart';
import 'package:aksesin/presentation/view/home_page/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';

final GoRouter router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) {
        final user = FirebaseAuth.instance.currentUser;
        if (user != null) {
          return const HomeScreen();
        } else {
          return LoginScreen();
        }
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
  ],
);
