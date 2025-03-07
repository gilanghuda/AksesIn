import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:aksesin/presentation/provider/auth_provider.dart';
import 'package:aksesin/presentation/widget/button.dart';
import 'package:aksesin/presentation/widget/styles.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginScreen> {
  bool _obscureText = true;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AuthProvider>();

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: 16),
                Center(
                  child: Image.asset(
                    'assets/images/logo_aksesin.png', 
                    height: 100,
                    width: 200,
                  ),
                ),
                Text(
                  'Selamat Datang di Aksesin',
                  textAlign: TextAlign.center,
                  style: AppTextStyles.heading1,
                ),
                const SizedBox(height: 8),
                Text(
                  '"Mobilitas tanpa batas! Temukan jalur terbaik dan akses inklusif di sini."',
                  textAlign: TextAlign.center,
                  style: AppTextStyles.hintText,
                ),
                const SizedBox(height: 15),
                Container(
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Log In',
                        style: AppTextStyles.heading2,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Email',
                        style: AppTextStyles.bodyText,
                      ),
                      const SizedBox(height: 4),
                      TextFormField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: AppColors.backgroundColor,
                          hintText: 'Masukkan Email Anda',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          prefixIcon: Icon(Icons.email_outlined),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Email tidak boleh kosong';
                          }
                          final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
                          if (!emailRegex.hasMatch(value)) {
                            return 'Format email tidak valid';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Password',
                        style: AppTextStyles.bodyText,
                      ),
                      const SizedBox(height: 4),
                      TextFormField(
                        controller: _passwordController,
                        obscureText: _obscureText,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: AppColors.backgroundColor,
                          hintText: 'Masukkan Password Anda',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          prefixIcon: Icon(Icons.lock_outline),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscureText ? Icons.visibility_off : Icons.visibility,
                            ),
                            onPressed: () {
                              setState(() {
                                _obscureText = !_obscureText;
                              });
                            },
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {
                            // forgot password ini nanti
                          },
                          child: Text(
                            'Lupa Password?',
                            style: TextStyle(color: AppColors.primaryColor),
                          ),
                        ),
                      ),
                      const SizedBox(height: 4),
                      SizedBox(
                        width: double.infinity,
                        child: authProvider.isLoading
                            ? Center(child: CircularProgressIndicator())
                            : Column(
                                children: [
                                  if (authProvider.errorMessage != null)
                                    Text(
                                      authProvider.errorMessage!,
                                      style: TextStyle(color: Colors.red),
                                    ),
                                  CustomButton(
                                    text: 'Masuk',
                                    onPressed: () {
                                      if (_formKey.currentState?.validate() ?? false) {
                                        authProvider.login(
                                          _emailController.text,
                                          _passwordController.text,
                                          context,
                                        );
                                      }
                                    },
                                  ),
                                ],
                              ),
                      ),
                      const SizedBox(height: 4),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Divider(color: AppColors.primaryColor),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text('Belum punya akun?'),
                          TextButton(
                            onPressed: () {
                              context.go('/register');
                            },
                            child: Text( 
                              'Sign Up', 
                              style: TextStyle(color: AppColors.primaryColor),),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Row(
                    children: [
                      Expanded(child: Divider(color: Colors.grey)),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Text(
                          'atau',
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
                      Expanded(child: Divider(color: Colors.grey)),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                OutlinedButton.icon(
                  onPressed: () {
                    authProvider.signInWithGoogle(context);
                  },
                  icon: Image.asset(
                    'assets/images/logo_google.png', 
                    height: 24,
                    width: 24,
                  ),
                  label: Text(
                    'Masuk dengan Google',
                    style: TextStyle(color: AppColors.primaryColor),
                  ),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    side: BorderSide(color: AppColors.primaryColor),
                  ),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }
}