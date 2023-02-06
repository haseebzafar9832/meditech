import 'package:e_commerce_flutter/src/controller/product_controller.dart';
import 'package:e_commerce_flutter/src/view/screen/OrderDetail/OrderDetail.dart';
import 'package:e_commerce_flutter/src/view/screen/SplashScreen/Splash.dart';
import 'package:e_commerce_flutter/src/view/screen/cart_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SuccessPage extends StatelessWidget {
  var controller = Get.put(ProductController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Align(
            alignment: Alignment.center,
            child: ElevatedButton(
              onPressed: () {
                controller.getData().then((value) {
                  Get.off(OrderDetailPAge());
                });
              },
              child: Text("Order detail"),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Get.to(SplashScreen());
            },
            child: Text("Continue shoping"),
          )
        ],
      ),
    );
  }
}
