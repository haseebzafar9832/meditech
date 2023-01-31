import 'dart:convert';
import 'dart:io';

import 'package:e_commerce_flutter/src/model/profileModeld.dart';
import 'package:e_commerce_flutter/src/view/screen/Utils/Sharepreference.dart';
import 'package:e_commerce_flutter/src/view/screen/all_product_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class ProfileController extends GetxController {
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
  @override
  void onInit() {
    profileData();
    super.onInit();
  }

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
