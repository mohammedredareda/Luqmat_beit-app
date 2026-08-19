import 'package:core/core.dart';
import 'package:flutter/material.dart';

import '../../domain/entities/chef_profile_entity.dart';

/// Banner + avatar + bio + stats + follow button, per the chef-profile
/// mockup's header card.
class ChefProfileHeader extends StatelessWidget {
  const ChefProfileHeader({
    super.key,
    required this.profile,
    required this.onToggleFollow,
  });

  final ChefProfileEntity profile;
  final VoidCallback onToggleFollow;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: scheme.surface,
        borderRadius: BorderRadius.circular(AppRadius.sheet),
      ),
      child: Column(
        children: [
          Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.center,
            children: [
              SizedBox(
                height: 128,
                width: double.infinity,
                child: Image.network(profile.avatarUrl, fit: BoxFit.cover),
              ),
              PositionedDirectional(
                bottom: -48,
                child: Container(
                  width: 96,
                  height: 96,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: scheme.surface, width: 4),
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: Image.network(profile.avatarUrl, fit: BoxFit.cover),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(
              AppSpace.l,
              AppSpace.xxl + AppSpace.l,
              AppSpace.l,
              AppSpace.l,
            ),
            child: Column(
              children: [
                Text(
                  profile.name,
                  textAlign: TextAlign.center,
                  style: textTheme.headlineSmall
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: AppSpace.xs),
                Text(
                  profile.bio,
                  textAlign: TextAlign.center,
                  style: textTheme.bodyMedium
                      ?.copyWith(color: scheme.onSurfaceVariant),
                ),
                const SizedBox(height: AppSpace.l),
                Wrap(
                  alignment: WrapAlignment.center,
                  spacing: AppSpace.m,
                  runSpacing: AppSpace.s,
                  children: [
                    _StatChip(
                      color: scheme.surfaceContainerHigh,
                      foreground: scheme.onSurface,
                      icon: Icons.star,
                      iconColor: AppColors.honey,
                      label: profile.rating.toStringAsFixed(1),
                    ),
                    _StatChip(
                      color: scheme.surfaceContainerHigh,
                      foreground: scheme.onSurfaceVariant,
                      icon: Icons.location_on,
                      iconColor: scheme.onSurfaceVariant,
                      label: '${profile.distanceKm} كم',
                    ),
                    _StatChip(
                      color: scheme.secondaryContainer,
                      foreground: scheme.onSecondaryContainer,
                      icon: Icons.verified,
                      iconColor: scheme.onSecondaryContainer,
                      label: 'متاحة الآن',
                    ),
                  ],
                ),
                const SizedBox(height: AppSpace.l),
                SizedBox(
                  width: double.infinity,
                  child: profile.isFollowing
                      ? OutlinedButton.icon(
                          onPressed: onToggleFollow,
                          style: OutlinedButton.styleFrom(
                            foregroundColor: scheme.primary,
                            side: BorderSide(color: scheme.primary),
                            padding: const EdgeInsetsDirectional.symmetric(
                              vertical: AppSpace.m,
                            ),
                          ),
                          icon: const Icon(Icons.check),
                          label: const Text('متابَع'),
                        )
                      : ElevatedButton.icon(
                          onPressed: onToggleFollow,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: scheme.primary,
                            foregroundColor: scheme.onPrimary,
                            padding: const EdgeInsetsDirectional.symmetric(
                              vertical: AppSpace.m,
                            ),
                          ),
                          icon: const Icon(Icons.person_add),
                          label: const Text('متابعة'),
                        ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _StatChip extends StatelessWidget {
  const _StatChip({
    required this.color,
    required this.foreground,
    required this.icon,
    required this.iconColor,
    required this.label,
  });

  final Color color;
  final Color foreground;
  final IconData icon;
  final Color iconColor;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsetsDirectional.symmetric(
        horizontal: AppSpace.s,
        vertical: AppSpace.xs,
      ),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(AppRadius.card),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(label,
              style: TextStyle(color: foreground, fontWeight: FontWeight.bold)),
          const SizedBox(width: AppSpace.xs),
          Icon(icon, size: 18, color: iconColor),
        ],
      ),
    );
  }
}
