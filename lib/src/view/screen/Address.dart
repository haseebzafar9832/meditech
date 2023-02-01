import 'package:e_commerce_flutter/src/controller/product_controller.dart';
import 'package:e_commerce_flutter/src/view/screen/checkoutScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

class Address extends StatelessWidget {
  var controller = Get.put(ProductController());
  double total_amount;
  int addresId;
  List<Map<String, dynamic>> item;
  Address({
    required this.addresId,
    required this.total_amount,
    required this.item,
  });
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Select an Adres",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Obx(
                () => ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: controller.jsonData!['addresses'].length,
                  itemBuilder: (context, index) {
                    var addresses = controller.jsonData!['addresses'];

                    return InkWell(
                      onTap: () {
                        Get.to(
                          CheckOutScreen(
                            addresId: addresses[index]['id'],
                            total_amount: controller.totalPrice.value,
                            item: item,
                          ),
                        );
                      },
                      child: SizedBox(
                        height: 80,
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(addresses![index]['address']),
                                Text(addresses[index]['phone_number']),
                                Text(addresses[index]['email_address']),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
