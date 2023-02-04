import 'package:e_commerce_flutter/src/controller/product_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderDetailPAge extends StatelessWidget {
  var controller = Get.put(ProductController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
              child: ListView.builder(
                itemCount: controller.ordersDetial.orderItems!.length,
                itemBuilder: (BuildContext context, int i) {
                  var data = controller.ordersDetial.orderItems![i];
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Order Status: ${controller.ordersDetial.status}"),
                      Text("Order Id: ${controller.ordersDetial.id}"),
                      Text(
                          "Order Number: ${controller.ordersDetial.orderNumber}"),
                      Text("Order Amount: ${controller.ordersDetial.amount}"),
                      Text(
                          "Shippment: ${controller.ordersDetial.shippingAmount}"),
                      Text(
                          "Total Amount: ${controller.ordersDetial.totalAmount}"),
                      Text(
                          "Total Quantity: ${controller.ordersDetial.totalQuantity}"),
                      Text("User: ${controller.ordersDetial.user}"),
                      Text("Created At: ${controller.ordersDetial.createdAt}"),
                      Text(
                          "Processed Date: ${controller.ordersDetial.processedDate}"),
                      Text("Processed Datewwwwwwww: ${controller.items.title}"),
                      Text("${data.item?.id}"),
                      SizedBox(
                        height: 150,
                        child: Image.network(
                          "${data.item!.images![0].imageUrl}",
                        ),
                      ),
                      Text("${data.item?.description}"),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
