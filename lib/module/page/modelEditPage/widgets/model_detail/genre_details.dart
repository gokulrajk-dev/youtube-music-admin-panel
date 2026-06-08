import 'package:flutter/material.dart';

import '../../../../../data/data_model/genre.dart';
import '../helperwidget/helper_widget.dart';

class GenreDetails extends StatelessWidget {
  final Genre genre;

  const GenreDetails({
    super.key,
    required this.genre,
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
                  title: 'Genre Details',
                  onTap: () {},
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(children: [
                      const CircleAvatar(
                        child: Icon(Icons.category),
                      ),
                      Text(
                        genre.genreName ?? 'Unknown Genre',
                        style: const TextStyle(
                          fontFamily: 'serif',
                          fontSize: 26,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFFF0ECE4),
                          letterSpacing: -0.3,
                        ),
                      ),
                      Text(
                        genre.description ?? 'No description',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w300,
                          color: const Color(0xFFF0ECE4).withOpacity(0.45),
                          height: 1.6,
                        ),
                      ),
                      const Icon(Icons.edit),
                    ]),
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
