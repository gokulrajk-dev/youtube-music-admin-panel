// import 'package:basic_fundamental/module/page/modelEditPage/view/modelDetailPageViews.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// import '../../../../../data/data_model/Artist.dart';
// import '../../../../../data/registry/model_registry.dart';
// import '../../../../../data/registry/model_type.dart';
//
// class ArtistTile extends StatelessWidget {
//   final Artist artist;
//
//   const ArtistTile({
//     super.key,
//     required this.artist,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       color: const Color(0xFF0a0a0f),
//         margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//         child: ListTile(
//           onTap: () {
//             const modelType = ModelType.artist;
//             final definition = ModelRegistry.modelsDetails[modelType]!;
//             Get.to(
//               () => ModelDetailsEditView(
//                 definitions: definition,
//                 item: artist,
//               ),
//             );
//           },
//           leading: CircleAvatar(
//             backgroundImage: artist.artistImage != null
//                 ? NetworkImage(artist.artistImage!)
//                 : null,
//             child: artist.artistImage == null ? const Icon(Icons.person) : null,
//           ),
//           title: Text(artist.artistName ?? 'Unknown Artist',style: TextStyle(color: Colors.white),),
//           subtitle: Text(artist.country ?? 'Unknown Country'),
//           trailing: Container(
//             decoration: BoxDecoration(
//               border: Border.all(
//                 color: Colors.black12,
//                 width: 0.5
//               )
//             ),
//             width: 44,
//               height: 44,
//               child: const Center(child: Icon(Icons.edit))),
//         ),
//
//     );
//   }
// }

import 'package:basic_fundamental/module/page/modelEditPage/view/modelDetailPageViews.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../data/data_model/Artist.dart';
import '../../../../../data/registry/model_registry.dart';
import '../../../../../data/registry/model_type.dart';

class ArtistTile extends StatelessWidget {
  final Artist artist;

  const ArtistTile({
    super.key,
    required this.artist,
  });

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
            // Avatar
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
                      ? Image.network(
                          artist.artistImage!,
                          fit: BoxFit.cover,
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

            // Edit icon button
            Container(
              width: 34,
              height: 34,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.06),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: Colors.white.withOpacity(0.10),
                  width: 0.5,
                ),
              ),
              child: Icon(
                Icons.edit_outlined,
                size: 16,
                color: const Color(0xFFF0ECE4).withOpacity(0.45),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
