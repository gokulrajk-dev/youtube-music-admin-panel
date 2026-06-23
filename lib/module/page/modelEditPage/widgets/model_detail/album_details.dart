import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../data/data_model/album_module.dart';
import '../forms/definitions/album_form.dart';
import '../forms/widgets/dynamic_form.dart';
import '../helperwidget/ListOfModel.dart';
import '../helperwidget/commanWidgets.dart';
import '../helperwidget/helper_widget.dart';

class AlbumDetail extends StatelessWidget {
  final Album album;

  const AlbumDetail({
    super.key,
    required this.album,
  });

  @override
  Widget build(BuildContext context) {
    final artistNames = (album.artists != null && album.artists!.isNotEmpty)
        ? album.artists!.map((e) => e.artistName ?? '').join(' · ')
        : 'Unknown Artist';

    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0F),
      body: Stack(
        children: [
          // ── Main content ─────────────────────────────────────────────
          SafeArea(
            child: Column(
              children: [
                // Top bar
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _NavBtn(icon: Icons.arrow_back, onTap: () => Get.back()),
                      const Text(
                        'Album Details',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: Color(0xB3F0ECE4),
                          letterSpacing: 0.3,
                        ),
                      ),
                      _NavBtn(icon: Icons.more_vert, onTap: () {}),
                    ],
                  ),
                ),

                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 8),

                        // ── Cover Image ────────────────────────────────
                        Center(
                          child: GestureDetector(
                            onTap: () {
                              if (album.coverImage != null &&
                                  album.coverImage!.isNotEmpty) {
                                Get.dialog(
                                  ModelImage(image: album.coverImage!),
                                  barrierColor: Colors.black87,
                                );
                              }
                            },
                            child: Container(
                              width: 200,
                              height: 200,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                gradient: const LinearGradient(
                                  colors: [
                                    Color(0xFF1E1040),
                                    Color(0xFF1E3A5F)
                                  ],
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: const Color(0xFF9333EA)
                                        .withOpacity(0.35),
                                    blurRadius: 40,
                                    offset: const Offset(0, 12),
                                  ),
                                ],
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: album.coverImage != null &&
                                        album.coverImage!.isNotEmpty
                                    ? Image.network(
                                        album.coverImage!,
                                        fit: BoxFit.cover,
                                        errorBuilder: (_, __, ___) =>
                                            _CoverFallback(
                                                title: album.title ?? ''),
                                      )
                                    : Image.asset(
                                        'assets/_joker1.png',
                                        fit: BoxFit.cover,
                                        errorBuilder: (_, __, ___) =>
                                            _CoverFallback(
                                                title: album.title ?? ''),
                                      ),
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 20),

                        // ── Title + Artists ────────────────────────────
                        Center(
                          child: Column(
                            children: [
                              Text(
                                album.title ?? 'Unknown Album',
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 26,
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xFFF0ECE4),
                                  letterSpacing: -0.3,
                                  height: 1.1,
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

                        const SizedBox(height: 14),

                        // ── Badges row ─────────────────────────────────
                        Center(
                          child: Wrap(
                            spacing: 8,
                            runSpacing: 6,
                            alignment: WrapAlignment.center,
                            children: [
                              if (album.releaseDate != null)
                                _Badge(
                                  icon: Icons.calendar_today_outlined,
                                  label: album.releaseDate!,
                                  bg: const Color(0xFF2563EB).withOpacity(0.12),
                                  text: const Color(0xFF60A5FA),
                                  border:
                                      const Color(0xFF60A5FA).withOpacity(0.25),
                                ),
                              _Badge(
                                icon: Icons.album_outlined,
                                label: 'Studio Album',
                                bg: const Color(0xFF059669).withOpacity(0.12),
                                text: const Color(0xFF34D399),
                                border:
                                    const Color(0xFF34D399).withOpacity(0.25),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 24),

                        // ── Stats ──────────────────────────────────────
                        Row(
                          children: [
                            _StatCard(
                              value: album.songAlbum != null
                                  ? '${album.songAlbum!.length}'
                                  : '0',
                              label: 'Songs',
                            ),
                            const SizedBox(width: 10),
                            _StatCard(
                              value: album.artists != null
                                  ? '${album.artists!.length}'
                                  : '0',
                              label: 'Artists',
                            ),
                          ],
                        ),

                        const SizedBox(height: 20),

                        // ── Album Info Card ────────────────────────────
                        SingleModelDetailsWidget(
                          Title: 'Album Info',
                          padding: const EdgeInsets.all(16),
                          children: [
                            SingleModelDetailsWidgetInfoRow(
                              icon: Icons.album_outlined,
                              iconBg: const Color(0xFF7C3AED).withOpacity(0.15),
                              iconColor: const Color(0xFFA78BFA),
                              label: 'Title',
                              value: album.title ?? 'Unknown',
                            ),
                            SingleModelDetailsWidgetInfoRow(
                              icon: Icons.person_outline,
                              iconBg: const Color(0xFF2563EB).withOpacity(0.15),
                              iconColor: const Color(0xFF60A5FA),
                              label: 'Artists',
                              value: artistNames,
                            ),
                            if (album.releaseDate != null)
                              SingleModelDetailsWidgetInfoRow(
                                icon: Icons.calendar_today_outlined,
                                iconBg:
                                    const Color(0xFF059669).withOpacity(0.15),
                                iconColor: const Color(0xFF34D399),
                                label: 'Release Date',
                                value: album.releaseDate!,
                                isLast: true,
                              ),
                          ],
                        ),

                        const SizedBox(height: 14),

                        // ── Songs Card ─────────────────────────────────
                        if (album.songAlbum != null &&
                            album.songAlbum!.isNotEmpty)
                          SingleModelDetailsWidget(
                            Title: "Songs",
                            padding: const EdgeInsets.all(16),
                            children: [
                              SongRow(
                                Genresong: album.songAlbum ?? [],
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
                            // Update
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  Get.to(DynamicFormPage(
                                    title: 'Album',
                                    fields: AlbumForm,
                                    model: album,
                                  ));
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
                                        'Update Album',
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

// ── Helper Widgets ─────────────────────────────────────────────────────────────

class _NavBtn extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _NavBtn({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 38,
        height: 38,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white.withOpacity(0.08),
          border: Border.all(color: Colors.white.withOpacity(0.14), width: 0.5),
        ),
        child: Icon(icon, color: const Color(0xFFF0ECE4), size: 18),
      ),
    );
  }
}

class _CoverFallback extends StatelessWidget {
  final String title;

  const _CoverFallback({required this.title});

  @override
  Widget build(BuildContext context) {
    final initials = title.trim().isEmpty
        ? '?'
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
            fontSize: 48,
            fontWeight: FontWeight.w700,
            color: Color(0xFFE9D5FF),
          ),
        ),
      ),
    );
  }
}

class _Badge extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color bg, text, border;

  const _Badge(
      {required this.icon,
      required this.label,
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
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 11, color: text),
          const SizedBox(width: 4),
          Text(label,
              style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                  color: text,
                  letterSpacing: 0.4)),
        ],
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
                    fontSize: 24,
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
