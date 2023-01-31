import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class SingupController extends GetxController {
  TextEditingController fNameC = TextEditingController();
  TextEditingController sNameC = TextEditingController();
  TextEditingController uNameC = TextEditingController();
  TextEditingController emailC = TextEditingController();
  TextEditingController passwordC = TextEditingController();
  TextEditingController conpasswordC = TextEditingController();
  TextEditingController phoneC = TextEditingController();
  RxBool isLoading = false.obs;

  Future doSignUp() async {
    print("object");
    isLoading.value = true;
    var bodyParam = {
      "email": emailC.text,
      "first_name": fNameC.text,
      "last_name": sNameC.text,
      "username": uNameC.text,
      "password": passwordC.text,
      "confirm_password": conpasswordC.text,
      "phone_number": phoneC.text,
    };
    String url =
        'http://ec2-43-206-254-199.ap-northeast-1.compute.amazonaws.com/api/v1/auth/register/';
    var response = await http.post(Uri.parse(url), body: bodyParam);
    print(response.body);
    var decode = jsonDecode(response.body);
    if (response.statusCode == 200) {
      fNameC.clear();
      sNameC.clear();
      uNameC.clear();
      emailC.clear();
      passwordC.clear();
      conpasswordC.clear();
      phoneC.clear();

      Get.toNamed('/login');
      Get.snackbar("Singup", "User is Signup");
      isLoading.value = false;
    } else if (response.statusCode == 400) {
      if (decode['username'] == "Username already exists") {
        Get.snackbar("Error", "User', 'This user name already exist'");
      } else {
        Get.snackbar("Error",
            "This password is too common.', 'This password is entirely numeric.'");
      }

      isLoading.value = false;
    } else {
      Get.snackbar("Message", "Something Went wrong");
    }
  }
}
