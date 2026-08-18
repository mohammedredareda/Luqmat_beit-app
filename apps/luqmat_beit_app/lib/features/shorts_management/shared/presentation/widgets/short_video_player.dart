import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import 'package:core/core.dart';

/// Plays an already-constructed [VideoPlayerController] in place —
/// source-agnostic (the caller decides `.file(...)` for a locally-picked
/// clip not yet uploaded, or `.networkUrl(...)` for an already-published
/// short's real remote URL) so this single widget backs both the create
/// flow's pre-publish preview and the gallery's watch dialog. Owns the
/// controller's init/listen/dispose lifecycle regardless of how it was
/// constructed. Give this a `key` derived from whatever identifies the
/// video (e.g. the path or URL) at the call site so Flutter tears down and
/// rebuilds it — and disposes the old controller — whenever the source
/// changes; the widget does not do that itself since it doesn't know what
/// identifies "a different video" for its caller.
class ShortVideoPlayer extends StatefulWidget {
  const ShortVideoPlayer({
    super.key,
    required this.controller,
    this.onChangeVideo,
    this.muted = false,
  });

  final VideoPlayerController controller;

  /// Shows a "change video" edit-icon overlay when non-null (the create
  /// flow's pre-publish use case). Omitted entirely (no overlay) when null
  /// (the watch-dialog use case — there's nothing to change).
  final VoidCallback? onChangeVideo;

  /// Muted by default fits the create flow's silent pre-publish preview;
  /// the watch dialog passes `false` since actually watching a published
  /// short should have sound.
  final bool muted;

  @override
  State<ShortVideoPlayer> createState() => _ShortVideoPlayerState();
}

class _ShortVideoPlayerState extends State<ShortVideoPlayer> {
  bool _ready = false;

  /// Height of the bottom strip reserved exclusively for the scrubber —
  /// the tap-to-play [GestureDetector] stops short of this so the two
  /// never compete for the same touch.
  static const double _progressBarZoneHeight = AppSpace.xxl;

  @override
  void initState() {
    super.initState();
    widget.controller
      ..addListener(_onControllerUpdate)
      ..setVolume(widget.muted ? 0 : 1)
      ..initialize().then((_) {
        if (mounted) setState(() => _ready = true);
      });
  }

  void _onControllerUpdate() {
    if (mounted) setState(() {});
  }

  void _togglePlay() {
    if (widget.controller.value.isPlaying) {
      widget.controller.pause();
    } else {
      widget.controller.play();
    }
  }

  @override
  void dispose() {
    widget.controller.removeListener(_onControllerUpdate);
    widget.controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return ClipRRect(
      borderRadius: BorderRadius.circular(AppRadius.image),
      child: Container(
        constraints: const BoxConstraints(minHeight: 200),
        color: scheme.surfaceContainerHighest,
        child: !_ready
            ? const SizedBox(
                height: 200,
                child: Center(child: CircularProgressIndicator()),
              )
            : Stack(
                alignment: Alignment.center,
                children: [
                  // Unconstrained/non-positioned as before — this is what
                  // gives the Stack (and therefore the whole player) its
                  // natural size, so it must stay free of any Positioned
                  // wrapper that would force it into a tight box (that was
                  // tried and visibly shrank the video — AspectRatio has no
                  // room to size itself within a box that's already exact
                  // on both axes).
                  AspectRatio(
                    aspectRatio: widget.controller.value.aspectRatio,
                    child: VideoPlayer(widget.controller),
                  ),
                  // A separate, purely hit-testing overlay — reserves the
                  // bottom strip for the scrubber below so tap-to-play
                  // never geometrically competes with it. Two
                  // GestureDetectors sharing the same screen area left the
                  // scrubber's drag/tap gestures competing in the same
                  // arena as this one's plain tap, and the scrubber
                  // consistently lost (no seek, no pause-on-drag-start).
                  // Kept separate from the AspectRatio above specifically
                  // so constraining ITS box doesn't affect the video's own
                  // layout.
                  PositionedDirectional(
                    top: 0,
                    start: 0,
                    end: 0,
                    bottom: _progressBarZoneHeight,
                    child: GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: _togglePlay,
                      child: const SizedBox.expand(),
                    ),
                  ),
                  if (!widget.controller.value.isPlaying)
                    IgnorePointer(
                      child: Icon(
                        Icons.play_circle,
                        size: 56,
                        color: Colors.white.withValues(alpha: 0.9),
                      ),
                    ),
                  if (widget.onChangeVideo != null)
                    PositionedDirectional(
                      top: AppSpace.s,
                      end: AppSpace.s,
                      child: Material(
                        color: Colors.black.withValues(alpha: 0.45),
                        shape: const CircleBorder(),
                        child: InkWell(
                          customBorder: const CircleBorder(),
                          onTap: widget.onChangeVideo,
                          child: const Padding(
                            padding: EdgeInsets.all(AppSpace.xs),
                            child: Icon(Icons.edit_outlined, size: 18, color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  PositionedDirectional(
                    bottom: 0,
                    start: 0,
                    end: 0,
                    child: VideoProgressIndicator(
                      widget.controller,
                      allowScrubbing: true,
                      padding: const EdgeInsets.symmetric(horizontal: AppSpace.s, vertical: AppSpace.s),
                      colors: VideoProgressColors(
                        playedColor: scheme.primary,
                        bufferedColor: scheme.primary.withValues(alpha: 0.3),
                        backgroundColor: Colors.white.withValues(alpha: 0.3),
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
