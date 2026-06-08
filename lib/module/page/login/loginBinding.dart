import 'package:get/get.dart';

import 'loginController.dart';

class auth_binding extends Bindings {
  @override
  void dependencies() {
    Get.put<auth_google_login>(auth_google_login(), permanent: true);
  }
}
