import 'package:basic_fundamental/module/page/main_home_page/mainHomeController.dart';
import 'package:basic_fundamental/module/page/modelEditPage/widgets/model_tile/artist_tile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../data/data_model/Artist.dart';
import '../../controller/modelEditPageController.dart';
import '../forms/definitions/artist_form.dart';
import '../forms/widgets/dynamic_form.dart';
import '../helperwidget/commanWidgets.dart';
import '../helperwidget/helper_widget.dart';

class ArtistDetail extends StatelessWidget {
  final Artist artist;
  final mainHomeController controller = Get.find<mainHomeController>();
  final GetModelEditController getModelEditController =
      Get.find<GetModelEditController>();

  ArtistDetail({
    super.key,
    required this.artist,
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
                // Top Bar
                appBar(
                  title: 'Artist Profile',
                  onTap: () {},
                ),
                // Scrollable body
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.only(bottom: 32),
                    child: Column(
                      children: [
                        const SizedBox(height: 12),

                        // Avatar with gradient ring
                        Container(
                          width: 110,
                          height: 110,
                          padding: const EdgeInsets.all(3),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: const LinearGradient(
                              colors: [
                                Color(0xFF7C3AED),
                                Color(0xFF2563EB),
                                Color(0xFFDB2777),
                              ],
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0xFF7C3AED).withOpacity(0.4),
                                blurRadius: 30,
                                spreadRadius: 2,
                              ),
                            ],
                          ),
                          child: Container(
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color(0xFF0A0A0F),
                            ),
                            child: GestureDetector(
                              onTap: () {
                                Get.dialog(
                                  ModelImage(
                                    image: artist.artistImage!,
                                  ),
                                  barrierColor: Colors.transparent,
                                );
                              },
                              child: ClipOval(
                                child: (artist.artistImage != null &&
                                        artist.artistImage!.isNotEmpty)
                                    ? Image.network(
                                        artist.artistImage!,
                                        fit: BoxFit.cover,
                                        errorBuilder: (_, __, ___) =>
                                            _AvatarFallback(
                                                name: artist.artistName ?? ''),
                                      )
                                    : _AvatarFallback(
                                        name: artist.artistName ?? ''),
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 14),

                        // Artist Name
                        Text(
                          artist.artistName ?? '',
                          style: const TextStyle(
                            fontFamily: 'serif',
                            fontSize: 26,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFFF0ECE4),
                            letterSpacing: -0.3,
                          ),
                        ),

                        const SizedBox(height: 8),

                        // Badges
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            if (artist.country != null &&
                                artist.country!.isNotEmpty)
                              SingleModelDetailsWidgetBadge(
                                label: artist.country!,
                                icon: Icons.location_on_outlined,
                                bgColor:
                                    const Color(0xFF60A5FA).withOpacity(0.12),
                                textColor: const Color(0xFF60A5FA),
                                borderColor:
                                    const Color(0xFF60A5FA).withOpacity(0.25),
                              ),
                            const SizedBox(width: 8),
                            SingleModelDetailsWidgetBadge(
                              label: 'Legend',
                              icon: Icons.star_outline,
                              bgColor:
                                  const Color(0xFFC084FC).withOpacity(0.12),
                              textColor: const Color(0xFFC084FC),
                              borderColor:
                                  const Color(0xFFC084FC).withOpacity(0.25),
                            ),
                          ],
                        ),

                        const SizedBox(height: 12),

