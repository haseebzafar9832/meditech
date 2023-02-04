import 'dart:convert';
import 'dart:io';

import 'package:e_commerce_flutter/src/model/CategoriesModel.dart';
import 'package:e_commerce_flutter/src/model/OrderMode.dart';
import 'package:e_commerce_flutter/src/model/productItem.dart';
import 'package:e_commerce_flutter/src/model/profileModeld.dart';
import 'package:e_commerce_flutter/src/view/screen/OrderDetail/OrderDetail.dart';
import 'package:e_commerce_flutter/src/view/screen/Utils/Routes.dart';
import 'package:e_commerce_flutter/src/view/screen/Utils/Sharepreference.dart';
import 'package:e_commerce_flutter/src/view/screen/all_product_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:http/http.dart' as http;
import 'package:e_commerce_flutter/core/extensions.dart';
import 'package:image_picker/image_picker.dart';

import '../model/numerical.dart';
import '../model/product.dart';

import '../model/product_size_type.dart';

class ProductController extends GetxController {
  // RxList<Results> allProducts = AppData.products.obs;
  RxList<Results> filteredProducts = <Results>[].obs;
  RxList<Results> filteredProducts2 = <Results>[].obs;
  RxInt isCategory = 0.obs;
  RxList<Results> favouriteList = <Results>[].obs;
  // RxList allORder = [].obs;

  RxList<Results> searchData = <Results>[].obs;
  RxList<Results> cartProducts = <Results>[].obs;
  RxList allORderList = [].obs;
  TextEditingController searchC = TextEditingController();
  // RxList<ProductCategory> categories = AppData.categories.obs;
  int length = ProductType.values.length;
  RxDouble totalPrice = 0.0.obs;
  RxInt currentBottomNavItemIndex = 0.obs;
  RxInt productImageDefaultIndex = 0.obs;
  OrdersDetial ordersDetial = OrdersDetial();
  Categories categoris = Categories();
  Item items = Item();
  @override
  void onInit() async {
    print("init state chal rhi h");
    super.onInit();
    profileData();
    getBookingTypes();
    // fetchData();
    profileData();
    print("asssssskldjfljdsljflsdlflkjdslkfj${await allOrder()}");
    ordersDetial = await allOrder();

    categoris = await getSortingLists();
  }

  // fetchData() {
  //   MyPrefferenc.getCart().then((value) {
  //     print("asaaaaaaaaaaaaaaaaaaaaaaa$value");

  //     // cartData.addAll(value);
  //     // print("asaaaaaaaaaaaaaaaaaaaaaaa$cartData");
  //   });
  // }

  RxString dropDownValue = "Sort".obs;
  List<String> dropdownList = [
    'Sort',
    'A-Z',
    'Price',
    'Latest',
    'Old',
    'Machines',
  ].obs;
  getSortingLists() async {
    var data = MyPrefferenc.gettoken();

    try {
      var url = Uri.parse(
          'http://ec2-43-206-254-199.ap-northeast-1.compute.amazonaws.com/api/v1/category/');

      final response = await http.get(url, headers: {
        'Authorization': 'token $data',
      });
      if (response.statusCode == 200) {
        return categoriesFromJson(response.body);
      } else if (response.statusCode == 400) {}
      // return [];
    } catch (e) {
      print(e);
    }
  }

