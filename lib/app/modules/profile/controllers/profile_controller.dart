import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../providers/api.dart';

class ProfileController extends GetxController {
  var isLoading = true.obs;
  var user = {}.obs;

  @override
  void onInit() {
    super.onInit();
    fetchUserDetails();
  }

  Future<void> fetchUserDetails() async {
    try {
      //Get the token from SharedPreference
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      var token = localStorage.getString('token');

      // check token exists before
      if (token == null) {
        throw Exception('Token Not Found');
      }

      var headers = {'Authorization' : 'Bearer $token'};

      //perform user details API request
      var apiUrl = '/user';
      var response = await http.get(
        Uri.parse(Api.baseUrl + apiUrl),
        headers: headers,
      );

      if (response.statusCode == 200) {
        var apiResponse = json.decode(response.body);
        user.value = apiResponse;
      } else {
        throw Exception('Failed To Load User Details');
      }
    } catch (e) {
      print('Error during Fetching user Details: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> logout() async {
    try {
      //Clear token or user data from local strorage
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      localStorage.remove('token');
      localStorage.remove('user');

      //Navigate to login page
      Get.offAllNamed('/login');
    } catch (e) {
      print('Error during logout: $e');
    }
  }
}