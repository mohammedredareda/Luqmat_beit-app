import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

/// Full-bleed looping video for one [ShortSlide] — plays/pauses based on
/// [isActive] (the page currently centered in the vertical `PageView`,
/// combined with whether this whole screen is the topmost route — see
/// `ShortsFeedPage`'s `RouteAware` wiring), sound on by default (cooking
/// content relies on it), tap-to-pause/resume.
///
/// Falls back to a plain dark frame with an icon on load failure — the
/// backend's asset URLs are known to sometimes resolve to `localhost`
/// (an `ASSET_BASE_URL` misconfiguration on their end, not fixable here),
/// so a broken video must never crash the feed or leave a stuck spinner.
class ShortVideoPlayer extends StatefulWidget {
  const ShortVideoPlayer(
      {super.key, required this.url, required this.isActive});

  final String url;
  final bool isActive;

  @override
  State<ShortVideoPlayer> createState() => _ShortVideoPlayerState();
}

class _ShortVideoPlayerState extends State<ShortVideoPlayer> {
  VideoPlayerController? _controller;
  bool _failed = false;

  @override
  void initState() {
    super.initState();
    _initialize();
  }

  Future<void> _initialize() async {
    final controller = VideoPlayerController.networkUrl(Uri.parse(widget.url));
    _controller = controller;
    try {
      await controller.initialize();
      if (!mounted) return;
      await controller.setLooping(true);
      await controller.setVolume(1);
      if (widget.isActive) await controller.play();
      // The play/pause icon (and anything else reading `controller.value`)
      // has to react to state changes the *controller* makes on its own
      // timeline (pause()/play() are async — the value updates only once
      // the native player confirms it), not just to our own setState calls.
      controller.addListener(_onControllerChanged);
      setState(() {});
    } catch (_) {
      if (mounted) setState(() => _failed = true);
    }
  }

  void _onControllerChanged() {
    if (mounted) setState(() {});
  }

  @override
  void didUpdateWidget(covariant ShortVideoPlayer oldWidget) {
    super.didUpdateWidget(oldWidget);
    final controller = _controller;
    if (controller == null || !controller.value.isInitialized) return;
    if (widget.isActive && !oldWidget.isActive) {
      controller.play();
    } else if (!widget.isActive && oldWidget.isActive) {
      controller.pause();
    }
  }

  void _togglePlayPause() {
    final controller = _controller;
    if (controller == null || !controller.value.isInitialized) return;
    if (controller.value.isPlaying) {
      controller.pause();
    } else {
      controller.play();
    }
  }

  @override
  void dispose() {
    _controller
      ?..removeListener(_onControllerChanged)
      ..dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_failed) {
      return const ColoredBox(
        color: Colors.black,
        child: Center(
          child: Icon(Icons.videocam_off_outlined,
              color: Colors.white38, size: 48),
        ),
      );
    }

    final controller = _controller;
    if (controller == null || !controller.value.isInitialized) {
      return const ColoredBox(
        color: Colors.black,
        child: Center(child: CircularProgressIndicator(color: Colors.white54)),
      );
    }

    return GestureDetector(
      onTap: _togglePlayPause,
      child: Stack(
        alignment: Alignment.center,
        children: [
          FittedBox(
            fit: BoxFit.cover,
            child: SizedBox(
              width: controller.value.size.width,
              height: controller.value.size.height,
              child: VideoPlayer(controller),
            ),
          ),
          if (!controller.value.isPlaying)
            const Icon(Icons.play_arrow, color: Colors.white70, size: 72),
        ],
      ),
    );
  }
}
