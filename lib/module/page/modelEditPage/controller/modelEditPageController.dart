// import 'package:basic_fundamental/core/base/base_class.dart';
// import 'package:basic_fundamental/data/repo/custom_api.dart';
// import 'package:get/get.dart';
//
// class GetModelEditController extends base_controller {
//   RxList<dynamic> item = <dynamic>[].obs;
//
//   Future<void> modelEditFunk<T>(
//       String api, T Function(Map<String, dynamic>) fromJson) async {
//     try {
//       set_loading(true);
//       noerror();
//       final apis = dynamicApi();
//       final result = await apis.getFunction(api, fromJson);
//       item.assignAll(
//         result
//       );
//     } catch (e) {
//       set_error(e.toString());
//     } finally {
//       set_loading(false);
//     }
//   }
// }

import 'package:basic_fundamental/core/base/base_class.dart';
import 'package:get/get.dart';

import '../../../../data/registry/model_definition.dart';
import '../../../../data/repo/custom_api.dart';

class GetModelEditController extends base_controller {
  RxList<dynamic> items = <dynamic>[].obs;
  final model_details = Rxn<dynamic>();
  final load = false.obs;

  Future<void> loadData(
    ModelDefinition definition,
  ) async {
    try {
      set_loading(true);
      final result = await dynamicApi().getFunction(
        definition.api,
        definition.fromJson,
      );

      items.assignAll(result);
    } catch (e) {
      set_error(e.toString());
    } finally {
      set_loading(false);
    }
  }

  // P:/android_project/yt_music_admin_panel/lib/module/page/modelEditPage/controller/modelEditPageController.dart

  Future<void> loadDetailData(ModelDetailDefinition definition, dynamic item) async {
    load.value=true;
    model_details.value=null;
    try {
      final api = definition.apiBuilder!(item);
      final result = await dynamicApi().getDetailFunction(
        api,
        definition.fromJson,
      );
      model_details.value = result;
    } catch (e) {
      set_error(e.toString());
    } finally {
      load.value = false;
    }
  }
}
