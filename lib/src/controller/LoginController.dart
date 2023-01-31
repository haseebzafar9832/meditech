import 'dart:convert';

import 'package:e_commerce_flutter/src/controller/product_controller.dart';
import 'package:e_commerce_flutter/src/view/screen/Utils/Sharepreference.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class LoginController extends GetxController {
  ProductController controller = Get.put(ProductController());
  TextEditingController userNameC = TextEditingController();
  TextEditingController passwordC = TextEditingController();
  RxBool isLoading = false.obs;
  Future doSignin() async {
    isLoading.value = true;
    var bodyParam = {
      "username": userNameC.text,
      "password": passwordC.text,
    };
    String url =
        'http://ec2-43-206-254-199.ap-northeast-1.compute.amazonaws.com/api/v1/auth/login/';
    var response = await http.post(Uri.parse(url), body: bodyParam);
    if (response.statusCode == 200) {
      var decodeResponse = jsonDecode(response.body);
      // MyPrefferenc.saveId(decodeResponse['user']['id']);
      MyPrefferenc.savetoken(decodeResponse['token']);
      MyPrefferenc.saveId(decodeResponse['user']['id']);

      controller.profileData();
      userNameC.clear();
      passwordC.clear();
      Get.offAllNamed('/splash', arguments: [controller]);

      Get.snackbar("Login", "user is Login Successfully");

      print("Move kr gia h");
      isLoading.value = false;
    } else {
      isLoading.value = false;
      Get.snackbar("Error",
          "non_field_errors', 'Unable to log in with provided credentials'");
    }
  }
}
