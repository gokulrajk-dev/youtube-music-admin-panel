import 'package:flutter/material.dart';

import '../../../../../data/data_model/album_module.dart';
import '../helperwidget/helper_widget.dart';

class AlbumDetail extends StatelessWidget {
  final Album album;

  const AlbumDetail({
    super.key,
    required this.album,
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
                appBar(
                  title: 'Album Details',
                  onTap: () {},
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Image.network(
                          album.coverImage ?? '',
                        ),
                        Text(
                          album.title ?? '',
                        ),
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
