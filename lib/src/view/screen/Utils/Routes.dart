import 'package:e_commerce_flutter/main.dart';
import 'package:e_commerce_flutter/src/view/screen/Login/login_screen.dart';
import 'package:e_commerce_flutter/src/view/screen/Signup/signup_screen.dart';
import 'package:e_commerce_flutter/src/view/screen/SplashScreen/Splash.dart';
import 'package:e_commerce_flutter/src/view/screen/all_product_screen.dart';
import 'package:e_commerce_flutter/src/view/screen/home_screen.dart';
import 'package:e_commerce_flutter/src/view/screen/product_detail_screen.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';

import '../../../model/productItem.dart';

final Results product = Results();

appRoutes() => [
      GetPage(
        name: '/splash',
        page: () => SplashScreen(),
        transition: Transition.leftToRightWithFade,
        transitionDuration: const Duration(milliseconds: 10),
      ),
      GetPage(
        name: '/home',
        page: () => HomeScreen(),
        transition: Transition.leftToRightWithFade,
        transitionDuration: const Duration(milliseconds: 10),
      ),
      GetPage(
        name: '/allproduct',
        page: () => AllProductScreen(),
        transition: Transition.leftToRightWithFade,
        transitionDuration: const Duration(milliseconds: 10),
      ),
      GetPage(
        name: '/pdetail',
        page: () => ProductDetailScreen(),
        transition: Transition.leftToRightWithFade,
        transitionDuration: const Duration(milliseconds: 10),
      ),
      GetPage(
        name: '/login',
        page: () => LoginScreen(),
        transition: Transition.leftToRightWithFade,
        transitionDuration: const Duration(milliseconds: 10),
      ),
      GetPage(
        name: '/signup',
        page: () => SignUpScreen(),
        transition: Transition.leftToRightWithFade,
        transitionDuration: const Duration(milliseconds: 10),
      ),
    ];
