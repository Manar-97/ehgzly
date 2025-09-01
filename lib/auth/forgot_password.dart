import 'package:ehgzly/auth/reset_password.dart';
import 'package:ehgzly/auth/verify_otp.dart';
import 'package:flutter/material.dart';
import 'api_services.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});
  static const String routeName = "forget";

  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController _email = TextEditingController();
  final ApiService _apiService = ApiService();
  bool _loading = false;

  Future<void> sendResetEmail() async {
    final emailText = _email.text.trim();
    if (emailText.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter your email")),
      );
      return;
    }

    setState(() => _loading = true);
    try {
      final res = await _apiService.forgotPassword(emailText);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(res['message'] ?? 'Success')),
      );

      Navigator.pushNamed(
        context,
        VerifyOtpScreen.routeName,
        arguments: emailText,
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );
    } finally {
      setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Forgot Password")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: _email,
              decoration: InputDecoration(
                labelText: "Email Address",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _loading ? null : sendResetEmail,
              child:
                  _loading
                      ? CircularProgressIndicator(color: Colors.white)
                      : Text("Send Reset Code"),
            ),
          ],
        ),
      ),
    );
  }
}