                        // Bio
                        if (artist.artistBio != null &&
                            artist.artistBio!.isNotEmpty)
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 30),
                            child: Text(
                              artist.artistBio!,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w300,
                                color:
                                    const Color(0xFFF0ECE4).withOpacity(0.45),
                                height: 1.6,
                              ),
                            ),
                          ),

                        const SizedBox(height: 24),

                        // Stats Row
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.06),
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                color: Colors.white.withOpacity(0.08),
                                width: 0.5,
                              ),
                            ),
                            child: const Row(
                              children: [
                                _StatItem(value: '142', label: 'Songs'),
                                _StatItem(value: '38', label: 'Albums'),
                                _StatItem(value: '2.4M', label: 'Fans'),
                                _StatItem(
                                    value: '12', label: 'Awards', isLast: true),
                              ],
                            ),
                          ),
                        ),

                        const SizedBox(height: 24),

                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: SingleModelDetailsWidget(
                            padding: const EdgeInsets.all(16),
                            Title: 'Artist Details',
                            children: [
                              SingleModelDetailsWidgetInfoRow(
                                icon: Icons.person_outline,
                                iconBg:
                                    const Color(0xFF7C3AED).withOpacity(0.15),
                                iconColor: const Color(0xFFA78BFA),
                                label: 'Full Name',
                                value: artist.artistName ?? '',
                              ),
                              SingleModelDetailsWidgetInfoRow(
                                icon: Icons.location_on_outlined,
                                iconBg:
                                    const Color(0xFF2563EB).withOpacity(0.15),
                                iconColor: const Color(0xFF60A5FA),
                                label: 'Country',
                                value: artist.country ?? '',
                              ),
                              SingleModelDetailsWidgetInfoRow(
                                icon: Icons.calendar_today_outlined,
                                iconBg:
                                    const Color(0xFF059669).withOpacity(0.15),
                                iconColor: const Color(0xFF34D399),
                                label: 'Active Since',
                                value: '2005',
                              ),
                              SingleModelDetailsWidgetInfoRow(
                                icon: Icons.mic_none_outlined,
                                iconBg:
                                    const Color(0xFFCA8A04).withOpacity(0.15),
                                iconColor: const Color(0xFFFACC15),
                                label: 'Role',
                                value: 'Actor · Playback Singer',
                              ),
                              SingleModelDetailsWidgetInfoRow(
                                icon: Icons.music_note_outlined,
                                iconBg:
                                    const Color(0xFFDB2777).withOpacity(0.15),
                                iconColor: const Color(0xFFF472B6),
                                label: 'Genres',
                                isLast: true,
                                customChild: const Wrap(
                                  spacing: 7,
                                  runSpacing: 6,
                                  children: [
                                    SingleModelDetailsWidgetGenreTag(
                                      label: 'Tamil Folk',
                                      bgColor: Color(0x1AA78BFA),
                                      textColor: Color(0xFFA78BFA),
                                      borderColor: Color(0x33A78BFA),
                                    ),
                                    SingleModelDetailsWidgetGenreTag(
                                      label: 'Classical',
                                      bgColor: Color(0x1A34D399),
                                      textColor: Color(0xFF34D399),
                                      borderColor: Color(0x3334D399),
                                    ),
                                    SingleModelDetailsWidgetGenreTag(
                                      label: 'Cinematic',
                                      bgColor: Color(0x1AFACC15),
                                      textColor: Color(0xFFFACC15),
                                      borderColor: Color(0x33FACC15),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 16),

                        // Divider
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Divider(
                            color: Colors.white.withOpacity(0.07),
                            thickness: 0.5,
                          ),
                        ),

                        const SizedBox(height: 16),

                        // Action Buttons
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Row(
                            children: [
                              // Update Button
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    Get.to(DynamicFormPage(
                                      title: "Artist",
                                      fields: artistForm,
                                      model: artist,
                                    ));
                                  },
                                  child: Container(
                                    height: 52,
                                    decoration: BoxDecoration(
                                      gradient: const LinearGradient(
                                        colors: [
                                          Color(0xFF5B21B6),
                                          Color(0xFF2563EB),
                                          // Colors.red,
                                          // Colors.yellow
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(Icons.edit_outlined,
                                            color: Colors.white, size: 18),
                                        SizedBox(width: 8),
                                        Text(
                                          'Update Artist',
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

                              // Delete Button
                              GestureDetector(
                                onTap: () async {
                                  await ArtistTile.Helper_code_for_delete_artist(artist: artist, getModelEditController: getModelEditController,isPop: true);
                                },
                                child: Container(
                                  width: 52,
                                  height: 52,
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFDC2626)
                                        .withOpacity(0.12),
                                    borderRadius: BorderRadius.circular(14),
                                    border: Border.all(
                                      color: const Color(0xFFDC2626)
                                          .withOpacity(0.3),
                                      width: 1,
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

// ── Helper Widgets ────────────────────────────────────────────────────────────

class _AvatarFallback extends StatelessWidget {
  final String name;

  const _AvatarFallback({required this.name});

  @override
  Widget build(BuildContext context) {
    final initials = name.trim().isEmpty
        ? '?'
        : name.trim().split(' ').take(2).map((w) => w[0].toUpperCase()).join();
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
            fontSize: 34,
            fontWeight: FontWeight.w700,
            color: Color(0xFFE9D5FF),
          ),
        ),
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final String value;
  final String label;
  final bool isLast;

  const _StatItem({
    required this.value,
    required this.label,
    this.isLast = false,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.03),
          border: isLast
              ? null
              : Border(
                  right: BorderSide(
                    color: Colors.white.withOpacity(0.07),
                    width: 0.5,
                  ),
                ),
        ),
        child: Column(
          children: [
            Text(
              value,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: Color(0xFFF0ECE4),
              ),
            ),
            const SizedBox(height: 2),
            Text(
              label.toUpperCase(),
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w400,
                color: const Color(0xFFF0ECE4).withOpacity(0.35),
                letterSpacing: 0.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
