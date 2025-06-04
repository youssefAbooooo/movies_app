import 'package:flutter/material.dart';
import 'package:movies_app/app_colors.dart';
import 'package:movies_app/services/account_datails_service.dart';
import 'package:movies_app/views/home_screen.dart';
import 'package:movies_app/views/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  static const String id = '/';

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      checkSession();
    });
  }

  Future<void> checkSession() async {
    await Future.delayed(const Duration(seconds: 1));

    final String? sessionId = AccountDetailsService().getSessionId();

    if (!mounted) return;

    if (sessionId == null) {
      Navigator.pushReplacementNamed(context, LoginScreen.id);
    } else {
      Navigator.pushReplacementNamed(context, HomeScreen.id);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: CircularProgressIndicator(color: AppColors.primary)),
    );
  }
}