  Future<void> getBookingTypes() async {
    var data = MyPrefferenc.gettoken();

    try {
      var url = Uri.parse(
          'http://ec2-43-206-254-199.ap-northeast-1.compute.amazonaws.com/api/v1/items/');

      final response = await http.get(url,
          headers: data!.isNotEmpty
              ? {
                  'Authorization': 'token $data',
                }
              : null);
      if (response.statusCode == 200) {
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

  order(var items) async {
    isLoading.value = true;
    var data = MyPrefferenc.gettoken();
    String bodyParam = items;
    print(bodyParam);
    var url = Uri.parse(
        'http://ec2-43-206-254-199.ap-northeast-1.compute.amazonaws.com/api/v1/orders/place_order/');
    final response = await http.post(
      url,
      headers: {
        'Authorization': 'Token $data',
        'Content-Type': 'application/json',
      },
      body: bodyParam,
    );
    print("order api status${response.statusCode}");
    if (response.statusCode == 200) {
      var json = ordersDetialFromJson(response.body);
      MyPrefferenc.orderId(json.id!);
      print(json.id);
      Future.delayed(const Duration(seconds: 2), () {
        isLoading.value = false;
      });
    }
  }

  allOrder() async {
    try {
      var data = MyPrefferenc.gettoken();
      var id = MyPrefferenc.getOrderId();
      var url = Uri.parse(
          'http://ec2-43-206-254-199.ap-northeast-1.compute.amazonaws.com/api/v1/orders/$id/');

      final response = await http.get(url, headers: {
        'Authorization': 'token $data',
      });
      if (response.statusCode == 200) {
        return ordersDetialFromJson(response.body);
      } else if (response.statusCode == 400) {}
    } catch (e) {
      print(e);
    }
  }

  void addToCart(Results product) {
    product.quantity = product.quantity! + 1;
    cartProducts.add(product);
    cartProducts.assignAll(cartProducts.distinctBy((item) => item));
    var resultsJson = jsonEncode(cartProducts);
    List d = json.decode(resultsJson);
    print(d);
    // MyPrefferenc.saveCart(resultsJson);

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

  // profile controller
  File? imgurl;
  Future pickImageCamera() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      final imageTemp = File(image.path);
      imgurl = imageTemp;
      print(imgurl);
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  TextEditingController nameC = TextEditingController();
  TextEditingController address1C = TextEditingController();
  TextEditingController address2C = TextEditingController();
  TextEditingController address3C = TextEditingController();
  TextEditingController address4C = TextEditingController();
  TextEditingController emailC = TextEditingController();
  TextEditingController phoneC = TextEditingController();
  TextEditingController address = TextEditingController();
  RxList<User> profileDetail = <User>[].obs;

  RxMap<String, dynamic>? jsonData = <String, dynamic>{}.obs;

  Future profileData() async {
    var data = MyPrefferenc.gettoken();
    var id = MyPrefferenc.getId();
    print("ye chlali k nh");

    try {
      var url = Uri.parse(
          'http://ec2-43-206-254-199.ap-northeast-1.compute.amazonaws.com/api/v1/user/$id/');
      final response = await http.get(url, headers: {
        'Authorization': 'token $data',
      });
      if (response.statusCode == 200) {
        jsonData!.value = jsonDecode(response.body);
        print(jsonData);
      } else if (response.statusCode == 401) {
        jsonData = null;
      }
    } catch (e) {
      print(e);
    }
  }

  Future editProfileData() async {
    var data = MyPrefferenc.gettoken();
    var id = MyPrefferenc.getId();
    print(id);
    var bodyParam = {
      "phone_number": phoneC.text,
      "email_address": emailC.text,
      "address": address.text,
    };
    var url = Uri.parse(
        'http://ec2-43-206-254-199.ap-northeast-1.compute.amazonaws.com/api/v1/user/add_address/');
    final response = await http.post(url,
        headers: {
          'Authorization': 'token $data',
        },
        body: bodyParam);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);

      print(data);
    } else {
      print("Edit Failded");
    }
  }

  Future deleteAddress(int adressId) async {
    var data = MyPrefferenc.gettoken();

    var bodyParam = {
      "address_id": adressId.toString(),
    };
    var url = Uri.parse(
        'http://ec2-43-206-254-199.ap-northeast-1.compute.amazonaws.com/api/v1/user/remove_address/');
    final response = await http.post(url,
        headers: {
          'Authorization': 'Token $data',
        },
        body: bodyParam);
    print(response.statusCode);
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);

      // print(data);
    } else {
      print("Edit Failded");
    }
  }
}
