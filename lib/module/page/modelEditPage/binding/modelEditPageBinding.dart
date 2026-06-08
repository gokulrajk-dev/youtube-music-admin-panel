import 'package:get/get.dart';

import '../controller/modelEditPageController.dart';

class modelEditBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<GetModelEditController>(GetModelEditController());
  }
}
