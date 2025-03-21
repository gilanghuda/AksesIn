import 'package:aksesin/domain/usecases/get_notification.dart';
import 'package:aksesin/domain/usecases/track_user.dart';
import 'package:aksesin/presentation/provider/auth_provider.dart';
import 'package:aksesin/presentation/provider/maps_provider.dart';
import 'package:aksesin/presentation/provider/notification_provider.dart';
import 'package:aksesin/presentation/view/app_route/app_route.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
import 'di/injection_container.dart' as di;
import 'package:aksesin/data/datasource/auth_service.dart';
import 'package:aksesin/presentation/provider/onboarding_provider.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:aksesin/presentation/provider/komunitas_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  di.setupDependencyInjection();
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  runApp(const MyApp());

  Future.delayed(const Duration(seconds: 2), () {
    FlutterNativeSplash.remove(); 
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => AuthProvider(
              loginUser: di.sl(),
              registerUser: di.sl(),
              authService: FirebaseAuthService()),
        ),
        Provider<FirebaseAuthService>(
          create: (_) => di.sl<FirebaseAuthService>(),
        ),
        ChangeNotifierProvider(
          create: (_) => OnboardingProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => KomunitasProvider(
            getKomunitas: di.sl(),
            addKomunitas: di.sl(),
            updateKomunitas: di.sl(),
            getComments: di.sl(),
          ),
        ),
        ChangeNotifierProvider(
          create: (_) => di.sl<MapsProvider>(),
        ),
        Provider<TrackUserById>(
          create: (_) => di.sl<TrackUserById>(),
        ),
        ChangeNotifierProvider(
          create: (_) => NotificationProvider(
            getNotification: di.sl<GetNotification>(),
          ),
        ),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'aksesin',
        theme: ThemeData(primarySwatch: Colors.blue),
        routerConfig: router,
      ),
    );
  }
}
