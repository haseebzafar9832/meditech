import 'package:e_commerce_flutter/src/controller/product_controller.dart';
import 'package:e_commerce_flutter/src/view/screen/Utils/Sharepreference.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Address extends StatelessWidget {
  var controller = Get.put(ProductController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => ListView.builder(
          // physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: controller.jsonData!['addresses'].length,
          itemBuilder: (context, index) {
            var addresses = controller.jsonData!['addresses'];
            print(addresses[index]['phone_number']);
            return Dismissible(
              onDismissed: (v) {
                print(addresses![index]['id']);
              },
              key: UniqueKey(),
              child: SizedBox(
                height: 80,
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(addresses![index]['address']),
                            Text(addresses[index]['phone_number']),
                            Text(addresses[index]['email_address']),
                          ],
                        ),
                        IconButton(
                          onPressed: () {
                            controller.deleteAddress(MyPrefferenc.getId()!);
                          },
                          icon: Icon(Icons.delete),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
