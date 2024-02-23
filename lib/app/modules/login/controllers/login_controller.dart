import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../../../providers/api.dart';

class LoginController extends GetxController {
  //TODO: Implement LoginController
  final formKey = GlobalKey<FormState>();

  var email = ''.obs;
  var password = ''.obs;

  void onEmailChanged(String value) {
    email.value = value;
  }

  void onPasswordChanged(String value) {
    password.value = value;
  }

  Future<void> login() async {
    try {
      var response = await _performLogin();
      var responseBody = json.decode(response.body);

      if (response.statusCode == 200 && responseBody['token'] != null) {
        // Login successful
        _saveUserData(responseBody);
        print('Token: ${responseBody['token']}'); // Cetak token di sini
        Get.offAllNamed('/buttom-menu'); // Navigate to the home page
      } else {
        // Login failed, handle the error
        Get.snackbar('Error', 'Login failed. ${responseBody['message']}');
      }
    } catch (e) {
      // Handle other errors
      print('Error during login: $e');
      Get.snackbar('Error', 'An error occurred during login.');
    }
  }


  Future<http.Response> _performLogin() async {
    var apiUrl = '/login';
    var requestBody = {'email': email.value, 'password': password.value};

    return await http.post(
      Uri.parse(Api.baseUrl + apiUrl),
      body: jsonEncode(requestBody),
      headers: {
        'Content-Type': 'application/json',
        "Access-Control-Allow-Origin": "*",
        'Accept': '*/*'
        },
    );
  }

  void _saveUserData(Map<String, dynamic> responseBody) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    localStorage.setString('token', responseBody['token']);
    localStorage.setString('user', json.encode(responseBody['user']));
  }
}
