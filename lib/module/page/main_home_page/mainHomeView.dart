import 'package:basic_fundamental/module/page/main_home_page/mainHomeController.dart';
import 'package:basic_fundamental/module/page/modelEditPage/controller/modelEditPageController.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

import '../../../data/registry/model_registry.dart';
import '../../../data/registry/model_type.dart';
import '../login/loginController.dart';
import '../modelEditPage/view/modelEditPageViews.dart';

class mainHomePage extends StatefulWidget {
  const mainHomePage({super.key});

  @override
  State<mainHomePage> createState() => _mainHomePageState();
}

class _mainHomePageState extends State<mainHomePage> {
  final mainHomeController getSong = Get.find<mainHomeController>();
  final GetModelEditController getModel = Get.find<GetModelEditController>();
  final auth_google_login auth = Get.find<auth_google_login>();

  // Icon & color config per model name
  static const Map<String, _ModelMeta> _modelMeta = {
    'Artist':      _ModelMeta(icon: Icons.person_outline_rounded,   gradient: [Color(0xFF7C3AED), Color(0xFF4F46E5)], glow: Color(0xFF7C3AED)),
    'Genre':       _ModelMeta(icon: Icons.music_note_outlined,       gradient: [Color(0xFFDB2777), Color(0xFF9333EA)], glow: Color(0xFFDB2777)),
    'Album':       _ModelMeta(icon: Icons.album_outlined,            gradient: [Color(0xFF0891B2), Color(0xFF2563EB)], glow: Color(0xFF0891B2)),
    'Songs':       _ModelMeta(icon: Icons.queue_music_outlined,      gradient: [Color(0xFF059669), Color(0xFF0891B2)], glow: Color(0xFF059669)),
    'MediaAsset':  _ModelMeta(icon: Icons.perm_media_outlined,       gradient: [Color(0xFFCA8A04), Color(0xFFEA580C)], glow: Color(0xFFCA8A04)),
    'SongStream':  _ModelMeta(icon: Icons.stream_outlined,           gradient: [Color(0xFFEA580C), Color(0xFFDC2626)], glow: Color(0xFFEA580C)),
    'Block_songs': _ModelMeta(icon: Icons.block_outlined,            gradient: [Color(0xFF475569), Color(0xFF334155)], glow: Color(0xFF475569)),
  };

