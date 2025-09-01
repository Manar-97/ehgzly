import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/foundation.dart';

class ApiService {
  static const String _baseUrl = 'http://192.168.8.174/coursephp/auth';

  // ----------------- Helper Method -----------------
  dynamic _handleResponse(http.Response response, String methodName) {
    debugPrint("📩 [$methodName] Raw response: ${response.body}");

    if (response.body.isEmpty) {
      throw Exception("❌ [$methodName] Empty response from server");
    }

    try {
      final responseData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        if (responseData['status'] == 'success') {
          return responseData;
        } else {
          throw Exception(responseData['message'] ?? "❌ [$methodName] Failed");
        }
      } else {
        throw Exception("❌ [$methodName] Server error: ${response.statusCode}");
      }
    } catch (e) {
      debugPrint("❌ [$methodName] JSON decode error: $e");
      throw Exception("❌ [$methodName] Invalid JSON response");
    }
  }

  // ----------------- Sign Up -----------------
  Future<Map<String, dynamic>> signUp(
    String username,
    String email,
    String password,
    String role,
  ) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/signup.php'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'username': username,
          'email': email,
          'password': password,
          'role': role,
        }),
      );
      return _handleResponse(response, "signUp");
    } catch (e) {
      debugPrint("❌ Exception in signUp: $e");
      rethrow;
    }
  }

  // ----------------- Login -----------------
  Future<Map<String, dynamic>> login(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/login.php'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'password': password}),
      );
      return _handleResponse(response, "login");
    } catch (e) {
      debugPrint("❌ Exception in login: $e");
      rethrow;
    }
  }

  // ----------------- Logout -----------------
  Future<Map<String, dynamic>> logout() async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/logout.php'),
        headers: {'Content-Type': 'application/json'},
      );
      return _handleResponse(response, "logout");
    } catch (e) {
      debugPrint("❌ Exception in logout: $e");
      rethrow;
    }
  }

  // ----------------- Forgot Password -----------------
  Future<Map<String, dynamic>> forgotPassword(String email) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/request_reset.php'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email}),
      );
      return _handleResponse(response, "forgotPassword");
    } catch (e) {
      debugPrint("❌ Exception in forgotPassword: $e");
      rethrow;
    }
  }

  // ----------------- Verify Reset Code -----------------
  Future<Map<String, dynamic>> verifyResetCode(String email, String otp) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/verify_otp.php'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'otp': otp}),
      );
      return _handleResponse(response, "verifyResetCode");
    } catch (e) {
      debugPrint("❌ Exception in verifyResetCode: $e");
      rethrow;
    }
  }

  // ----------------- Reset Password -----------------
  Future<Map<String, dynamic>> resetPassword(
    String email,
    String code,
    String newPassword,
  ) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/reset_password.php'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'email': email,
          "otp": code,
          'password': newPassword,
        }),
      );
      return _handleResponse(response, "resetPassword");
    } catch (e) {
      debugPrint("❌ Exception in resetPassword: $e");
      rethrow;
    }
  }
}
