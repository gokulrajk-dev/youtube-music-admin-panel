import 'package:flutter/material.dart';

import '../../../../../data/data_model/song_module.dart';
import '../helperwidget/helper_widget.dart';

class SongDetails extends StatelessWidget {
  final Song song;

  const SongDetails({
    super.key,
    required this.song,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0F),
      body: Stack(
        children: [
          SafeArea(
            child: Column(
              children: [
                 appBar(title: 'Song Details',onTap: () {
                },),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            image: song.coverImage != null
                                ? DecorationImage(
                                    image: NetworkImage(song.coverImage!), fit: BoxFit.cover)
                                : null,
                            color: Colors.grey[300],
                          ),
                          child: song.coverImage == null ? const Icon(Icons.music_note) : null,
                        ),
                        Text(song.title ?? 'Unknown Song'),
                        Text(song.artist?.map((e) => e.artistName).join(', ') ??
                            'Unknown Artist'),
                        const Icon(Icons.edit),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
