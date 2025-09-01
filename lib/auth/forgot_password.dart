import 'package:ehgzly/auth/verify_otp.dart';
import 'package:flutter/material.dart';
import '../components/customtextform.dart';
import 'api_services.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});
  static const String routeName = "forget";

  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _email = TextEditingController();
  final ApiService _apiService = ApiService();
  bool _loading = false;

  Future<void> sendResetEmail() async {
    final emailText = _email.text.trim();
    if (emailText.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Please enter your email")));
      return;
    }

    setState(() => _loading = true);
    try {
      final res = await _apiService.forgotPassword(emailText);
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(res['message'] ?? 'Success')));

      Navigator.pushNamed(
        context,
        VerifyOtpScreen.routeName,
        arguments: emailText,
      );
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(e.toString())));
    } finally {
      setState(() => _loading = false);
    }
  }

  @override
  void dispose() {
    _email.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xFFC2EFFA), Color(0xFFFFFFFF)],
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                   Text(
                    "Enter your e-mail to get otp code",
                    style: TextStyle(fontSize: 20,color: Colors.grey[600]),
                  ),SizedBox(
                    height: MediaQuery.of(context).size.height * 0.05,
                  ),
                  CustomTextForm(
                    controller: _email,
                    hintText: 'E-mail',
                    label: 'E-mail',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter email';
                      }
                      return null;
                    },
                    suffixIcon: Icon(Icons.email,color: Colors.grey[600]),
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.5,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: _loading ? null : sendResetEmail,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                        ),
                        child:
                            _loading
                                ? CircularProgressIndicator(color: Colors.white)
                                : Text(
                                  "Send Reset Code",
                                  style: TextStyle(color: Colors.white),
                                ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
