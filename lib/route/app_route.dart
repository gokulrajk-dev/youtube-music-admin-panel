import 'package:basic_fundamental/module/page/login/loginBinding.dart';
import 'package:basic_fundamental/module/page/login/loginViews.dart';
import 'package:basic_fundamental/module/page/main_home_page/mainHomeView.dart';
import 'package:basic_fundamental/module/page/modelEditPage/binding/modelEditPageBinding.dart';
import 'package:get/get.dart';

import '../module/page/main_home_page/mainHomeBinding.dart';
import '../module/splash.dart';
import 'middleware/auth_guard.dart';

class appRoute {
  static const String splash = "/splash";
  static const String mainHome = "/mainHome";
  static const String getModel = "/getModel";
  static const String login = "/login";

  static final route = [
    GetPage(
      name: splash,
      page: () => const Splash(),
      middlewares: [auth_guard()],
    ),
    GetPage(
      name: mainHome,
      page: () => const mainHomePage(),
        bindings:[mainHomeBinding(),modelEditBinding(),auth_binding()],
      middlewares: [auth_guard()],
    ),
    // GetPage(
    //     name: getModel,
    //     page: () => const modelEditViews(),),
    GetPage(
        name: login,
        page: () => const login_page(),
        binding: auth_binding(),
        middlewares: [auth_guard()]),
  ];
}
