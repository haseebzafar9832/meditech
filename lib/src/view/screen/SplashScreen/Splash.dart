import 'package:e_commerce_flutter/src/controller/product_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({Key? key}) : super(key: key);

  splash() {
    Future.delayed(Duration(seconds: 3), () {
      Get.toNamed('/home');
    });
  }

  var controller = Get.put(ProductController());

  Widget build(BuildContext context) {
    splash();
    controller.getBookingTypes();
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Image.asset("assets/images/2.jpg"),
          ),
          SizedBox(height: 20),
          Text(
            "welcome to MediTech",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          )
        ],
      ),
    );
  }
}
