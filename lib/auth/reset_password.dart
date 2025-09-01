import 'package:ehgzly/auth/login.dart';
import 'package:flutter/material.dart';
import 'api_services.dart';

class ResetPasswordScreen extends StatefulWidget {
  final String code;
  const ResetPasswordScreen({super.key, required this.code});
  static const String routeName = "reset";

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final TextEditingController _passwordController = TextEditingController();
  final ApiService _apiService = ApiService();
  bool _loading = false;

  void _submit() async {
    setState(() => _loading = true);
    try {
      final res = await _apiService.resetPassword(
        _passwordController.text.trim(),
        widget.code
      );
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(res['message'])));
      Navigator.pushReplacementNamed(context, LoginPage.routeName);
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(e.toString())));
    }
    setState(() => _loading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Reset Password")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: "New Password",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _loading ? null : _submit,
              child:
                  _loading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text("Reset Password"),
            ),
          ],
        ),
      ),
    );
  }
}
