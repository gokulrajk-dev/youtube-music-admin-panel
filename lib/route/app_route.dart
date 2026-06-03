import 'package:basic_fundamental/module/page/main_home_page/mainHomeView.dart';
import 'package:basic_fundamental/module/page/modelEditPage/modelEditPageBinding.dart';
import 'package:basic_fundamental/module/page/modelEditPage/modelEditPageViews.dart';
import 'package:get/get.dart';

import '../module/page/main_home_page/mainHomeBinding.dart';
import '../module/splash.dart';

class appRoute{
  static const String splash="/splash";
  static const String mainHome="/mainHome";
  static const String getModel="/getModel";


  static final route=[
    GetPage(name: splash, page: ()=>Splash()),
    GetPage(name: mainHome, page: ()=>mainHomePage(),bindings:[mainHomeBinding(),modelEditBinding()]),
    GetPage(name: getModel, page: ()=>modelEditViews(),),
  ];
}