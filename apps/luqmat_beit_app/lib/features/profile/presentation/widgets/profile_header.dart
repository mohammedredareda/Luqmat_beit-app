import 'package:core/core.dart';
import 'package:flutter/material.dart';

/// Avatar + name, mirroring the cook module's `ProfileHeader`
/// (`cook_profile/view_profile/presentation/widgets/profile_header.dart`)
/// minus the rating row — customers have no rating. Personal photos are
/// always circular (R-25, hard rule) — never the 4:3 meal-image ratio.
class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key, required this.avatarUrl, required this.name});

  final String? avatarUrl;
  final String name;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final hasPhoto = avatarUrl != null && avatarUrl!.isNotEmpty;

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
              ? Image.network(avatarUrl!, fit: BoxFit.cover)
              : Icon(Icons.person, size: 64, color: scheme.onSurfaceVariant),
        ),
        const SizedBox(height: AppSpace.l),
        Text(name, style: Theme.of(context).textTheme.headlineSmall),
      ],
    );
  }
}
