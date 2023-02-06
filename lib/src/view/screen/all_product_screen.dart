import 'package:e_commerce_flutter/core/app_color.dart';
import 'package:e_commerce_flutter/src/view/screen/Signup/components/TextField.dart';
import 'package:e_commerce_flutter/src/view/screen/Utils/Sharepreference.dart';

import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:get/get.dart';
import '../../../core/app_data.dart';
import '../../controller/product_controller.dart';
import '../../model/productItem.dart';
import '../widget/product_grid_view.dart';

enum AppbarActionType { leading, trailing }

final List<String> imgList = [
  'assets/images/1.jpg',
  'assets/images/2.jpg',
  'assets/images/3.jpg',
  'assets/images/1.jpg',
  'assets/images/5.jpg',
];

class AllProductScreen extends StatelessWidget {
  AllProductScreen({Key? key}) : super(key: key);
  final ProductController controller = Get.put(ProductController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
          child: SafeArea(
            child: Container(
              color: AppColor.lightOrange,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.7,
                      child: LoginTextField(
                        labeltext: "Search",
                        controller: controller.searchC,
                        validator: (v) {},
                        borderSide: BorderSide.none,
                        obsecure: false,
                        onChanged: (v) {
                          return controller.filterlist();
                        },
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      width: MediaQuery.of(context).size.width * 0.19,
                      height: 45,
                      child: Obx(
                        () => Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: DropdownButton(
                              hint: const Text(
                                "Sort",
                                style:
                                    TextStyle(fontSize: 12, color: Colors.grey),
                              ),
                              underline: Container(),
                              isExpanded: true,
                              isDense: true,
                              focusColor: Colors.transparent,
                              value: controller.dropDownValue.value,
                              icon: const Icon(
                                Icons.keyboard_arrow_down,
                                size: 18,
                              ),
                              items: controller.dropdownList.map((String item) {
                                return DropdownMenuItem(
                                  enabled: item == "Sort" ? false : true,
                                  value: item,
                                  child: Text(
                                    item,
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.black.withOpacity(0.5),
                                    ),
                                  ),
                                );
                              }).toList(),
                              onChanged: (String? newValue) {
                                controller.dropDownValue.value = newValue!;
                                if (controller.dropDownValue.value == "A-Z") {
                                  for (var i = 0;
                                      i < controller.filteredProducts.length;
                                      i++) {
                                    controller.filteredProducts.sort((a, b) {
                                      if (a.title.toString().toLowerCase()[0] ==
                                              'a' &&
                                          b.title.toString().toLowerCase()[0] !=
                                              'a') {
                                        return -1;
                                      } else if (a.title
                                                  .toString()
                                                  .toLowerCase()[0] !=
                                              'a' &&
                                          b.title.toString().toLowerCase()[0] ==
                                              'a') {
                                        return 1;
                                      } else {
                                        return a.title
                                            .toString()
                                            .toLowerCase()
                                            .compareTo(b.title
                                                .toString()
                                                .toLowerCase());
                                      }
                                    });
                                  }
                                } else if (controller.dropDownValue.value ==
                                    "Price") {
                                  for (var i = 0;
                                      i < controller.filteredProducts.length;
                                      i++) {
                                    controller.filteredProducts.sort(
                                        (a, b) => a.price!.compareTo(b.price!));
                                  }
                                } else if (controller.dropDownValue.value ==
                                    "Machines") {
                                  print("object");
                                  // for (var i = 0;
                                  //     i < controller.filteredProducts.length;
                                  //     i++) {
                                  //   controller.filteredProducts.sort(
                                  //       (a, b) => a.price!.compareTo(b.price!));
                                  // }
                                } else if (controller.dropDownValue.value ==
                                    "Latest") {
                                  for (var i = 0;
                                      i < controller.filteredProducts.length;
                                      i++) {
                                    controller.filteredProducts.sort((a, b) =>
                                        a.createdAt!.compareTo(b.createdAt!));
                                  }
                                } else if (controller.dropDownValue.value ==
                                    "Old") {
                                  for (var i = 0;
                                      i < controller.filteredProducts.length;
                                      i++) {
                                    controller.filteredProducts.sort((a, b) =>
                                        a.createdAt!.compareTo(b.createdAt!));
                                    controller.filteredProducts.reversed;
                                  }
                                }
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          preferredSize: Size.fromHeight(60)),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: NestedScrollView(
            headerSliverBuilder: (context, snapshot) {
              return [
                SliverAppBar(
                  expandedHeight: 150,
                  elevation: 0,
                  automaticallyImplyLeading: false,
                  pinned: true,
                  flexibleSpace: FlexibleSpaceBar(
                    centerTitle: true,
                    background: CarouselSlider.builder(
                      itemCount: imgList.length,
                      itemBuilder: (BuildContext context, i, q) {
                        return Image.asset(
                          imgList[i],
                          width: MediaQuery.of(context).size.width,
                          fit: BoxFit.fill,
                        );
                      },
                      options: CarouselOptions(
                        autoPlay: true,
                        aspectRatio: 2.451,
                        height: 300,
                        clipBehavior: Clip.none,
                        viewportFraction: 0.9,
                        enlargeCenterPage: true,
                        autoPlayInterval: Duration(seconds: 5),
                      ),
                    ),
                  ),
                ),
              ];
            },
            body: SafeArea(
              child: Obx(
                () => controller.isLoading.value == false
                    ? (controller.filteredProducts.isNotEmpty)
                        ? Obx(
                            () => SizedBox(
                              // height: MediaQuery.of(context).size.height * 0.9,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    top: 10, left: 10, right: 10),
                                child: GridView.builder(
                                  itemCount: controller.filteredProducts.length,
                                  physics: NeverScrollableScrollPhysics(),
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                          childAspectRatio: 9 / 14,
                                          crossAxisCount: 2,
                                          mainAxisSpacing: 10,
                                          crossAxisSpacing: 10),
                                  itemBuilder: (_, index) {
                                    RxInt selectedIndex = 0.obs;
                                    Results product =
                                        controller.filteredProducts[index];

                                    return InkWell(
                                        onTap: () {
                                          Get.toNamed(
                                            '/pdetail',
                                            arguments: [product, product.id],
                                          );
                                        },
                                        child: Obx(
                                          () =>
                                              controller.isLoading.value ==
                                                      false
                                                  ? Container(
                                                      decoration: BoxDecoration(
                                                          color: AppColor
                                                              .lightOrange,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      15)),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                          left: 10,
                                                          right: 10,
                                                          top: 10,
                                                        ),
                                                        child: Column(
                                                          children: [
                                                            Container(
                                                              height: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .height *
                                                                  0.22,
                                                              decoration:
                                                                  BoxDecoration(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              15),
                                                                      image:
                                                                          DecorationImage(
                                                                        fit: BoxFit
                                                                            .fill,
                                                                        image: NetworkImage(
                                                                            product.images![0].imageUrl!,
                                                                            scale: 3),
                                                                      )),
                                                            ),
                                                            SizedBox(
                                                                height: 10),
                                                            Text(
                                                              product.title!,
                                                              style:
                                                                  const TextStyle(
                                                                color: AppColor
                                                                    .darkOrange,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                              maxLines: 2,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                            ),
                                                            SizedBox(
                                                              height: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .height *
                                                                  0.07,
                                                              child: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  Row(
                                                                    children: [
                                                                      Text(
                                                                        "Price: ",
                                                                        style: TextStyle(
                                                                            color:
                                                                                AppColor.darkOrange),
                                                                      ),
                                                                      Text(
                                                                        "${product.price}",
                                                                        style:
                                                                            TextStyle(
                                                                          fontWeight:
                                                                              FontWeight.bold,
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  Obx(
                                                                    () =>
                                                                        IconButton(
                                                                      onPressed:
                                                                          () async {
                                                                        controller
                                                                            .favItmes(product.id)
                                                                            .then((value) {
                                                                          controller
                                                                              .getBookingTypes();
                                                                        });

                                                                        print(
                                                                            "aaaaaaaaaaaaaaaaaa${product.is_favourite}");
                                                                      },
                                                                      icon:
                                                                          Icon(
                                                                        controller.filteredProducts[index].is_favourite ==
                                                                                false
                                                                            ? Icons.favorite_border
                                                                            : Icons.favorite,
                                                                        color: AppColor
                                                                            .darkOrange,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    )
                                                  : Center(
                                                      child:
                                                          CircularProgressIndicator(),
                                                    ),
                                        ));
                                  },
                                ),
                              ),
                            ),
                          )
                        : Center(
                            child: CircularProgressIndicator(),
                          )
                    : Center(
                        child: CircularProgressIndicator(),
                      ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
