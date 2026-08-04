import 'dart:ui' as ui;

import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:cook_app/l10n/generated/app_localizations.dart';

import 'avatar_image_saver/avatar_image_saver.dart';

/// A picked photo's path/size, once cropped and re-saved.
typedef CroppedAvatar = ({String path, int sizeBytes});

/// Lets the cook pan and zoom the picked photo inside a circular frame
/// before it becomes the avatar (R-25: profile photos are always
/// circular). Captures exactly what's visible inside the frame via
/// [RenderRepaintBoundary] — no manual crop-math needed, and it works
/// identically whether the source image is a local file or a network/blob
/// URL, since it operates on rendered pixels, not the original bytes.
class AvatarCropDialog extends StatefulWidget {
  const AvatarCropDialog({super.key, required this.imageProvider});

  final ImageProvider imageProvider;

  static Future<CroppedAvatar?> show(
    BuildContext context, {
    required ImageProvider imageProvider,
  }) {
    return showDialog<CroppedAvatar>(
      context: context,
      barrierColor: Colors.black,
      builder: (_) => AvatarCropDialog(imageProvider: imageProvider),
    );
  }

  @override
  State<AvatarCropDialog> createState() => _AvatarCropDialogState();
}

class _AvatarCropDialogState extends State<AvatarCropDialog> {
  static const double _frameSize = 280;

  final _boundaryKey = GlobalKey();
  bool _saving = false;

  Future<void> _confirm() async {
    setState(() => _saving = true);
    try {
      final boundary =
          _boundaryKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
      final dpr = MediaQuery.of(context).devicePixelRatio;
      final image = await boundary.toImage(pixelRatio: dpr);
      final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
      final bytes = byteData!.buffer.asUint8List();
      final path = await saveAvatarImageBytes(bytes);
      if (!mounted) return;
      Navigator.of(context).pop((path: path, sizeBytes: bytes.length));
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Dialog.fullscreen(
      backgroundColor: Colors.black,
      child: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpace.s, vertical: AppSpace.xs),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(Icons.close, color: Colors.white),
                  ),
                  Text(
                    l10n.cropAvatarTitle,
                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
                  ),
                  IconButton(
                    onPressed: _saving ? null : _confirm,
                    icon: _saving
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                          )
                        : const Icon(Icons.check, color: Colors.white),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Center(
                child: RepaintBoundary(
                  key: _boundaryKey,
                  child: ClipOval(
                    child: Container(
                      width: _frameSize,
                      height: _frameSize,
                      color: Colors.black,
                      child: InteractiveViewer(
                        minScale: 1,
                        maxScale: 4,
                        boundaryMargin: const EdgeInsets.all(double.infinity),
                        child: SizedBox(
                          width: _frameSize,
                          height: _frameSize,
                          child: Image(image: widget.imageProvider, fit: BoxFit.cover),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(AppSpace.l),
              child: Text(
                l10n.cropAvatarHint,
                style: const TextStyle(color: Colors.white70),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
