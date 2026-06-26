import 'package:basic_fundamental/data/data_model/song_stream.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/modelEditPageController.dart';

class songStream_tile extends StatelessWidget {
  final SongStream songStream;
  final GetModelEditController getModelEditController =
  Get.find<GetModelEditController>();
   songStream_tile({super.key, required this.songStream});

  @override
  Widget build(BuildContext context) {
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
                  songStream.id.toString(),
                ),
                buildInfo(
                  "hlsMaster Url",
                  songStream.hlsMasterUrl!,
                ),
                buildInfo(
                  "hlsBit64 Url",
                  songStream.hlsBit64 ?? "no Url",
                ),buildInfo(
                  "checksum",
                  songStream.hlsBit128 ?? "no Url",
                ),buildInfo(
                  "checksum",
                  songStream.hlsBit256 ?? "no Url",
                ),
                buildInfo(
                  "storage provider",
                  songStream.storageProvider!,
                ),
                buildInfo("processing status", songStream.isDrmEnabled.toString()),
                buildInfo(
                  "created at",
                  "${songStream.createdAt!}",
                ),
                buildInfo(
                  "song id",
                  songStream.song!.toString(),
                ),
              ],
            )),
        // Positioned(
        //   top: 14,
        //   right: 28,
        //   child: CircleIconButton(
        //     icon: Icons.more_vert_rounded,
        //     onTap: () {
        //       getModelEditController
        //           .showMenu(context, "songStream", children: [
        //         getModelEditController.menuItem(
        //           Icons.delete_outline,
        //           "delete",
        //               () {
        //             getModelEditController.hideMenu();
        //
        //           },
        //         ),
        //       ]);
        //     },
        //   ),
        // )
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
