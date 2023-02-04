import 'package:e_commerce_flutter/core/app_color.dart';
import 'package:e_commerce_flutter/core/extensions.dart';
import 'package:e_commerce_flutter/src/model/productItem.dart';
import 'package:e_commerce_flutter/src/view/screen/checkoutScreen.dart';
import 'package:e_commerce_flutter/src/view/widget/animated_switcher_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/product_controller.dart';
import '../widget/empty_cart.dart';

final ProductController controller = Get.put(ProductController());

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  PreferredSizeWidget _appBar(BuildContext context) {
    return AppBar(
      title: Text(
        "My cart",
        style: Theme.of(context).textTheme.headline1,
      ),
    );
  }

  Widget cartListView() {
    return ListView.builder(
      shrinkWrap: true,
      padding: const EdgeInsets.all(20),
      itemCount: controller.cartProducts.length,
      itemBuilder: (_, index) {
        Results product = controller.cartProducts[index];
        // print(controller.cartProducts.length);

        return Container(
          margin: const EdgeInsets.only(bottom: 20),
          padding: const EdgeInsets.all(15),
          height: 120,
          decoration: BoxDecoration(
              color: Colors.grey[200]?.withOpacity(0.6),
              borderRadius: BorderRadius.circular(10)),
          child: Row(
            // crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: ColorExtension.randomColor),
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      product.images![0].imageUrl!,
                      width: 70,
                      height: 120,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        product.title!.nextLine,
                        // maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 10),
                      ),
                      // Text(
                      //   controller.getCurrentSize(product),
                      //   style: TextStyle(
                      //       color: Colors.black.withOpacity(0.5),
                      //       fontWeight: FontWeight.w400),
                      // ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            // controller.isPriceOff(product)
                            //     ? "\$${product.off}"
                            //     : "\$${product.price}",
                            "RS${product.price}",
                            // "\$${product.price}",
                            style: const TextStyle(
                                fontWeight: FontWeight.w900, fontSize: 23),
                          ),
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10)),
                            child: Row(
                              children: [
                                IconButton(
                                  splashRadius: 10.0,
                                  onPressed: () =>
                                      controller.decreaseItem(index),
                                  icon: const Icon(
                                    Icons.remove,
                                    color: Color(0xFFEC6813),
                                  ),
                                ),
                                GetBuilder<ProductController>(
                                  builder: (ProductController controller) {
                                    return AnimatedSwitcherWrapper(
                                      child: Text(
                                        '${controller.cartProducts[index].quantity}',
                                        key: ValueKey<int>(controller
                                            .cartProducts[index].quantity!),
                                        style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w700),
                                      ),
                                    );
                                  },
                                ),
                                IconButton(
                                  splashRadius: 10.0,
                                  onPressed: () =>
                                      controller.increaseItem(index),
                                  icon: const Icon(
                                    Icons.add,
                                    color: Color(0xFFEC6813),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              // const Spacer(),
              // Container(
              //   decoration: BoxDecoration(
              //       color: Colors.white,
              //       borderRadius: BorderRadius.circular(10)),
              //   child: Row(
              //     children: [
              //       IconButton(
              //         splashRadius: 10.0,
              //         onPressed: () => controller.decreaseItem(index),
              //         icon: const Icon(
              //           Icons.remove,
              //           color: Color(0xFFEC6813),
              //         ),
              //       ),
              //       GetBuilder<ProductController>(
              //         builder: (ProductController controller) {
              //           return AnimatedSwitcherWrapper(
              //             child: Text(
              //               '${controller.cartProducts[index].quantity}',
              //               key: ValueKey<int>(
              //                   controller.cartProducts[index].quantity!),
              //               style: const TextStyle(
              //                   fontSize: 18, fontWeight: FontWeight.w700),
              //             ),
              //           );
              //         },
              //       ),
              //       IconButton(
              //         splashRadius: 10.0,
              //         onPressed: () => controller.increaseItem(index),
              //         icon: const Icon(
              //           Icons.add,
              //           color: Color(0xFFEC6813),
              //         ),
              //       ),
              //     ],
              //   ),
              // )
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(context),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 10,
            child: cartListView(),
          ),
          Expanded(
            child: SizedBox(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.only(left: 30, right: 30, bottom: 10),
                child: ElevatedButton(
                  child: const Text("CheckOut"),
                  onPressed: controller.isEmptyCart
                      ? null
                      : () {
                          List<Map<String, dynamic>> checkOut = [];

                          for (var i = 0;
                              i < controller.cartProducts.length;
                              i++) {
                            checkOut.add({
                              "item_id": controller.cartProducts[i].id,
                              "quantity": controller.cartProducts[i].quantity,
                              "amount": controller.totalPrice.value.toString(),
                            });
                          }
                          Get.to(CheckOutScreen(
                            addresId: 2,
                            total_amount: controller.totalPrice.value,
                            item: checkOut,
                          ));
                          print(checkOut);
                        },
                ),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Total",
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.w400)),
                  Obx(() {
                    return AnimatedSwitcherWrapper(
                      child: Text(
                        "RS=${controller.totalPrice.value}",
                        key: ValueKey<double>(controller.totalPrice.value),
                        style: const TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w900,
                          color: AppColor.darkOrange,
                        ),
                      ),
                    );
                  })
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
