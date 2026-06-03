import 'package:basic_fundamental/module/page/main_home_page/mainHomeController.dart';
import 'package:get/get.dart';

class mainHomeBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<mainHomeController>(()=>mainHomeController());
  }
}