import 'package:basic_fundamental/core/base/base_class.dart';
import 'package:basic_fundamental/data/repo/custom_api.dart';
import 'package:get/get.dart';

class GetModelEditController extends base_controller{
  RxList<dynamic> item = <dynamic>[].obs;

  Future<void> modelEditFunk<T>(String api,T Function(Map<String,dynamic>) fromJson)async{
    try{
      set_loading(true);
      noerror();
      final apis = dynamicApi();
      final result = await apis.getFunction(api, fromJson);
      item.assignAll(result);
    }catch(e){
      set_error(e.toString());
    }
    finally{
      set_loading(false);
    }
  }
}