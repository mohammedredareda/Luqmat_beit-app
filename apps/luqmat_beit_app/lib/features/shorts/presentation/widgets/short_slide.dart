import 'package:flutter/material.dart';

import '../../domain/entities/short_entity.dart';
import 'short_action_column.dart';
import 'short_caption_bar.dart';

/// One full-bleed slide of the vertical feed — a still image standing in
/// for video playback (see `ShortsMockDataSource` doc comment), with the
/// like/comment/share/order overlay from `shorts_feed_u17/code.html`
/// layered on top via a vignette gradient.
class ShortSlide extends StatelessWidget {
  const ShortSlide({
    super.key,
    required this.short,
    required this.onLike,
    required this.onComment,
    required this.onShare,
    required this.onOrderMeal,
  });

  final ShortEntity short;
  final VoidCallback onLike;
  final VoidCallback onComment;
  final VoidCallback onShare;
  final VoidCallback onOrderMeal;

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Image.network(short.thumbnailUrl, fit: BoxFit.cover),
        // Vignette overlay, matching `.vignette-overlay` in the mockup.
        DecoratedBox(
          decoration: const BoxDecoration(
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
                      child: ShortCaptionBar(short: short, onOrderMeal: onOrderMeal),
                    ),
                    ShortActionColumn(
                      short: short,
                      onLike: onLike,
                      onComment: onComment,
                      onShare: onShare,
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
