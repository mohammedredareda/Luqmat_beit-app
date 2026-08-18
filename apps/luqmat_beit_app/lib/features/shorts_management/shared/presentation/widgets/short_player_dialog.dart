import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import 'package:core/core.dart';

import 'short_video_player.dart';

/// Lets a cook watch a short she's already published — the single entry
/// point `my_shorts_page.dart`'s gallery card tap calls, mirroring
/// `delete_short_confirmation.dart`'s "one entry point" convention. Reuses
/// [ShortVideoPlayer] (the same player the create flow uses for its
/// pre-publish preview) built against the real remote `videoUrl` instead of
/// a local file, unmuted since actually watching a published clip should
/// have sound.
Future<void> showShortPlayerDialog(
  BuildContext context, {
  required String videoUrl,
  required String description,
  required int viewCount,
}) {
  return showDialog<void>(
    context: context,
    builder: (context) => Dialog.fullscreen(
      backgroundColor: Colors.black,
      child: Stack(
        alignment: Alignment.center,
        children: [
          ShortVideoPlayer(
            key: ValueKey(videoUrl),
            controller: VideoPlayerController.networkUrl(Uri.parse(videoUrl)),
          ),
          PositionedDirectional(
            bottom: AppSpace.xxl,
            start: 0,
            end: 0,
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.transparent, Colors.black.withValues(alpha: 0.75)],
                ),
              ),
              child: Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(AppSpace.l, AppSpace.xxl, AppSpace.l, AppSpace.s),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.visibility_outlined, size: 16, color: Colors.white),
                        const SizedBox(width: AppSpace.xs),
                        Text(
                          _formatViewCount(viewCount),
                          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                    if (description.isNotEmpty) ...[
                      const SizedBox(height: AppSpace.xs),
                      Text(
                        description,
                        style: const TextStyle(color: Colors.white),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),
          PositionedDirectional(
            top: AppSpace.l,
            end: AppSpace.l,
            child: Material(
              color: Colors.black.withValues(alpha: 0.45),
              shape: const CircleBorder(),
              child: InkWell(
                customBorder: const CircleBorder(),
                onTap: () => Navigator.of(context).pop(),
                child: const Padding(
                  padding: EdgeInsets.all(AppSpace.s),
                  child: Icon(Icons.close, size: 24, color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

/// Matches `ShortGalleryCard._formatViewCount`'s exact "1.2k"-style
/// formatting so the count reads identically whether seen on the gallery
/// card or in this dialog.
String _formatViewCount(int count) {
  if (count < 1000) return '$count';
  return '${(count / 1000).toStringAsFixed(count % 1000 >= 100 ? 1 : 0)}k';
}
