import 'package:e_commerce_flutter/core/EmailValidation.dart';
import 'package:e_commerce_flutter/src/controller/SignupController.dart';
import 'package:e_commerce_flutter/src/view/screen/Signup/components/TextField.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../../../core/components/already_have_an_account_acheck.dart';
import '../../../../core/constants.dart';
import '../Login/login_screen.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({Key? key}) : super(key: key);
  var controller = Get.put(SingupController());
  var signUpFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SvgPicture.asset(
                "assets/icons/signup.svg",
                height: MediaQuery.of(context).size.height / 3,
              ),
              Form(
                key: signUpFormKey,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      LoginTextField(
                        labeltext: "First Name",
                        controller: controller.fNameC,
                        validator: (v) {
                          if (v!.length <= 2) {
                            return "Enter Correct Name";
                          }
                        },
                        borderSide: BorderSide.none,
                        obsecure: false,
                      ),
                      SizedBox(height: 10),
                      LoginTextField(
                        labeltext: "Last Name",
                        controller: controller.sNameC,
                        validator: (v) {
                          if (v!.length <= 2) {
                            return "Enter Correct Name";
                          }
                        },
                        borderSide: BorderSide.none,
                        obsecure: false,
                      ),
                      SizedBox(height: 10),
                      LoginTextField(
                        labeltext: "User Name",
                        controller: controller.uNameC,
                        validator: (v) {
                          if (v!.length <= 2) {
                            return "Enter Correct Name";
                          }
                        },
                        borderSide: BorderSide.none,
                        obsecure: false,
                      ),
                      SizedBox(height: 10),
                      LoginTextField(
                        labeltext: "Email",
                        controller: controller.emailC,
                        validator: (v) {
                          return validateEmail(v);
                        },
                        borderSide: BorderSide.none,
                        obsecure: false,
                      ),
                      SizedBox(height: 10),
                      LoginTextField(
                        labeltext: "password",
                        controller: controller.passwordC,
                        validator: (value) {
                          RegExp specialChar =
                              new RegExp(r'[!@#<>?":_`~;[\]\\|=+)(*&^%0-9-]');
                          if (!specialChar.hasMatch(value!)) {
                            return "Password must contain at least one special character";
                          } else if (value.length < 9) {
                            return "Password must be at least 8 characters";
                          } else if (value.contains(RegExp(r'[A-Z]'))) {
                            return "Password must contain 'abc'";
                          }
                          return null;
                        },
                        borderSide: BorderSide.none,
                        obsecure: true,
                      ),
                      SizedBox(height: 10),
                      LoginTextField(
                        labeltext: "Re-password",
                        controller: controller.conpasswordC,
                        validator: (v) {
                          if (v!.length < 8 ||
                              controller.passwordC.text !=
                                  controller.conpasswordC.text) {
                            return "Password Does not MAtch";
                          }
                        },
                        borderSide: BorderSide.none,
                        obsecure: true,
                      ),
                      SizedBox(height: 10),
                      LoginTextField(
                        labeltext: "Phone Number",
                        controller: controller.phoneC,
                        keyboardType: TextInputType.number,
                        validator: (v) {
                          if (v!.length <= 10) {
                            return "Enter total lenght of the phone number";
                          }
                        },
                        borderSide: BorderSide.none,
                        obsecure: false,
                      ),
                      const SizedBox(height: 15),
                      ElevatedButton(
                        onPressed: () {
                          if (signUpFormKey.currentState!.validate()) {
                            controller.doSignUp();
                          } else {
                            Get.snackbar(
                                "Message", "Enter Correct Fiedls data");
                          }
                        },
                        child: Text("Sign Up".toUpperCase()),
                      ),
                      const SizedBox(height: defaultPadding),
                      AlreadyHaveAnAccountCheck(
                        login: false,
                        press: () {
                          Get.back();
                        },
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
