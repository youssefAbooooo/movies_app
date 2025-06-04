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
  Future<void> checkSession() async {
    final String? sessionId = AccountDetailsService().getSessionId();

    if (sessionId == null) {
      Navigator.pushReplacementNamed(
        // ignore: use_build_context_synchronously
        context, LoginScreen.id,
      );
    } else {
      Navigator.pushReplacementNamed(
        // ignore: use_build_context_synchronously
        context, HomeScreen.id,
      );
    }
  }

  @override
  void initState() {
    super.initState();
    checkSession();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: CircularProgressIndicator(color: AppColors.primary)),
    );
  }
}
