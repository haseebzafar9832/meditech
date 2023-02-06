import 'package:e_commerce_flutter/core/app_color.dart';
import 'package:e_commerce_flutter/src/controller/product_controller.dart';
import 'package:e_commerce_flutter/src/model/productItem.dart';
import 'package:e_commerce_flutter/src/view/screen/Utils/Routes.dart';
import 'package:e_commerce_flutter/src/view/screen/Utils/Sharepreference.dart';
import 'package:e_commerce_flutter/src/view/widget/open_container_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import '../widget/product_grid_view.dart';

class FavoriteScreen extends StatelessWidget {
  FavoriteScreen({Key? key}) : super(key: key);
  var controller = Get.put(ProductController());
  Widget _gridItemHeader(Results product, int index) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Obx(
            () => IconButton(
              onPressed: () async {
                controller.favItmes(product.id).then((value) {
                  controller.getBookingTypes();
                });
                print(product.is_favourite);
              },
              icon: Icon(
                controller.favouriteList[index].is_favourite == false
                    ? Icons.favorite_border
                    : Icons.favorite,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _gridItemBody(Results product) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: const Color(0xFFE5E6E8),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Image.network(product.images![0].imageUrl!, scale: 3),
    );
  }

  Widget _gridItemFooter(Results product, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: const EdgeInsets.all(10),
        height: 60,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(15),
            bottomRight: Radius.circular(15),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FittedBox(
              child: Text(
                product.title!,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: const TextStyle(
                    fontWeight: FontWeight.w500, color: Colors.grey),
              ),
            ),
            const SizedBox(height: 5),
            Row(
              children: [
                Text(
                  "${product.price}",
                  style: Theme.of(context).textTheme.headline4,
                ),
                const SizedBox(width: 3),
              ],
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          "Favorites",
          style: Theme.of(context).textTheme.headline1,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Obx(
          () {
            return controller.isLoading.value == false
                ? GridView.builder(
                    itemCount: controller.favouriteList.length,
                    // physics: NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            childAspectRatio: 9 / 14,
                            crossAxisCount: 2,
                            mainAxisSpacing: 10,
                            crossAxisSpacing: 10),
                    itemBuilder: (_, index) {
                      RxInt selectedIndex = 0.obs;
                      Results product = controller.favouriteList[index];

                      return InkWell(
                          onTap: () {
                            Get.toNamed(
                              '/pdetail',
                              arguments: [product, product.id],
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: AppColor.lightOrange,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                left: 10,
                                right: 10,
                                top: 10,
                              ),
                              child: Column(
                                children: [
                                  Container(
                                    height: MediaQuery.of(context).size.height *
                                        0.22,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      image: DecorationImage(
                                        fit: BoxFit.fill,
                                        image: NetworkImage(
                                          product.images![0].imageUrl!,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 7),
                                  Text(
                                    product.title!,
                                    style: const TextStyle(
                                      color: AppColor.darkOrange,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.05,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              "Price: ",
                                              style: TextStyle(
                                                  color: AppColor.darkOrange),
                                            ),
                                            Text(
                                              "${product.price}",
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                        IconButton(
                                          onPressed: () async {
                                            controller
                                                .favItmes(product.id)
                                                .then((value) {
                                              controller.getBookingTypes();
                                            });
                                            print(
                                                "aaaaaaaaaaaaaaaaaa${product.is_favourite}");
                                          },
                                          icon: Icon(
                                            Icons.favorite,
                                            color: AppColor.darkOrange,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ));
                    },
                  )
                : Center(
                    child: CircularProgressIndicator(),
                  );
          },
        ),
      ),
    );
  }
}
