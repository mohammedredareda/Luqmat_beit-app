import 'dart:io';

import 'package:core/core.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

/// The image-picker drop-zone shared across every feature that needs a
/// 4:3 photo (R-25) — meal photos and, since offers can optionally carry
/// their own bundle photo, offer photos too. Empty state shows a dashed
/// border + camera icon + [hintLabel]; once an image is picked, shows the
/// preview with a [changeLabel] overlay button.
class ImagePickerField extends StatelessWidget {
  const ImagePickerField({
    super.key,
    required this.imagePath,
    required this.hintLabel,
    required this.changeLabel,
    required this.onImagePicked,
    this.errorText,
  });

  final String? imagePath;
  final String hintLabel;
  final String changeLabel;
  final void Function(String path, int sizeBytes) onImagePicked;
  final String? errorText;

  Future<void> _pickImage(BuildContext context) async {
    final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (picked == null) return;
    final sizeBytes = await picked.length();
    onImagePicked(picked.path, sizeBytes);
  }

  /// A path here is either a pre-existing remote `imageUrl` (prefilled on
  /// edit) or whatever `image_picker` returned for a fresh pick — a real
  /// filesystem path on mobile/desktop, but a `blob:` URL on web
  /// (`image_picker`'s web implementation never exposes a real path, and
  /// `Image.file` isn't supported on web at all). `Image.network` handles
  /// `http(s):`/`blob:` alike, so only a genuine local path on a non-web
  /// platform should ever reach `Image.file`.
  Widget _buildImage(String path) {
    final isRemote = kIsWeb || path.startsWith('http://') || path.startsWith('https://');
    if (isRemote) return Image.network(path, fit: BoxFit.cover);
    return Image.file(File(path), fit: BoxFit.cover);
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final hasImage = imagePath != null && imagePath!.isNotEmpty;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AspectRatio(
          aspectRatio: 4 / 3,
          child: InkWell(
            onTap: () => _pickImage(context),
            borderRadius: BorderRadius.circular(AppRadius.image),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppRadius.image),
                border: hasImage
                    ? null
                    : Border.all(
                        color: errorText != null ? scheme.error : scheme.outline,
                        width: 1.5,
                      ),
                color: scheme.surfaceContainerHighest,
              ),
              clipBehavior: Clip.antiAlias,
              child: hasImage
                  ? Stack(
                      fit: StackFit.expand,
                      children: [
                        _buildImage(imagePath!),
                        Positioned(
                          bottom: AppSpace.s,
                          left: AppSpace.s,
                          right: AppSpace.s,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: AppSpace.m,
                              vertical: AppSpace.s,
                            ),
                            decoration: BoxDecoration(
                              color: scheme.scrim,
                              borderRadius: BorderRadius.circular(AppRadius.pill),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(Icons.photo_camera_outlined,
                                    color: Colors.white, size: 18),
                                const SizedBox(width: AppSpace.xs),
                                Text(
                                  changeLabel,
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelLarge
                                      ?.copyWith(color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    )
                  : Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.photo_camera_outlined, size: 32, color: scheme.onSurfaceVariant),
                          const SizedBox(height: AppSpace.s),
                          Text(hintLabel, style: Theme.of(context).textTheme.bodyMedium),
                        ],
                      ),
                    ),
            ),
          ),
        ),
        if (errorText != null) ...[
          const SizedBox(height: AppSpace.xs),
          Text(errorText!, style: Theme.of(context).textTheme.bodySmall?.copyWith(color: scheme.error)),
        ],
      ],
    );
  }
}
