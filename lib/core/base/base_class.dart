import 'package:get/get.dart';

class base_controller extends GetxController {
  final isLoading = false.obs;
  final error = ''.obs;

  void set_loading(bool value) {
    isLoading.value = value;
  }

  void set_error(String value) {
    error.value = value;
  }

  void noerror() {
    error.value = '';
  }
}
