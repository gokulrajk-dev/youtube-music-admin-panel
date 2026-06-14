import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../data/data_model/song_module.dart';
import '../../../../../data/registry/model_registry.dart';
import '../../../../../data/registry/model_type.dart';
import '../../view/modelDetailPageViews.dart';
import '../helperwidget/helper_widget.dart';

class SongTile extends StatelessWidget {
  final Song song;

  const SongTile({
    super.key,
    required this.song,
  });

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
                  child: song.coverImage != null &&
                      song.coverImage!.isNotEmpty
                      ? Image.network(
                    song.coverImage!,
                    fit: BoxFit.cover,

                  )
                      :Image.asset('assets/_joker1.png',fit: BoxFit.cover,)
              ),
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
                    song.artist!.map((e)=>e.artistName).join(','),
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w300,
                      color: const Color(0xFFF0ECE4).withOpacity(0.38),
                    ),
                  ),
                ],
              ),
            ),

            const ListModelTile(icon: Icons.edit_outlined, borderColor: Colors.white, IconColor: Color(0xFFF0ECE4)),
            const SizedBox(width: 10,),
            const ListModelTile(icon: Icons.delete_outline, borderColor: Colors.red, IconColor: Colors.red)
          ],
        ),
      ),
    );
  }
}
