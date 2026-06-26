import 'package:basic_fundamental/module/page/modelEditPage/widgets/forms/definitions/song_form.dart';
import 'package:basic_fundamental/module/page/modelEditPage/widgets/model_tile/song_tile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../data/data_model/song_module.dart';
import '../../controller/modelEditPageController.dart';
import '../forms/widgets/dynamic_form.dart';
import '../helperwidget/helper_widget.dart';

class SongDetails extends StatelessWidget {
  final Song song;
  final GetModelEditController getModelEditController =
      Get.find<GetModelEditController>();

  SongDetails({
    super.key,
    required this.song,
  });

  @override
  Widget build(BuildContext context) {
    final artistNames = (song.artist != null && song.artist!.isNotEmpty)
        ? song.artist!.map((e) => e.artistName ?? '').join(' · ')
        : 'Unknown Artist';

    final albumName = song.album?.title ?? 'Unknown Album';

    final genreNames = (song.genre != null && song.genre!.isNotEmpty)
        ? song.genre!.map((g) => g.genreName ?? '').join(' · ')
        : null;

    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0F),
      body: Stack(
        children: [
          // ── Main content ─────────────────────────────────────────────
          SafeArea(
            child: Column(
              children: [
                // Top bar
                appBar(title: "Song Details", onTap: () {}),

                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 8),

                        // ── Cover Art ──────────────────────────────────
                        Center(
                          child: Container(
                            width: 190,
                            height: 190,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              gradient: const LinearGradient(
                                colors: [Color(0xFF1E1040), Color(0xFF1E3A5F)],
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color:
                                      const Color(0xFF4F46E5).withOpacity(0.40),
                                  blurRadius: 48,
                                  offset: const Offset(0, 16),
                                ),
                              ],
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: song.coverImage != null &&
                                      song.coverImage!.isNotEmpty
                                  ? Image.network(
                                      song.coverImage!,
                                      fit: BoxFit.cover,
                                      errorBuilder: (_, __, ___) =>
                                          _CoverFallback(
                                              title: song.title ?? ''),
                                    )
                                  : _CoverFallback(title: song.title ?? ''),
                            ),
                          ),
                        ),

                        const SizedBox(height: 22),

                        // ── Song title + artist ────────────────────────
                        Center(
                          child: Column(
                            children: [
                              Text(
                                song.title ?? 'Unknown Song',
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 26,
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xFFF0ECE4),
                                  letterSpacing: -0.3,
                                  height: 1.15,
                                ),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                artistNames,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w400,
                                  color:
                                      const Color(0xFFF0ECE4).withOpacity(0.50),
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 16),

                        // ── Badges ─────────────────────────────────────
                        Center(
                          child: Wrap(
                            spacing: 8,
                            runSpacing: 6,
                            alignment: WrapAlignment.center,
                            children: [
                              if (song.releaseDate != null)
                                SingleModelDetailsWidgetBadge(
                                  icon: Icons.calendar_today_outlined,
                                  label: song.releaseDate!,
                                  bgColor:
                                      const Color(0xFF2563EB).withOpacity(0.12),
                                  textColor: const Color(0xFF60A5FA),
                                  borderColor:
                                      const Color(0xFF60A5FA).withOpacity(0.25),
                                ),
                              if (genreNames != null)
                                SingleModelDetailsWidgetBadge(
                                  icon: Icons.music_note_outlined,
                                  label: genreNames,
                                  bgColor:
                                      const Color(0xFF7C3AED).withOpacity(0.12),
                                  textColor: const Color(0xFFA78BFA),
                                  borderColor:
                                      const Color(0xFFA78BFA).withOpacity(0.25),
                                ),
                              if (song.duration != null)
                                SingleModelDetailsWidgetBadge(
                                  icon: Icons.timer_outlined,
                                  label: "${song.duration!}",
                                  bgColor:
                                      const Color(0xFF059669).withOpacity(0.12),
                                  textColor: const Color(0xFF34D399),
                                  borderColor:
                                      const Color(0xFF34D399).withOpacity(0.25),
                                ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 24),

                        // ── Mini player bar ────────────────────────────
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 14),
                          decoration: BoxDecoration(
                            color: const Color(0xFF4F46E5).withOpacity(0.10),
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: const Color(0xFF4F46E5).withOpacity(0.25),
                              width: 0.5,
                            ),
                          ),
                          child: Row(
                            children: [
                              // Cover thumb
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Container(
                                  width: 44,
                                  height: 44,
                                  color: const Color(0xFF1E1040),
                                  child: song.coverImage != null &&
                                          song.coverImage!.isNotEmpty
                                      ? Image.network(song.coverImage!,
                                          fit: BoxFit.cover,
                                          errorBuilder: (_, __, ___) =>
                                              const Icon(Icons.music_note,
                                                  color: Color(0xFFA78BFA),
                                                  size: 20))
                                      : const Icon(Icons.music_note,
                                          color: Color(0xFFA78BFA), size: 20),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      song.title ?? 'Unknown Song',
                                      style: const TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w500,
                                          color: Color(0xFFF0ECE4)),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    Text(
                                      artistNames,
                                      style: TextStyle(
                                          fontSize: 11,
                                          color: const Color(0xFFF0ECE4)
                                              .withOpacity(0.40)),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ),
                              // Controls
                              Row(
                                children: [
                                  const _PlayerBtn(
                                      icon: Icons.skip_previous_rounded,
                                      size: 22),
                                  const SizedBox(width: 6),
                                  Container(
                                    width: 38,
                                    height: 38,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      gradient: LinearGradient(
                                        colors: [
                                          Color(0xFF4F46E5),
                                          Color(0xFF7C3AED)
                                        ],
                                      ),
                                    ),
                                    child: const Icon(Icons.play_arrow_rounded,
                                        color: Colors.white, size: 22),
                                  ),
                                  const SizedBox(width: 6),
                                  const _PlayerBtn(
                                      icon: Icons.skip_next_rounded, size: 22),
                                ],
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 20),

                        // ── Stats ──────────────────────────────────────
                        Row(
                          children: [
                            _StatCard(
                              value: song.artist != null
                                  ? '${song.artist!.length}'
                                  : '0',
                              label: 'Artists',
                            ),
                            const SizedBox(width: 10),
                            _StatCard(
                              value: song.genre != null
                                  ? '${song.genre!.length}'
                                  : '0',
                              label: 'Genres',
                            ),
                            const SizedBox(width: 10),
                            _StatCard(
                              value: song.duration.toString(),
                              label: 'Duration',
                            ),
                          ],
                        ),

                        const SizedBox(height: 20),

                        // ── Song Info Card ─────────────────────────────
                        SingleModelDetailsWidget(
                          Title: 'Song Info',
                          padding: const EdgeInsets.all(16),
                          children: [
                            SingleModelDetailsWidgetInfoRow(
                              icon: Icons.music_note_outlined,
                              iconBg: const Color(0xFF4F46E5).withOpacity(0.15),
                              iconColor: const Color(0xFF818CF8),
                              label: 'Title',
                              value: song.title ?? 'Unknown Song',
                            ),
                            SingleModelDetailsWidgetInfoRow(
                              icon: Icons.person_outline,
                              iconBg: const Color(0xFF2563EB).withOpacity(0.15),
                              iconColor: const Color(0xFF60A5FA),
                              label: 'Artists',
                              value: artistNames,
                            ),
                            SingleModelDetailsWidgetInfoRow(
                              icon: Icons.album_outlined,
                              iconBg: const Color(0xFF7C3AED).withOpacity(0.15),
                              iconColor: const Color(0xFFA78BFA),
                              label: 'Album',
                              value: albumName,
                            ),
                            if (genreNames != null)
                              SingleModelDetailsWidgetInfoRow(
                                icon: Icons.category_outlined,
                                iconBg:
                                    const Color(0xFFCA8A04).withOpacity(0.15),
                                iconColor: const Color(0xFFFACC15),
                                label: 'Genre',
                                value: genreNames,
                              ),
                            if (song.releaseDate != null)
                              SingleModelDetailsWidgetInfoRow(
                                icon: Icons.calendar_today_outlined,
                                iconBg:
                                    const Color(0xFF059669).withOpacity(0.15),
                                iconColor: const Color(0xFF34D399),
                                label: 'Release Date',
                                value: song.releaseDate!,
                              ),
                            if (song.duration != null)
                              SingleModelDetailsWidgetInfoRow(
                                icon: Icons.timer_outlined,
                                iconBg:
                                    const Color(0xFFDB2777).withOpacity(0.15),
                                iconColor: const Color(0xFFF472B6),
                                label: 'Duration',
                                value: song.duration.toString(),
                                isLast: true,
                              ),
                          ],
                        ),

                        const SizedBox(height: 16),

                        // ── Divider ────────────────────────────────────
                        Divider(
                            color: Colors.white.withOpacity(0.07),
                            thickness: 0.5),

                        const SizedBox(height: 16),

                        // ── Action Buttons ─────────────────────────────
                        Row(
                          children: [
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  Get.to(DynamicFormPage(
                                    title: "Song",
                                    fields: songForm,
                                    model: song,
                                  ));
                                },
                                child: Container(
                                  height: 52,
                                  decoration: BoxDecoration(
                                    gradient: const LinearGradient(
                                      colors: [
                                        Color(0xFF4F46E5),
                                        Color(0xFF2563EB)
                                      ],
                                    ),
                                    borderRadius: BorderRadius.circular(14),
                                    boxShadow: [
                                      BoxShadow(
                                        color: const Color(0xFF4F46E5)
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
                                        'Update Song',
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
                            GestureDetector(
                              onTap: () async {
                                SongTile.Helper_code_for_delete_Song(
                                   song: song,getModelEditController: getModelEditController,isPop: true);
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
                                child: const Icon(Icons.delete_outline,
                                    color: Color(0xFFF87171), size: 22),
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

// ── Helper Widgets ─────────────────────────────────────────────────────────────

class _PlayerBtn extends StatelessWidget {
  final IconData icon;
  final double size;

  const _PlayerBtn({required this.icon, required this.size});

  @override
  Widget build(BuildContext context) {
    return Icon(icon,
        color: const Color(0xFFF0ECE4).withOpacity(0.60), size: size);
  }
}

class _CoverFallback extends StatelessWidget {
  final String title;

  const _CoverFallback({required this.title});

  @override
  Widget build(BuildContext context) {
    final initials = title.trim().isEmpty
        ? '♪'
        : title.trim().split(' ').take(2).map((w) => w[0].toUpperCase()).join();
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF1E1040), Color(0xFF1E3A5F)],
        ),
      ),
      child: Center(
        child: Text(
          initials,
          style: const TextStyle(
            fontSize: 52,
            fontWeight: FontWeight.w700,
            color: Color(0xFFE9D5FF),
          ),
        ),
      ),
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
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFFF0ECE4))),
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
