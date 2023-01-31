import 'dart:io';

import 'package:e_commerce_flutter/core/EmailValidation.dart';
import 'package:e_commerce_flutter/core/app_color.dart';
import 'package:e_commerce_flutter/src/controller/ProfileController.dart';
import 'package:e_commerce_flutter/src/view/screen/Profile/Profile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Signup/components/TextField.dart';

class EditProfile extends StatelessWidget {
  var controller = Get.put(ProfileController());
  var formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            Align(
              alignment: Alignment.center,
              child: Container(
                height: 60,
                width: 60,
                decoration: BoxDecoration(
                  color: Colors.amber,
                  borderRadius: BorderRadius.circular(100),
                  image: controller.imgurl != null
                      ? DecorationImage(
                          fit: BoxFit.fill,
                          image: FileImage(
                            File(controller.imgurl!.path),
                          ),
                        )
                      : const DecorationImage(
                          fit: BoxFit.fill,
                          image: AssetImage("assets/images/2.jpg"),
                        ),
                ),
              ),
            ),
            SizedBox(height: 5),
            InkWell(
              onTap: () {
                Get.to(EditProfile());
              },
              child: const Align(
                alignment: Alignment.center,
                child: Text(
                  "Change Profile Picture",
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Form(
                key: formkey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10),
                    Text(
                      "About You",
                      style: TextStyle(
                        color: AppColor.darkOrange,
                        fontWeight: FontWeight.w400,
                        fontSize: 12,
                      ),
                    ),
                    SizedBox(height: 15),
                    profileTextfield(
                      textcontroller: controller.phoneC,
                      hintText: "Phone Number",
                      validate: (v) {
                        if (v!.length < 10) {
                          return "Enter correct mobile numbers";
                        }
                      },
                    ),
                    SizedBox(height: 10),
                    profileTextfield(
                      textcontroller: controller.address,
                      hintText: "Address ",
                      validate: (v) {
                        if (v!.length < 10) {
                          return "Enter correct Address";
                        }
                      },
                    ),
                    SizedBox(height: 10),
                    profileTextfield(
                      textcontroller: controller.emailC,
                      hintText: "email",
                      validate: (v) {
                        return validateEmail(v);
                      },
                    ),
                    // SizedBox(height: 10),
                    // profileTextfield(
                    //   textcontroller: controller.address3C,
                    //   hintText: "Address 3",
                    // ),
                    // SizedBox(height: 10),
                    // profileTextfield(
                    //   textcontroller: controller.address4C,
                    //   hintText: "Address 4",
                    // ),
                    SizedBox(height: 20),
                    Align(
                      alignment: Alignment.center,
                      child: ElevatedButton(
                          onPressed: () {
                            if (formkey.currentState!.validate()) {
                              controller.editProfileData();
                              controller.profileData();

                              controller.address.clear();
                              controller.emailC.clear();
                              controller.phoneC.clear();
                              Get.back();
                            } else {
                              print("Enter Data");
                            }
                          },
                          child: Text("Edit Profile")),
                    )
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

class profileTextfield extends StatelessWidget {
  TextEditingController textcontroller;
  String hintText;
  String? Function(String?)? validate;
  profileTextfield({
    required this.textcontroller,
    required this.hintText,
    required this.validate,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 45,
      child: LoginTextField(
        labeltext: hintText,
        controller: textcontroller,
        validator: validate,
        borderSide: BorderSide.none,
        obsecure: false,
      ),
    );
  }
}
