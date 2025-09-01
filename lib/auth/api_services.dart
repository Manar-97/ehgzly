import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/foundation.dart';

class ApiService {
  static const String _baseUrl = 'http://192.168.8.174/coursephp/auth';

  // ----------------- Sign Up -----------------
  Future<dynamic> signUp(
    String username,
    String email,
    String password,
    String role,
  ) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/signup.php'),
        body: {
          'username': username,
          'email': email,
          'password': password,
          'role': role,
        },
      );

      final responseData = jsonDecode(response.body);
      if (response.statusCode == 200 && responseData['status'] == 'success') {
        return responseData;
      } else {
        debugPrint("❌ SignUp Error: ${responseData['message']}");
        throw Exception(responseData['message'] ?? 'Sign up failed');
      }
    } catch (e) {
      debugPrint("❌ Exception in signUp: $e");
      throw Exception('Error: $e');
    }
  }

  // ----------------- Login -----------------
  Future<dynamic> login(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/login.php'),
        body: {'email': email, 'password': password},
      );

      final responseData = jsonDecode(response.body);
      if (response.statusCode == 200 && responseData['status'] == 'success') {
        return responseData;
      } else {
        debugPrint("❌ Login Error: ${responseData['message']}");
        throw Exception(responseData['message'] ?? 'Login failed');
      }
    } catch (e) {
      debugPrint("❌ Exception in login: $e");
      throw Exception('Error: $e');
    }
  }

  // ----------------- Logout -----------------
  Future<dynamic> logout() async {
    try {
      final response = await http.post(Uri.parse('$_baseUrl/logout.php'));

      final responseData = jsonDecode(response.body);
      if (response.statusCode == 200 && responseData['status'] == 'success') {
        return responseData;
      } else {
        debugPrint("❌ Logout Error: ${responseData['message']}");
        throw Exception('Logout failed');
      }
    } catch (e) {
      debugPrint("❌ Exception in logout: $e");
      throw Exception('Error: $e');
    }
  }

  // ----------------- Forgot Password -----------------
  Future<Map<String, dynamic>> forgotPassword(String email) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/request_reset.php'),
        body: {'email': email},
      );

      debugPrint("Raw response: ${response.body}");

      final responseData = jsonDecode(response.body);
      if (responseData['status'] == 'success') {
        return responseData;
      } else {
        throw Exception(responseData['message'] ?? 'Request reset failed');
      }
    } catch (e) {
      debugPrint("❌ Exception in forgotPassword: $e");
      throw Exception('Error: $e');
    }
  }

  // ----------------- Verify Reset Code -----------------
  Future<Map<String, dynamic>> verifyResetCode(
    String email,
    String otp, // تم تعديل الاسم ليتوافق مع السيرفر
  ) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/verify_otp.php'),
        body: {'email': email, 'otp': otp},
      );

      final responseData = jsonDecode(response.body);
      if (responseData['status'] == 'success') {
        return responseData;
      } else {
        throw Exception(responseData['message'] ?? 'Invalid code');
      }
    } catch (e) {
      debugPrint("❌ Exception in verifyResetCode: $e");
      throw Exception('Error: $e');
    }
  }

  // ----------------- Reset Password -----------------
  Future<Map<String, dynamic>> resetPassword(
    String email,
    String newPassword, // تم تعديل الاسم ليتوافق مع السيرفر
  ) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/reset_password.php'),
        body: {'email': email, 'password': newPassword},
      );

      final responseData = jsonDecode(response.body);
      if (responseData['status'] == 'success') {
        return responseData;
      } else {
        throw Exception(responseData['message'] ?? 'Reset failed');
      }
    } catch (e) {
      debugPrint("❌ Exception in resetPassword: $e");
      throw Exception('Error: $e');
    }
  }
}
