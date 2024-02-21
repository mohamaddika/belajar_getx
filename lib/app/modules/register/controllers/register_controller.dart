// register_controller.dart

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../../providers/api.dart';

class RegisterController extends GetxController {
  final formKey = GlobalKey<FormState>();

  var name = ''.obs;
  var email = ''.obs;
  var password = ''.obs;
  var confirmPassword = ''.obs;

  void onNameChanged(String value) {
    name.value = value;
  }

  void onEmailChanged(String value) {
    email.value = value;
  }

  void onPasswordChanged(String value) {
    password.value = value;
  }
  void onconfirmPassword(String value) {
    confirmPassword.value = value;
  }

  Future<void> register() async {
    try {
      var response = await _performRegister();
      var responseBody = json.decode(response.body);

      if (response.statusCode == 201 && responseBody['success'] == true) {
        // Registration successful
        Get.offAllNamed('/bottom-menu'); // Redirect to login page
        Get.snackbar('Success', 'Registration successful');
      } else {
        // Registration failed, handle the error
        String errorMessage = responseBody['message'] ?? 'Registration failed';
        Get.snackbar('Error', errorMessage);
      }
    } catch (e) {
      // Handle other errors
      print('Error during registration: $e');
      Get.snackbar('Error', 'An error occurred during registration.');
    }
  }


  Future<http.Response> _performRegister() async {
    var apiUrl = '/register'; // Sesuaikan dengan endpoint registrasi Anda
    var requestBody = {
      'name': name.value, // Ubah dengan variabel name yang sesuai dengan implementasi Anda
      'email': email.value,
      'password': password.value,
      'password_confirmation': confirmPassword.value,
    };

    return await http.post(
      Uri.parse(Api.baseUrl + apiUrl),
      body: jsonEncode(requestBody),
      headers: {'Content-Type': 'application/json'},
    );
  }

  void _saveUserData(Map<String, dynamic> responseBody) async {
    // Implementation for saving user data to SharedPreferences
    // This could be similar to what you did in the LoginController
  }
}
