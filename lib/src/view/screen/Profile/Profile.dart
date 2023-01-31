import 'package:e_commerce_flutter/core/app_color.dart';
import 'package:e_commerce_flutter/src/controller/product_controller.dart';
import 'package:e_commerce_flutter/src/view/screen/Profile/EditProfile.dart';
import 'package:e_commerce_flutter/src/view/screen/Utils/Sharepreference.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Profile extends StatelessWidget {
  var controller = Get.put(ProductController());
  @override
  Widget build(BuildContext context) {
    controller.profileData();
    print(controller.jsonData);
    return SingleChildScrollView(
      child: SafeArea(
        child: controller.jsonData != null
            ? Obx(() => Column(
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20),
                    Align(
                      alignment: Alignment.center,
                      child: Container(
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
                    ),
                    SizedBox(height: 5),
                    InkWell(
                      onTap: () {
                        Get.to(EditProfile());
                      },
                      child: const Align(
                        alignment: Alignment.center,
                        child: Text(
                          "Edit Profile",
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 15),
                          Text(
                            "About You",
                            style: TextStyle(
                              color: AppColor.darkOrange,
                              fontWeight: FontWeight.w400,
                              fontSize: 12,
                            ),
                          ),
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
                        ],
                      ),
                    ),
                    ExpansionTile(
                      title: Text(
                        "Address",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      tilePadding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                      children: [
                        Obx(
                          () => ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
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
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      child: Row(
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                  addresses![index]['address']),
                                              Text(addresses[index]
                                                  ['phone_number']),
                                              Text(addresses[index]
                                                  ['email_address']),
                                            ],
                                          ),
                                          IconButton(
                                            onPressed: () {
                                              controller.deleteAddress(
                                                  MyPrefferenc.getId()!);
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
                      ],
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: ElevatedButton(
                        onPressed: () {
                          MyPrefferenc.clear();
                          controller.getBookingTypes();
                          controller.profileData();
                          controller.currentBottomNavItemIndex.value = 0;
                          Get.toNamed('/splash');
                        },
                        child: Text("Log Out"),
                      ),
                    )
                  ],
                ))
            : Center(
                child: Text("No user is logged in"),
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
                fontWeight: FontWeight.bold,
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
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
            ),
          ),
        ),
      ],
    );
  }
}
