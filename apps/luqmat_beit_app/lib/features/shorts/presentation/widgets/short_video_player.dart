import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

/// Full-bleed looping video for one [ShortSlide] — plays/pauses based on
/// [isActive] (the page currently centered in the vertical `PageView`),
/// muted-by-default like every short-video feed, tap-to-toggle-mute.
///
/// Falls back to a plain dark frame with an icon on load failure — the
/// backend's asset URLs are known to sometimes resolve to `localhost`
/// (an `ASSET_BASE_URL` misconfiguration on their end, not fixable here),
/// so a broken video must never crash the feed or leave a stuck spinner.
class ShortVideoPlayer extends StatefulWidget {
  const ShortVideoPlayer({super.key, required this.url, required this.isActive});

  final String url;
  final bool isActive;

  @override
  State<ShortVideoPlayer> createState() => _ShortVideoPlayerState();
}

class _ShortVideoPlayerState extends State<ShortVideoPlayer> {
  VideoPlayerController? _controller;
  bool _failed = false;
  bool _muted = true;

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
      await controller.setVolume(_muted ? 0 : 1);
      if (widget.isActive) await controller.play();
      setState(() {});
    } catch (_) {
      if (mounted) setState(() => _failed = true);
    }
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

  void _toggleMute() {
    final controller = _controller;
    if (controller == null) return;
    setState(() => _muted = !_muted);
    controller.setVolume(_muted ? 0 : 1);
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_failed) {
      return const ColoredBox(
        color: Colors.black,
        child: Center(
          child: Icon(Icons.videocam_off_outlined, color: Colors.white38, size: 48),
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
      onTap: _toggleMute,
      child: FittedBox(
        fit: BoxFit.cover,
        child: SizedBox(
          width: controller.value.size.width,
          height: controller.value.size.height,
          child: VideoPlayer(controller),
        ),
      ),
    );
  }
}
