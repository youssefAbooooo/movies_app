import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:movies_app/app_colors.dart';
import 'package:movies_app/cubits/login_cubit/login_cubit.dart';
import 'package:movies_app/views/home_screen.dart';
import 'package:movies_app/views/webview_approval_screen.dart';
import 'package:movies_app/widgets/login_button.dart';

class LoginScreen extends StatelessWidget {
  static String id = '/loginScreen';

  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocListener<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state is LoginRequestTokenReceived) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) =>
                    TMDBWebViewPage(requestToken: state.requestToken),
              ),
            );
          } else if (state is LoginSuccess) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (_) => const HomeScreen(),
              ),
            );
          } else if (state is LoginFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.error),
              ),
            );
          }
        },
        child: BlocBuilder<LoginCubit, LoginState>(
          builder: (context, state) {
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
                    if (state is LoginLoading)
                      const CircularProgressIndicator(color: AppColors.primary)
                    else ...[
                      LoginButton(
                        onPressed: () {
                          BlocProvider.of<LoginCubit>(context)
                              .getRequestToken();
                        },
                        text: 'Login With TMDB',
                      ),
                      if (state is LoginRequestTokenReceived)
                        LoginButton(
                          onPressed: () {
                            BlocProvider.of<LoginCubit>(context)
                                .completeLogin(state.requestToken);
                          },
                          text: 'Done',
                        ),
                    ]
                  ],
                )),
              ),
            );
          },
        ),
      ),
    );
  }
}
