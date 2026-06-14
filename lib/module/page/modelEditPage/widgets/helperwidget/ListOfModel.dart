import 'package:basic_fundamental/module/page/modelEditPage/widgets/model_detail/album_details.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../data/data_model/song_module.dart';
import '../model_detail/song_details.dart';

class SongRow extends StatelessWidget {
  final List<Song> Genresong;

  const SongRow({super.key, required this.Genresong});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ...Genresong.map((song) {
          return ListTile(
            onTap: () {
              Get.to(SongDetails(song: song));
            },
            leading: ClipRRect(
                borderRadius: BorderRadius.circular(14),
                child: song.coverImage != null && song.coverImage!.isNotEmpty
                    ? Image.network(
                        song.coverImage!,
                        fit: BoxFit.cover,
                      )
                    : Image.asset(
                        'assets/_joker1.png',
                        fit: BoxFit.cover,
                      )),
            title: Text(
              song.title ?? "",
              style: const TextStyle(color: Colors.white),
            ),
            subtitle: Text(
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              song.artist!.map((e) => e.artistName).join(","),
              style: const TextStyle(color: Colors.grey, fontSize: 14),
            ),
            trailing: Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                color: const Color(0xFF6D28D9).withOpacity(0.15),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                    color: const Color(0xFF6D28D9).withOpacity(0.30),
                    width: 0.5),
              ),
              child: const Icon(Icons.play_arrow,
                  color: Color(0xFFA78BFA), size: 14),
            ),
          );
        })
      ],
    );
  }
}

class AlbumRow extends StatelessWidget {
  final List<Song> song;

  const AlbumRow({super.key, required this.song});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(children: [
        ...song.map((album) {
          return Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: GestureDetector(
              onTap: () {
                Get.to(
                  AlbumDetail(album: album.album!)
                );
              },
              child: Column(
                children: [
                  SizedBox(
                    width: 100,
                    height: 100,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(14),
                        child: album.album!.coverImage != null &&
                                album.album!.coverImage!.isNotEmpty
                            ? Image.network(
                                album.album!.coverImage!,
                                fit: BoxFit.cover,
                              )
                            : Image.asset(
                                'assets/_joker1.png',
                                fit: BoxFit.cover,
                              )
                    ),
                  ),
                  const SizedBox(height: 7,),
                  Text(
                    album.album!.title ?? "",
                    style: const TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
          );
        }).toSet(),
      ]),
    );
  }
}
