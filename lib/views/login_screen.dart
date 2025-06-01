import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movies_app/services/authentication_service.dart';
import 'package:movies_app/views/webview_approval_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  static String id = '/';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final authService = TMDBAuthService();
  String? sessionId;
  String? requestToken;

  Future<void> loginWithTMDB() async {
    final token = await authService.getRequestToken();
    if (token != null) {
      setState(() {
        requestToken = token;
      });
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
      if (newSessionId != null) {
        setState(() {
          sessionId = newSessionId;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: sessionId == null
              ? Column(
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
                    ElevatedButton(
                      onPressed: loginWithTMDB,
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.zero, // Remove default padding
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Ink(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [Color(0XFF8ECEA2), Color(0XFF07B5E3)],
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Container(
                          alignment: Alignment.center,
                          height: 50,
                          width: 200,
                          child: Text(
                            'Login with TMDB',
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ),
                    ),
                    if (requestToken != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 16.0),
                        child: ElevatedButton(
                          onPressed: completeLogin,
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.zero, // Remove default padding
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: Ink(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [Color(0XFF8ECEA2), Color(0XFF07B5E3)],
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Container(
                              alignment: Alignment.center,
                              height: 50,
                              width: 200,
                              child: Text(
                                'Complete Login',
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                          ),
                        ),
                      ),
                  ],
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Session ID:'),
                    SizedBox(height: 10),
                    Text(sessionId!, textAlign: TextAlign.center),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () => setState(() {
                        sessionId = null;
                        requestToken = null;
                      }),
                      child: Text('Logout'),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
