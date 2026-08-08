import 'package:core/core.dart';
import 'package:flutter/material.dart';

import 'package:cook_app/l10n/generated/app_localizations.dart';

/// Avatar + name + rating row, matching `profile_with_stats`'s header
/// section. Personal photos are always circular (R-25, hard rule) — never
/// the 4:3 aspect ratio meal images use.
class ProfileHeader extends StatelessWidget {
  const ProfileHeader({
    super.key,
    required this.photoUrl,
    required this.name,
    required this.rate,
    required this.ratingCount,
  });

  final String? photoUrl;
  final String name;
  final double rate;
  final int ratingCount;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final hasPhoto = photoUrl != null && photoUrl!.isNotEmpty;

    return Column(
      children: [
        Container(
          width: 128,
          height: 128,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: scheme.surfaceContainerHighest,
            border: Border.all(color: scheme.surface, width: 4),
            boxShadow: AppShadow.e1,
          ),
          clipBehavior: Clip.antiAlias,
          child: hasPhoto
              ? Image.network(photoUrl!, fit: BoxFit.cover)
              : Icon(Icons.person, size: 64, color: scheme.onSurfaceVariant),
        ),
        const SizedBox(height: AppSpace.l),
        Text(name, style: textTheme.headlineSmall),
        const SizedBox(height: AppSpace.xs),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.star, size: 18, color: AppColors.honey),
            const SizedBox(width: AppSpace.xs),
            Text(
              l10n.profileRatingLabel(rate.toStringAsFixed(1), ratingCount),
              style: textTheme.bodyLarge?.copyWith(color: scheme.onSurfaceVariant),
            ),
          ],
        ),
      ],
    );
  }
}
