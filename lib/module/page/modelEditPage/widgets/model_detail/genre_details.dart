import 'package:basic_fundamental/module/page/modelEditPage/widgets/helperwidget/helper_widget.dart';
import 'package:flutter/material.dart';

import '../../../../../data/data_model/genre.dart';
import '../helperwidget/ListOfModel.dart';

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

                // Scrollable body
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: [
                        const SizedBox(height: 12),
                        // ── Genre Icon ──────────────────────────────────
                        Stack(
                          clipBehavior: Clip.none,
                          children: [
                            Container(
                              width: 90,
                              height: 90,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(24),
                                gradient: const LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [
                                    Color(0xFF2D1A6B),
                                    Color(0xFF1A3A7A)
                                  ],
                                ),
                                border: Border.all(
                                  color:
                                      const Color(0xFFA78BFA).withOpacity(0.25),
                                  width: 1,
                                ),
                              ),
                              child: const Icon(
                                Icons.music_note_outlined,
                                size: 38,
                                color: Color(0xFFC4B5FD),
                              ),
                            ),
                            // Verified dot
                            Positioned(
                              bottom: -5,
                              right: -5,
                              child: Container(
                                width: 22,
                                height: 22,
                                decoration: BoxDecoration(
                                  color: const Color(0xFF6D28D9),
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                    color: const Color(0xFF0A0A0F),
                                    width: 2,
                                  ),
                                ),
                                child: const Icon(
                                  Icons.check,
                                  size: 10,
                                  color: Color(0xFFE9D5FF),
                                ),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 16),

                        // ── Genre Name ──────────────────────────────────
                        Text(
                          (genre.genreName ?? 'Unknown Genre').toUpperCase(),
                          style: const TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFFF0ECE4),
                            letterSpacing: 2,
                            height: 1,
                          ),
                        ),

                        const SizedBox(height: 8),

                        // ── Description ─────────────────────────────────
                        Text(
                          genre.description ?? 'No description available.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w300,
                            color: const Color(0xFFF0ECE4).withOpacity(0.45),
                            height: 1.6,
                          ),
                        ),

                        const SizedBox(height: 16),

                        // ── Mood Tags ───────────────────────────────────
                        const Wrap(
                          spacing: 8,
                          runSpacing: 6,
                          alignment: WrapAlignment.center,
                          children: [
                            _MoodTag(
                                label: 'Soulful',
                                bg: Color(0x1FA78BFA),
                                text: Color(0xFFA78BFA),
                                border: Color(0x40A78BFA)),
                            _MoodTag(
                                label: 'Evergreen',
                                bg: Color(0x1F34D399),
                                text: Color(0xFF34D399),
                                border: Color(0x4034D399)),
                            _MoodTag(
                                label: 'Cinematic',
                                bg: Color(0x1FFACC15),
                                text: Color(0xFFFACC15),
                                border: Color(0x40FACC15)),
                          ],
                        ),

                        const SizedBox(height: 24),

                        // ── Stats Row ───────────────────────────────────
                        const Row(
                          children: [
                            _StatCard(value: '248', label: 'Songs'),
                            SizedBox(width: 10),
                            _StatCard(value: '32', label: 'Albums'),
                            SizedBox(width: 10),
                            _StatCard(value: '5.1M', label: 'Plays'),
                          ],
                        ),

                        const SizedBox(height: 20),

                        SingleModelDetailsWidget(
                          padding: const EdgeInsets.all(16),
                          Title: 'Genre Info',
                          children: [
                            SingleModelDetailsWidgetInfoRow(
                              icon: Icons.category_outlined,
                              iconBg: const Color(0xFF7C3AED).withOpacity(0.15),
                              iconColor: const Color(0xFFA78BFA),
                              label: 'Type',
                              value: genre.genreName != null
                                  ? 'Tamil ${genre.genreName}'
                                  : 'Tamil Melody',
                            ),
                            SingleModelDetailsWidgetInfoRow(
                              icon: Icons.calendar_today_outlined,
                              iconBg: const Color(0xFF2563EB).withOpacity(0.15),
                              iconColor: const Color(0xFF60A5FA),
                              label: 'Era',
                              value: '1990s – Present',
                            ),
                            SingleModelDetailsWidgetInfoRow(
                              icon: Icons.favorite_border,
                              iconBg: const Color(0xFF059669).withOpacity(0.15),
                              iconColor: const Color(0xFF34D399),
                              label: 'Mood',
                              value: 'Romantic · Nostalgic · Calm',
                            ),
                            SingleModelDetailsWidgetInfoRow(
                              icon: Icons.person_outline,
                              iconBg: const Color(0xFFCA8A04).withOpacity(0.15),
                              iconColor: const Color(0xFFFACC15),
                              label: 'Top Artists',
                              customChild: const Wrap(
                                spacing: 7,
                                runSpacing: 6,
                                children: [
                                  SingleModelDetailsWidgetGenreTag(
                                    label: 'A.R. Rahman',
                                    bgColor: Color(0x1AA78BFA),
                                    textColor: Color(0xFFA78BFA),
                                    borderColor: Color(0x33A78BFA),
                                  ),
                                  SingleModelDetailsWidgetGenreTag(
                                    label: 'Anirudh',
                                    bgColor: Color(0x1A34D399),
                                    textColor: Color(0xFF34D399),
                                    borderColor: Color(0x3334D399),
                                  ),
                                  SingleModelDetailsWidgetGenreTag(
                                    label: 'Hip hop',
                                    bgColor: Color(0x1AFACC15),
                                    textColor: Color(0xFFFACC15),
                                    borderColor: Color(0x33FACC15),
                                  ),
                                ],
                              ),
                              isLast: true,
                            ),
                          ],
                        ),

                        const SizedBox(height: 14),
                        SingleModelDetailsWidget(
                            Title: "Album",
                            children: [
                              AlbumRow(
                                song: genre.songs_genre ?? [],
                              )
                            ],
                            padding: const EdgeInsets.all(16)),

                        const SizedBox(height: 14),

                        // ── Top Songs Card ────────────────────────────── //
                        SingleModelDetailsWidget(
                          padding: const EdgeInsets.all(0),
                          Title: "Song",
                          children: [
                            SongRow(
                              Genresong: genre.songs_genre ?? [],
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),

                        // ── Divider ─────────────────────────────────────
                        Divider(
                            color: Colors.white.withOpacity(0.07),
                            thickness: 0.5),

                        const SizedBox(height: 16),

                        // ── Action Buttons ──────────────────────────────
                        Row(
                          children: [
                            // Update
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  // TODO: navigate to edit screen
                                },
                                child: Container(
                                  height: 52,
                                  decoration: BoxDecoration(
                                    gradient: const LinearGradient(
                                      colors: [
                                        Color(0xFF5B21B6),
                                        Color(0xFF2563EB)
                                      ],
                                    ),
                                    borderRadius: BorderRadius.circular(14),
                                    boxShadow: [
                                      BoxShadow(
                                        color: const Color(0xFF5B21B6)
                                            .withOpacity(0.35),
                                        blurRadius: 20,
                                        offset: const Offset(0, 4),
                                      ),
                                    ],
                                  ),
                                  child: const Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.edit_outlined,
                                          color: Colors.white, size: 18),
                                      SizedBox(width: 8),
                                      Text(
                                        'Update Genre',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),

                            const SizedBox(width: 12),

                            // Delete
                            GestureDetector(
                              onTap: () {
                                // TODO: show delete confirmation
                              },
                              child: Container(
                                width: 52,
                                height: 52,
                                decoration: BoxDecoration(
                                  color:
                                      const Color(0xFFDC2626).withOpacity(0.10),
                                  borderRadius: BorderRadius.circular(14),
                                  border: Border.all(
                                    color: const Color(0xFFDC2626)
                                        .withOpacity(0.30),
                                    width: 1.5,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: const Color(0xFFDC2626)
                                          .withOpacity(0.15),
                                      blurRadius: 20,
                                      offset: const Offset(0, 4),
                                    ),
                                  ],
                                ),
                                child: const Icon(
                                  Icons.delete_outline,
                                  color: Color(0xFFF87171),
                                  size: 22,
                                ),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 32),
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

class _MoodTag extends StatelessWidget {
  final String label;
  final Color bg, text, border;

  const _MoodTag(
      {required this.label,
      required this.bg,
      required this.text,
      required this.border});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: border, width: 0.5),
      ),
      child: Text(label,
          style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w500,
              color: text,
              letterSpacing: 0.4)),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String value, label;

  const _StatCard({required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.04),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: Colors.white.withOpacity(0.08), width: 0.5),
        ),
        child: Column(
          children: [
            Text(value,
                style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFFF0ECE4),
                    letterSpacing: 0.5)),
            const SizedBox(height: 2),
            Text(label.toUpperCase(),
                style: TextStyle(
                    fontSize: 9,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.8,
                    color: const Color(0xFFF0ECE4).withOpacity(0.30))),
          ],
        ),
      ),
    );
  }
}
