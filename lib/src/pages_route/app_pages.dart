import 'package:get/get.dart';
import 'package:green_grocer/src/models/item_model.dart';
import 'package:green_grocer/src/pages/base/base_screen.dart';
import 'package:green_grocer/src/pages/base/binding/navigation_binding.dart';
import 'package:green_grocer/src/pages/home/binding/home_binding.dart';
import 'package:green_grocer/src/pages/home/controller/home_controller.dart';
import 'package:green_grocer/src/pages/product/product_screen.dart';
import 'package:green_grocer/src/pages/splash/splash_screen.dart';

import '../pages/auth/view/sign_in_screen.dart';
import '../pages/auth/view/sign_up_screen.dart';

abstract class AppPages {
  static final pages = <GetPage>[
    GetPage(
      name: '/splash',
      page: () => const SplashScreen(),
    ),
    GetPage(
      name: '/signin',
      page: () => SignInScreen(),
    ),
    GetPage(
      name: '/signup',
      page: () => SignUpScreen(),
    ),
    GetPage(
      name: '/base',
      page: () => const BaseScreen(),
      bindings: [HomeBinding(), NavigationBinding()],
    ),
    GetPage(
      name: '/product',
      page: () => const ProductScreen(),
    ),
  ];
}

abstract class PagesRoutes {
  static const String signInRoute = '/signin';
  static const String splashRoute = '/splash';
  static const String signUpRoute = '/signup';
  static const String baseRoute = '/base';
  static const String productRoute = '/product';
}
