import 'package:flutter/material.dart';

import 'auth/forgot_password.dart';
import 'auth/login.dart';
import 'auth/register.dart';
import 'auth/reset_password.dart';
import 'auth/verify_otp.dart';
import 'home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Course PHP Rest API',
      initialRoute: LoginPage.routeName,
      routes: {
        HomePage.routeName: (_) => const HomePage(),
        LoginPage.routeName: (_) => const LoginPage(),
        SignUpPage.routeName: (_) => const SignUpPage(),
        ForgotPasswordScreen.routeName: (_) => const ForgotPasswordScreen(),
        VerifyOtpScreen.routeName: (context) {
          final args = ModalRoute.of(context)!.settings.arguments as String;
          return VerifyOtpScreen(email: args);
        },
        ResetPasswordScreen.routeName: (context) {
          final args = ModalRoute.of(context)!.settings.arguments as String;
          return ResetPasswordScreen(code: args);
        },
      },
    );
  }
}
