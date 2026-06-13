import 'package:basic_fundamental/core/base/base_class.dart';
import 'package:basic_fundamental/data/repo/get_model_repo.dart';
import 'package:get/get.dart';

class mainHomeController extends base_controller {
  RxList<String> gets_model = <String>[].obs;
  List<String> removeModels = ["video_song","Playlist","listen_History_Song_play_Playback","Queue","Like"];
  final GetModelCrud getModelCrud = GetModelCrud();

  @override
  void onInit() async {
    await showModel();
    super.onInit();
  }

  Future<void> showModel() async {
    try {
      set_loading(true);
      noerror();
      final result = await getModelCrud.getModelsName();
      gets_model.assignAll(result);
      gets_model.removeWhere((element) => removeModels.contains(element));
    } catch (e) {
      set_error(e.toString());
    } finally {
      set_loading(false);
    }
  }


  Future<void> refreshHome(List<Future<dynamic>> futures) async {
    try {
      set_loading(true);
      await Future.wait(futures);
      update();
    } finally {
      set_loading(false);
    }
  }

}
