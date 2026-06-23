import 'package:basic_fundamental/data/data_model/MediaAssets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/modelEditPageController.dart';
import '../forms/definitions/mediaasset_form.dart';
import '../forms/widgets/dynamic_form.dart';
import '../helperwidget/helper_widget.dart';

class Media_tile extends StatelessWidget {
  final MediaAssets mediaAssets;

  const Media_tile({super.key, required this.mediaAssets});

  @override
  Widget build(BuildContext context) {
    final GetModelEditController getModelEditController =
        Get.find<GetModelEditController>();
    return Stack(
      children: [
        Container(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 15),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.08),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: Colors.white.withOpacity(0.09),
                width: 0.5,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildInfo(
                  "id",
                  mediaAssets.id.toString(),
                ),
                buildInfo(
                  "original file",
                  mediaAssets.originalFile,
                ),
                buildInfo(
                  "checksum",
                  mediaAssets.checksum,
                ),
                buildInfo(
                  "storage provider",
                  mediaAssets.storageProvider,
                ),
                buildInfo("processing status", mediaAssets.processingStatus),
                buildInfo(
                  "created at",
                  mediaAssets.createdAt,
                ),
                buildInfo(
                  "song id",
                  mediaAssets.song.toString(),
                ),
              ],
            )),
        Positioned(
          top: 14,
          right: 28,
          child: CircleIconButton(
            icon: Icons.more_vert_rounded,
            onTap: () {
              getModelEditController
                  .showMenu(context, "MediaAssets", children: [
                getModelEditController.menuItem(
                  Icons.edit,
                  "Update",
                  () {
                    getModelEditController.hideMenu();
                    Get.to(
                      () => DynamicFormPage(
                        title: "MediaAssets",
                        fields: mediaAsset_form,
                        model: mediaAssets,
                      ),
                    );
                  },
                ),
                getModelEditController.menuItem(
                  Icons.delete_outline,
                  "delete",
                  () {
                    getModelEditController.hideMenu();
                    Get.to(
                      () => DynamicFormPage(
                        title: "MediaAssets",
                        fields: mediaAsset_form,
                        model: mediaAssets,
                      ),
                    );
                  },
                ),
              ]);
            },
          ),
        )
      ],
    );
  }

  Widget buildInfo(String label, String value) {
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: "$label: ",
            style: const TextStyle(color: Colors.grey, fontSize: 14),
          ),
          TextSpan(
            text: value,
            style: const TextStyle(color: Colors.white, fontSize: 17),
          ),
        ],
      ),
    );
  }
}
