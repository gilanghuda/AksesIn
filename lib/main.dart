import 'package:aksesin/presentation/provider/auth_provider.dart';
import 'package:aksesin/presentation/view/app_route/app_route.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
import 'di/injection_container.dart' as di;
import 'package:aksesin/data/datasource/auth_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  di.setupDependencyInjection();

  runApp(const MyApp());
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
            authService: FirebaseAuthService()
          ),
        ),
        Provider<FirebaseAuthService>(
          create: (_) => di.sl<FirebaseAuthService>(),
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