import 'dart:convert';
import 'dart:io';

import 'package:e_commerce_flutter/src/model/productItem.dart';
import 'package:e_commerce_flutter/src/view/screen/Utils/Routes.dart';
import 'package:e_commerce_flutter/src/view/screen/Utils/Sharepreference.dart';
import 'package:e_commerce_flutter/src/view/screen/all_product_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:http/http.dart' as http;
import 'package:e_commerce_flutter/core/extensions.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

import '../model/numerical.dart';
import '../model/product.dart';

import '../model/product_size_type.dart';

class ProductController extends GetxController {
  // RxList<Results> allProducts = AppData.products.obs;
  RxList<Results> filteredProducts = <Results>[].obs;
  RxList<Results> favouriteList = <Results>[].obs;

  RxList<Results> searchData = <Results>[].obs;
  RxList<Results> cartProducts = <Results>[].obs;
  TextEditingController searchC = TextEditingController();
  // RxList<ProductCategory> categories = AppData.categories.obs;
  int length = ProductType.values.length;
  RxDouble totalPrice = 0.0.obs;
  RxInt currentBottomNavItemIndex = 0.obs;
  RxInt productImageDefaultIndex = 0.obs;
  @override
  void onInit() {
    getBookingTypes();
    print("init state chal rhi h");
    super.onInit();
  }

  RxString dropDownValue = "Sort".obs;
  List<String> dropdownList = ['Sort', 'A-Z', 'Price', 'Latest', 'Old'].obs;
  Future<void> getBookingTypes() async {
    print("second time      m");
    var data = MyPrefferenc.gettoken();

    try {
      print("second time${data}");
      var url = Uri.parse(
          'http://ec2-43-206-254-199.ap-northeast-1.compute.amazonaws.com/api/v1/items/');

      final response = await http.get(url,
          headers: data!.isNotEmpty
              ? {
                  'Authorization': 'token $data',
                }
              : null);
      print("object");
      print(response.statusCode);
      if (response.statusCode == 200) {
        print("ander agia h");
        var json = jsonDecode(response.body);
        filteredProducts.value =
            List<Results>.from(json['results'].map((d) => Results.fromJson(d)))
                .toList();
        searchData.addAll(filteredProducts);
        favouriteList.value = filteredProducts
            .where((item) => item.is_favourite == true)
            .toList();
      } else if (response.statusCode == 400) {}
      // return [];
    } catch (e) {
      print(e);
    }
  }

  filterlist() {
    filteredProducts.clear();
    filteredProducts.value = searchData
        .where((e) => e.title
            .toString()
            .toLowerCase()
            .contains(searchC.text.toLowerCase()))
        .toList();
    // print("length${filterData.length}");
  }

  RxBool isLoading = false.obs;
  favItmes(int? pId) async {
    try {
      isLoading.value = true;
      var data = MyPrefferenc.gettoken();

      var bodyParam = {
        "item_id": "$pId",
      };

      var url = Uri.parse(
          'http://ec2-43-206-254-199.ap-northeast-1.compute.amazonaws.com/api/v1/favourite/items/');
      final response = await http.post(
        url,
        headers: {
          'Authorization': 'token $data',
        },
        body: bodyParam,
      );

      if (response.statusCode == 200) {
        Future.delayed(Duration(seconds: 2), () {
          isLoading.value = false;
        });
      } else {
        isLoading.value = false;
        Get.snackbar("User", "Please Login First");
      }
    } catch (e) {
      print(e);
    }
  }

  // void filterItemsByCategory(int index) {
  //   for (ProductCategory element in categories) {
  //     element.isSelected = false;
  //   }
  //   categories[index].isSelected = true;

  //   if (categories[index].type == ProductType.all) {
  //     filteredProducts.assignAll(allProducts);
  //   } else {
  //     filteredProducts.assignAll(allProducts.where((item) {
  //       return item.type == categories[index].type;
  //     }).toList());
  //   }
  // }

