import 'package:basic_fundamental/module/page/modelEditPage/view/modelDetailPageViews.dart';
import 'package:basic_fundamental/module/page/modelEditPage/widgets/helperwidget/helper_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../core/network/ApiEndpoint.dart';
import '../../../../../data/data_model/Artist.dart';
import '../../../../../data/registry/model_registry.dart';
import '../../../../../data/registry/model_type.dart';
import '../../controller/modelEditPageController.dart';
import '../forms/definitions/artist_form.dart';
import '../forms/widgets/dynamic_form.dart';
import '../helperwidget/commanWidgets.dart';

class ArtistTile extends StatelessWidget {
  final Artist artist;
  final GetModelEditController getModelEditController =
  Get.find<GetModelEditController>();

   ArtistTile({
    super.key,
    required this.artist,
  });

static Future<void> Helper_code_for_delete_artist(
{required Artist artist,required GetModelEditController getModelEditController,bool isPop =false}) {
return  DialogCode.deleteDialog(
  title: "Delete this Artist?",
  onDelete: () async {
    Get.back();
    final response =
    await getModelEditController.delete(
        endpoint:
        ApiEndpoint.get_artist_song(
            artist.id));
    if (response != null) {
      if (response.statusCode == 204 ||
          response.statusCode == 200) {
        final index = getModelEditController
            .items
            .indexWhere((e) =>
        (e as Artist).id ==
            artist.id);
        if (index != -1) {
          if(isPop)Get.back();
          getModelEditController.items
              .removeAt(index);
          Get.snackbar(
            "Success",
            "Delete Artist successfully",
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
        const modelType = ModelType.artist;
        final definition = ModelRegistry.modelsDetails[modelType]!;
        Get.to(
          () => ModelDetailsEditView(
            definitions: definition,
            item: artist,
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
            Container(
              width: 52,
              height: 52,
              clipBehavior: Clip.hardEdge,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Color(0xFF1E1040), Color(0xFF1E3A5F)],
                ),
              ),
              child: ClipRRect(
                  child: artist.artistImage != null &&
                          artist.artistImage!.isNotEmpty
                      ? Builder(builder: (context) {
                          return GestureDetector(
                            onTap: () {
                                Get.dialog(
                                  ModelImage(
                                    image: artist.artistImage!,
                                  ),
                                  barrierColor: Colors.transparent,
                                );
                            },
                            child: Image.network(
                              artist.artistImage!,
                              fit: BoxFit.cover,
                            ),
                          );
                        })
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
                    artist.artistName ?? 'Unknown Artist',
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
                    artist.country ?? 'Unknown Country',
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
                    title: "Artist",
                    fields: artistForm,
                    model: artist,
                  ));
                }),
            const SizedBox(
              width: 10,
            ),
            ListModelTile(
              icon: Icons.delete_outline,
              borderColor: Colors.red,
              IconColor: Colors.red,
              onTap: () async{
                await Helper_code_for_delete_artist(artist: artist, getModelEditController: getModelEditController);
              },
            )
          ],
        ),
      ),
    );
  }
}
