import 'package:e_commerce_flutter/core/app_color.dart';
import 'package:e_commerce_flutter/src/controller/product_controller.dart';
import 'package:e_commerce_flutter/src/view/screen/OrderDetail/OrderDetail.dart';
import 'package:e_commerce_flutter/src/view/screen/Profile/Address/Address.dart';
import 'package:e_commerce_flutter/src/view/screen/Profile/EditProfile.dart';
import 'package:e_commerce_flutter/src/view/screen/SplashScreen/Splash.dart';
import 'package:e_commerce_flutter/src/view/screen/Utils/Sharepreference.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Profile extends StatelessWidget {
  var controller = Get.put(ProductController());
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SafeArea(
        child: controller.jsonData != null
            ? Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Obx(
                  () => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                        alignment: Alignment.topRight,
                        child: InkWell(
                          onTap: () {
                            Get.to(EditProfile());
                          },
                          child: Icon(
                            Icons.edit,
                            color: AppColor.darkOrange,
                          ),
                        ),
                      ),
                      SizedBox(height: 0),
                      Text(
                        "My Profile",
                        style: TextStyle(
                          fontSize: 34,
                          fontWeight: FontWeight.w500,
                          color: AppColor.darkOrange,
                        ),
                      ),
                      SizedBox(height: 15),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            height: 60,
                            width: 60,
                            decoration: BoxDecoration(
                              color: Colors.amber,
                              borderRadius: BorderRadius.circular(100),
                              image: const DecorationImage(
                                fit: BoxFit.fill,
                                image: AssetImage("assets/images/2.jpg"),
                              ),
                            ),
                          ),
                          SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${controller.jsonData!['username']}",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(
                                "${controller.jsonData!['email']}",
                                style: TextStyle(
                                  fontSize: 18,
                                  color: AppColor.darkOrange.withOpacity(0.6),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 15),
                          userDetailWidget(
                            title: "First Name",
                            text: "${controller.jsonData!['first_name']}",
                          ),
                          SizedBox(height: 15),
                          userDetailWidget(
                            title: "Last Name",
                            text: "${controller.jsonData!['last_name']}",
                          ),
                          SizedBox(height: 15),
                          userDetailWidget(
                            title: "User Name",
                            text: "${controller.jsonData!['username']}",
                          ),
                          SizedBox(height: 15),
                          userDetailWidget(
                            title: "Email",
                            text: "${controller.jsonData!['email']}",
                          ),
                          SizedBox(height: 15),
                          userDetailWidget(
                            title: "Phone Number",
                            text: "${controller.jsonData!['phone_number']}",
                          ),
                          SizedBox(height: 15),
                        ],
                      ),
                      InkWell(
                        onTap: () {
                          controller.ordersDetial.id == null
                              ? Get.snackbar(
                                  "order", "No order detail aviable yet")
                              : Get.to(OrderDetailPAge());
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Order Detail",
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                              ),
                            ),
                            Icon(
                              Icons.arrow_forward_ios_rounded,
                              size: 14,
                              color: AppColor.darkOrange,
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: 15),
                      InkWell(
                        onTap: () {
                          Get.to(Address());
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Address",
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                              ),
                            ),
                            Icon(
                              Icons.arrow_forward_ios_rounded,
                              size: 14,
                              color: AppColor.darkOrange,
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: 20),
                      Align(
                        alignment: Alignment.center,
                        child: ElevatedButton(
                          onPressed: () {
                            MyPrefferenc.clear();
                            // controller.getBookingTypes();
                            // controller.profileData();
                            // controller.currentBottomNavItemIndex.value = 0;
                            Future.delayed(Duration(seconds: 3), () {
                              Get.offAll(SplashScreen());
                            });
                          },
                          child: Text("Log Out"),
                        ),
                      )
                    ],
                  ),
                ),
              )
            : Center(
                child: CircularProgressIndicator(),
              ),
      ),
    );
  }
}

class userDetailWidget extends StatelessWidget {
  userDetailWidget({
    Key? key,
    required this.text,
    required this.title,
  }) : super(key: key);
  String text;
  String title;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          flex: 2,
          child: Align(
            alignment: Alignment.topLeft,
            child: Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: Align(
            alignment: Alignment.topRight,
            child: Text(
              text,
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: AppColor.darkOrange),
            ),
          ),
        ),
      ],
    );
  }
}
