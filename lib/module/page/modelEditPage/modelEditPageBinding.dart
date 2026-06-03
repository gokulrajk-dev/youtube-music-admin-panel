import 'package:get/get.dart';

import 'modelEditPageController.dart';

class modelEditBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<GetModelEditController>(()=>GetModelEditController());
  }

}