  // void isLiked(int index) {
  //   filteredProducts[index].isLiked = !filteredProducts[index].isLiked;
  //   filteredProducts.refresh();
  // }

  void addToCart(Results product) {
    product.quantity = product.quantity! + 1;
    cartProducts.add(product);
    cartProducts.assignAll(cartProducts.distinctBy((item) => item));
    var resultsJson = jsonEncode(cartProducts);
    List d = json.decode(resultsJson);
    print(d);
    MyPrefferenc.saveCart(resultsJson);

    calculateTotalPrice();
  }

  void increaseItem(int index) {
    Results product = cartProducts[index];
    product.quantity = product.quantity! + 1;
    calculateTotalPrice();
    update();
  }

  bool get isZeroQuantity {
    return cartProducts.any(
      (element) {
        return element.price!.compareTo(0) == 0 ? true : false;
      },
    );
  }

  bool isPriceOff(Results product) {
    if (product.off != null) {
      return true;
    } else {
      return false;
    }
  }

  bool get isEmptyCart {
    if (cartProducts.isEmpty || isZeroQuantity) {
      return true;
    } else {
      return false;
    }
  }

  bool isNominal(Product product) {
    if (product.sizes?.numerical != null) {
      return true;
    } else {
      return false;
    }
  }

  void decreaseItem(int index) {
    Results product = cartProducts[index];
    if (product.quantity! > 0) {
      product.quantity = product.quantity! - 1;
    }
    calculateTotalPrice();
    update();
  }

  void calculateTotalPrice() {
    totalPrice.value = 0;
    for (var element in cartProducts) {
      totalPrice.value += element.quantity! * element.price!;
      // if (isPriceOff(element)) {
      //   totalPrice.value += element.quantity! * element.off!;
      // } else {
      //   totalPrice.value += element.quantity! * element.price!;
      // }
    }
  }

  void switchBetweenBottomNavigationItems(int index) {
    // switch (index) {
    //   case 0:
    //     filteredProducts.assignAll(allProducts);
    //     break;
    //   case 1:
    //     getLikedItems();
    //     break;
    //   case 2:
    //     cartProducts.assignAll(allProducts.where((item) => item.quantity > 0));
    // }
    currentBottomNavItemIndex.value = index;
  }

  void switchBetweenProductImages(int index) {
    productImageDefaultIndex.value = index;
  }

  void getLikedItems() {
    // filteredProducts.assignAll(allProducts.where((item) => item.isLiked));
  }

  List<Numerical> sizeType(Product product) {
    ProductSizeType? productSize = product.sizes;
    List<Numerical> numericalList = [];

    if (productSize?.numerical != null) {
      for (var element in productSize!.numerical!) {
        numericalList.add(Numerical(element.numerical, element.isSelected));
      }
    }

    if (productSize?.categorical != null) {
      for (var element in productSize!.categorical!) {
        numericalList
            .add(Numerical(element.categorical.name, element.isSelected));
      }
    }

    return numericalList;
  }

  void switchBetweenProductSizes(Product product, int index) {
    sizeType(product).forEach((element) {
      element.isSelected = false;
    });

    if (product.sizes?.categorical != null) {
      for (var element in product.sizes!.categorical!) {
        element.isSelected = false;
      }

      product.sizes?.categorical![index].isSelected = true;
    }

    if (product.sizes?.numerical != null) {
      for (var element in product.sizes!.numerical!) {
        element.isSelected = false;
      }

      product.sizes?.numerical![index].isSelected = true;
    }

    update();
  }

  String getCurrentSize(Product product) {
    String currentSize = "";
    if (product.sizes?.categorical != null) {
      for (var element in product.sizes!.categorical!) {
        if (element.isSelected) {
          currentSize = "Size:" + element.categorical.name.toString();
        }
      }
    }

    if (product.sizes?.numerical != null) {
      for (var element in product.sizes!.numerical!) {
        if (element.isSelected) {
          currentSize = "Size:" + element.numerical;
        }
      }
    }
    return currentSize;
  }
}
