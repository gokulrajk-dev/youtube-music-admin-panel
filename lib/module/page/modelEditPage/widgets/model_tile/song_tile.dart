import 'package:basic_fundamental/module/page/modelEditPage/widgets/forms/definitions/song_form.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../core/network/ApiEndpoint.dart';
import '../../../../../data/data_model/song_module.dart';
import '../../../../../data/registry/model_registry.dart';
import '../../../../../data/registry/model_type.dart';
import '../../controller/modelEditPageController.dart';
import '../../view/modelDetailPageViews.dart';
import '../forms/widgets/dynamic_form.dart';
import '../helperwidget/commanWidgets.dart';
import '../helperwidget/helper_widget.dart';

class SongTile extends StatelessWidget {
  final Song song;
  final GetModelEditController getModelEditController =
      Get.find<GetModelEditController>();

  SongTile({
    super.key,
    required this.song,
  });

  static Future<void> Helper_code_for_delete_Song(
      {required Song song,required GetModelEditController getModelEditController,bool isPop =false}) {
    return DialogCode.deleteDialog(
      title: "Delete this Song?",
      onDelete: () async {
        Get.back();
        final response = await getModelEditController.delete(
            endpoint: ApiEndpoint.get_modity_current_song_id(song.id));
        if (response != null) {
          if (response.statusCode == 204 || response.statusCode == 200) {
            final index = getModelEditController.items
                .indexWhere((e) => (e as Song).id == song.id);
            if (index != -1) {
              if(isPop)Get.back();
              getModelEditController.items.removeAt(index);
              Get.snackbar(
                "Success",
                "Delete Song successfully",
                backgroundColor: Colors.green,
                colorText: Colors.white,
              );
            }
          }
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        const modelType = ModelType.song;
        final definition = ModelRegistry.modelsDetails[modelType]!;
        Get.to(
          () => ModelDetailsEditView(
            definitions: definition,
            item: song,
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.08),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: Colors.white.withOpacity(0.09),
            width: 0.5,
          ),
        ),
        child: Row(
          children: [
            // Avatar
            Container(
              width: 52,
              height: 52,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Color(0xFF1E1040), Color(0xFF1E3A5F)],
                ),
              ),
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(14),
                  child: song.coverImage != null && song.coverImage!.isNotEmpty
                      ? GestureDetector(
                          onTap: () {
                            Get.dialog(
                              ModelImage(
                                image: song.coverImage!,
                              ),
                              barrierColor: Colors.transparent,
                            );
                          },
                          child: Image.network(
                            song.coverImage!,
                            fit: BoxFit.cover,
                          ),
                        )
                      : Image.asset(
                          'assets/_joker1.png',
                          fit: BoxFit.cover,
                        )),
            ),

            const SizedBox(width: 14),

            // Name + Country
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    song.title ?? 'Unknown Artist',
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFFF0ECE4),
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 3),
                  Text(
                    song.artist?.map((e) => e.artistName).join(',') ??
                        'Unknown Artist',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w300,
                      color: const Color(0xFFF0ECE4).withOpacity(0.38),
                    ),
                  ),
                ],
              ),
            ),

            ListModelTile(
              icon: Icons.edit_outlined,
              borderColor: Colors.white,
              IconColor: const Color(0xFFF0ECE4),
              onTap: () {
                Get.to(DynamicFormPage(
                  title: "Song",
                  fields: songForm,
                  model: song,
                ));
              },
            ),
            const SizedBox(
              width: 10,
            ),
            ListModelTile(
              icon: Icons.delete_outline,
              borderColor: Colors.red,
              IconColor: Colors.red,
              onTap: () {
                Helper_code_for_delete_Song(
                 song: song,getModelEditController: getModelEditController
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
