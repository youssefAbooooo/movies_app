import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movies_app/services/authentication_service.dart';
import 'package:movies_app/views/home_screen.dart';
import 'package:movies_app/views/webview_approval_screen.dart';
import 'package:movies_app/widgets/login_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  static String id = '/loginScreen';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final authService = TMDBAuthService();
  String? requestToken;

  Future<void> loginWithTMDB() async {
    final token = await authService.getRequestToken();
    if (token != null) {
      requestToken = token;
      Navigator.push(
        // ignore: use_build_context_synchronously
        context,
        MaterialPageRoute(
          builder: (_) => TMDBWebViewPage(requestToken: token),
        ),
      );
    }
  }

  Future<void> completeLogin() async {
    if (requestToken != null) {
      final newSessionId = await authService.getSessionId(requestToken!);
      //storing the value of the token request
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('request_token', requestToken!);
      if (newSessionId != null) {
        //if the session id is not null, then store it
        prefs.setString('session_id', newSessionId);
        await authService.storeAccountDetails(newSessionId);
        //go to home screen after getting the session id
        Navigator.pushReplacement(
          // ignore: use_build_context_synchronously
          context,
          MaterialPageRoute(builder: (_) => HomeScreen()),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
            child: Column(
          spacing: 20,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(32.0),
              child: SvgPicture.asset(
                'assets/tmdb_logo.svg',
                height: 100,
                width: 100,
              ),
            ),
            LoginButton(
              onPressed: loginWithTMDB,
              text: 'Login With TMDB',
            ),
            if (requestToken != null)
              LoginButton(
                onPressed: completeLogin,
                text: 'Complete Login',
              ),
          ],
        )),
      ),
    );
  }
}
