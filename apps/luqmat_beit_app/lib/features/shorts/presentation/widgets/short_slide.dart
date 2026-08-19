import 'package:flutter/material.dart';

import '../../domain/entities/short_entity.dart';
import 'short_action_column.dart';
import 'short_caption_bar.dart';
import 'short_video_player.dart';

/// One full-bleed slide of the vertical feed — real video playback via
/// [ShortVideoPlayer], with the like/comment/order overlay from
/// `shorts_feed_u17/code.html` layered on top via a vignette gradient.
class ShortSlide extends StatelessWidget {
  const ShortSlide({
    super.key,
    required this.short,
    required this.isActive,
    required this.onLike,
    required this.onComment,
    required this.onOrderMeal,
    required this.onFollow,
    required this.onTapCook,
  });

  final ShortEntity short;
  final bool isActive;
  final VoidCallback onLike;
  final VoidCallback onComment;
  final VoidCallback onOrderMeal;
  final VoidCallback onFollow;
  final VoidCallback onTapCook;

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        ShortVideoPlayer(url: short.videoUrl, isActive: isActive),
        // Vignette overlay, matching `.vignette-overlay` in the mockup —
        // purely decorative, must never intercept the tap-to-pause gesture
        // meant for the video underneath it.
        const IgnorePointer(
          child: DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0x66000000),
                  Colors.transparent,
                  Colors.transparent,
                  Color(0xCC000000),
                ],
                stops: [0.0, 0.2, 0.6, 1.0],
              ),
            ),
          ),
        ),
        SafeArea(
          child: Padding(
            padding: const EdgeInsetsDirectional.symmetric(
              horizontal: 16,
              vertical: 16,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: ShortCaptionBar(
                        short: short,
                        onOrderMeal: onOrderMeal,
                        onFollow: onFollow,
                        onTapCook: onTapCook,
                      ),
                    ),
                    ShortActionColumn(
                      short: short,
                      onLike: onLike,
                      onComment: onComment,
                    ),
                  ],
                ),
                // Bottom-nav clearance so the overlay content doesn't sit
                // underneath the transparent nav bar.
                const SizedBox(height: 72),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
