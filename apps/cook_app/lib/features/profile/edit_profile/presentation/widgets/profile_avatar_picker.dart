import 'dart:io';

import 'package:core/core.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:cook_app/l10n/generated/app_localizations.dart';

import 'avatar_crop_dialog.dart';

/// Circular avatar picker for Edit Profile (R-25: personal photos are
/// always circular, never the 4:3 aspect ratio meals use — unlike
/// `MealImagePickerField`'s dropzone). Same local-vs-remote image
/// resolution as that widget's `_buildImage`. Every pick is routed
/// through [AvatarCropDialog] so the cook controls exactly what's framed
/// before it's saved, rather than getting whatever `image_picker`'s
/// gallery crop (or lack thereof) happened to return.
class ProfileAvatarPicker extends StatelessWidget {
  const ProfileAvatarPicker({
    super.key,
    required this.avatarPath,
    required this.onImagePicked,
    this.errorText,
  });

  final String? avatarPath;
  final void Function(String path, int sizeBytes) onImagePicked;
  final String? errorText;

  ImageProvider _providerFor(String path) {
    final isRemote = kIsWeb || path.startsWith('http://') || path.startsWith('https://');
    return isRemote ? NetworkImage(path) : FileImage(File(path));
  }

  Future<void> _pickImage(BuildContext context) async {
    final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (picked == null) return;
    if (!context.mounted) return;
    final cropped = await AvatarCropDialog.show(context, imageProvider: _providerFor(picked.path));
    if (cropped == null) return;
    onImagePicked(cropped.path, cropped.sizeBytes);
  }

  Widget _buildImage(String path) {
    final isRemote = kIsWeb || path.startsWith('http://') || path.startsWith('https://');
    if (isRemote) return Image.network(path, fit: BoxFit.cover);
    return Image.file(File(path), fit: BoxFit.cover);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final scheme = Theme.of(context).colorScheme;
    final hasAvatar = avatarPath != null && avatarPath!.isNotEmpty;

    return Column(
      children: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            InkWell(
              onTap: () => _pickImage(context),
              customBorder: const CircleBorder(),
              child: Container(
                width: 112,
                height: 112,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: scheme.surfaceContainerHighest,
                  border: Border.all(
                    color: errorText != null ? scheme.error : scheme.outlineVariant,
                    width: 1.5,
                  ),
                ),
                clipBehavior: Clip.antiAlias,
                child: hasAvatar
                    ? _buildImage(avatarPath!)
                    : Icon(Icons.person, size: 56, color: scheme.onSurfaceVariant),
              ),
            ),
            PositionedDirectional(
              bottom: 0,
              end: 0,
              child: Material(
                color: scheme.primary,
                shape: const CircleBorder(),
                child: InkWell(
                  onTap: () => _pickImage(context),
                  customBorder: const CircleBorder(),
                  child: SizedBox(
                    width: 32,
                    height: 32,
                    child: Icon(Icons.edit, size: 16, color: scheme.onPrimary),
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpace.s),
        TextButton(
          onPressed: () => _pickImage(context),
          child: Text(l10n.changePhotoCta),
        ),
        if (errorText != null)
          Text(errorText!, style: Theme.of(context).textTheme.bodySmall?.copyWith(color: scheme.error)),
      ],
    );
  }
}
