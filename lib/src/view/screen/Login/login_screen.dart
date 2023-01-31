import 'package:e_commerce_flutter/src/controller/LoginController.dart';
import 'package:e_commerce_flutter/src/controller/product_controller.dart';
import 'package:e_commerce_flutter/src/view/screen/Signup/components/TextField.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../core/components/already_have_an_account_acheck.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);
  var controller = Get.put(LoginController());
  var controller2 = Get.put(ProductController());
  var loginFromkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SvgPicture.asset(
              "assets/icons/login.svg",
              height: MediaQuery.of(context).size.height / 3,
            ),
            SizedBox(height: 20),
            Form(
              key: loginFromkey,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(height: 20),
                    LoginTextField(
                      labeltext: "User Name",
                      controller: controller.userNameC,
                      validator: (v) {
                        if (v!.length <= 2) {
                          return "Enter correct username";
                        }
                      },
                      borderSide: BorderSide.none,
                      obsecure: false,
                    ),
                    SizedBox(height: 15),
                    LoginTextField(
                      labeltext: "password",
                      controller: controller.passwordC,
                      validator: (v) {
                        if (v!.length < 6 || v.contains(RegExp(r'[A-Z]'))) {
                          return "Enter Passsword";
                        }
                      },
                      borderSide: BorderSide.none,
                      obsecure: true,
                    ),
                    SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () {
                        if (loginFromkey.currentState!.validate()) {
                          controller.doSignin();
                          controller2.getBookingTypes();
                        } else {
                          Get.snackbar("Message", "Enter Fields Data");
                        }
                        // });
                      },
                      child: Text("Log in".toUpperCase()),
                    ),
                    SizedBox(height: 10),
                    AlreadyHaveAnAccountCheck(
                      login: true,
                      press: () {
                        Get.toNamed("/signup");
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