  _ModelMeta _getMeta(String model) =>
      _modelMeta[model] ??
          const _ModelMeta(
            icon: Icons.grid_view_rounded,
            gradient: [Color(0xFF4F46E5), Color(0xFF7C3AED)],
            glow: Color(0xFF4F46E5),
          );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0F),
      body: Stack(
        children: [
          // ── Background orbs ───────────────────────────────────────
          Positioned(
            top: -60, left: -60,
            child: Container(
              width: 240, height: 240,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFF7C3AED).withOpacity(0.10),
              ),
            ),
          ),
          Positioned(
            top: 80, right: -40,
            child: Container(
              width: 180, height: 180,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFF2563EB).withOpacity(0.08),
              ),
            ),
          ),

          // ── Content ───────────────────────────────────────────────
          LiquidPullToRefresh(
            color: const Color(0xFF7C3AED),
            backgroundColor: const Color(0xFF12121A),
            onRefresh: () async {
              await getSong.refreshHome([getSong.showModel()]);
            },
            child: CustomScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              slivers: [
                // ── SliverAppBar ─────────────────────────────────
                SliverAppBar(
                  pinned: true,
                  backgroundColor: const Color(0xFF0A0A0F),
                  elevation: 0,
                  expandedHeight: 110,
                  flexibleSpace: FlexibleSpaceBar(
                    background: Container(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [Color(0xFF1A0B3B), Color(0xFF0A0A0F)],
                        ),
                      ),
                    ),
                    titlePadding: const EdgeInsets.only(left: 16, bottom: 16),
                    title: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'YT Developer',
                          style: TextStyle(
                            color: Color(0xFFF0ECE4),
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            letterSpacing: -0.3,
                          ),
                        ),
                        Text(
                          'Admin Panel',
                          style: TextStyle(
                            color: const Color(0xFFF0ECE4).withOpacity(0.40),
                            fontSize: 11,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ],
                    ),
                  ),
                  leading: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        gradient: const LinearGradient(
                          colors: [Color(0xFF7C3AED), Color(0xFF4F46E5)],
                        ),
                      ),
                      child: const Center(
                        child: Text(
                          'YT',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ),
                  actions: [
                    // Logout
                    GestureDetector(
                      onTap: () => auth.signOut(),
                      child: Container(
                        margin: const EdgeInsets.only(right: 8),
                        width: 38, height: 38,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white.withOpacity(0.07),
                          border: Border.all(
                            color: Colors.white.withOpacity(0.12),
                            width: 0.5,
                          ),
                        ),
                        child: Icon(
                          Icons.logout_rounded,
                          color: const Color(0xFFF0ECE4).withOpacity(0.70),
                          size: 18,
                        ),
                      ),
                    ),
                    // Avatar
                    Padding(
                      padding: const EdgeInsets.only(right: 16),
                      child: Container(
                        width: 38, height: 38,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: const LinearGradient(
                            colors: [Color(0xFF7C3AED), Color(0xFFDB2777)],
                          ),
                        ),
                        child: ClipOval(
                          child: Image.asset(
                            'assets/_joker1.png',
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) => const Icon(
                              Icons.person,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                  bottom: PreferredSize(
                    preferredSize: const Size.fromHeight(0.5),
                    child: Container(
                      height: 0.5,
                      color: Colors.white.withOpacity(0.07),
                    ),
                  ),
                ),

                // ── Body ─────────────────────────────────────────
                SliverToBoxAdapter(
                  child: Obx(() {
                    if (getSong.error.isNotEmpty) {
                      return SizedBox(
                        height: MediaQuery.of(context).size.height * 0.75,
                        child: Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                width: 64, height: 64,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: const Color(0xFFDC2626).withOpacity(0.10),
                                ),
                                child: const Icon(
                                  Icons.error_outline_rounded,
                                  color: Color(0xFFF87171),
                                  size: 28,
                                ),
                              ),
                              const SizedBox(height: 14),
                              Text(
                                getSong.error.value.replaceAll('Exception:', '').trim(),
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: const Color(0xFFF0ECE4).withOpacity(0.50),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }

                    return Padding(
                      padding: const EdgeInsets.fromLTRB(16, 20, 16, 32),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Section label
                          Padding(
                            padding: const EdgeInsets.only(left: 4, bottom: 16),
                            child: Row(
                              children: [
                                Text(
                                  'MANAGE',
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600,
                                    letterSpacing: 1.5,
                                    color: const Color(0xFFF0ECE4).withOpacity(0.25),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Divider(
                                    color: Colors.white.withOpacity(0.07),
                                    thickness: 0.5,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF7C3AED).withOpacity(0.12),
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(
                                      color: const Color(0xFF7C3AED).withOpacity(0.25),
                                      width: 0.5,
                                    ),
                                  ),
                                  child: Text(
                                    '${getSong.gets_model.length} models',
                                    style: const TextStyle(
                                      fontSize: 10,
                                      color: Color(0xFFA78BFA),
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          // Model grid
                          AnimationLimiter(
                            child: ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: getSong.gets_model.length,
                              itemBuilder: (context, index) {
                                final model = getSong.gets_model[index];
                                final meta = _getMeta(model);

                                return AnimationConfiguration.staggeredList(
                                  position: index,
                                  duration: const Duration(milliseconds: 450),
                                  child: SlideAnimation(
                                    horizontalOffset: 60.0,
                                    child: FadeInAnimation(
                                      child: Padding(
                                        padding: const EdgeInsets.only(bottom: 10),
                                        child: _ModelCard(
                                          model: model,
                                          meta: meta,
                                          onTap: () {
                                            final modelType = getModelType(model);
                                            final definition = ModelRegistry.models[modelType]!;
                                            Get.to(
                                                  () => ModelEditView(definition: definition),
                                              transition: Transition.rightToLeft,
                                              duration: const Duration(milliseconds: 280),
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ── Model Meta ────────────────────────────────────────────────────────────────

class _ModelMeta {
  final IconData icon;
  final List<Color> gradient;
  final Color glow;
  const _ModelMeta({required this.icon, required this.gradient, required this.glow});
}

// ── Model Card ────────────────────────────────────────────────────────────────

class _ModelCard extends StatefulWidget {
  final String model;
  final _ModelMeta meta;
  final VoidCallback onTap;

  const _ModelCard({
    required this.model,
    required this.meta,
    required this.onTap,
  });

  @override
  State<_ModelCard> createState() => _ModelCardState();
}

class _ModelCardState extends State<_ModelCard> {
  bool _pressed = false;

  String get _subtitle {
    const Map<String, String> subs = {
      'Artist':      'Manage all artists',
      'Genre':       'Manage music genres',
      'Album':       'Manage albums',
      'Songs':       'Manage songs & tracks',
      'MediaAsset':  'Manage media files',
      'SongStream':  'Manage audio streams',
      'Block_songs': 'Manage blocked songs',
    };
    return subs[widget.model] ?? 'Manage ${widget.model}';
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _pressed = true),
      onTapUp: (_) {
        setState(() => _pressed = false);
        widget.onTap();
      },
      onTapCancel: () => setState(() => _pressed = false),
      child: AnimatedScale(
        scale: _pressed ? 0.97 : 1.0,
        duration: const Duration(milliseconds: 120),
        child: Container(
          height: 76,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.04),
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: Colors.white.withOpacity(0.08),
              width: 0.5,
            ),
            boxShadow: _pressed
                ? []
                : [
              BoxShadow(
                color: widget.meta.glow.withOpacity(0.08),
                blurRadius: 20,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            children: [
              const SizedBox(width: 14),

              // ── Gradient icon box ──────────────────────────────
              Container(
                width: 46, height: 46,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(13),
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: widget.meta.gradient,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: widget.meta.glow.withOpacity(0.30),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Icon(widget.meta.icon, color: Colors.white, size: 22),
              ),

              const SizedBox(width: 14),

              // ── Text ──────────────────────────────────────────
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.model,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFFF0ECE4),
                        letterSpacing: -0.2,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      _subtitle,
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w300,
                        color: const Color(0xFFF0ECE4).withOpacity(0.35),
                      ),
                    ),
                  ],
                ),
              ),

              // ── Arrow ─────────────────────────────────────────
              Container(
                width: 30, height: 30,
                margin: const EdgeInsets.only(right: 14),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(9),
                ),
                child: Icon(
                  Icons.chevron_right_rounded,
                  color: const Color(0xFFF0ECE4).withOpacity(0.35),
                  size: 18,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}