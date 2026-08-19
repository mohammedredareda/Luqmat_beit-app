import 'package:core/core.dart';
import 'package:flutter/material.dart';

import 'package:luqmat_beit_app/l10n/generated/app_localizations.dart';

/// One bordered card showing the delivery address, mirroring the cook
/// module's `ProfileDetailsCard`
/// (`cook_profile/view_profile/presentation/widgets/profile_details_card.dart`)
/// minus the bio/availability sections — customers have neither.
class ProfileDetailsCard extends StatelessWidget {
  const ProfileDetailsCard({super.key, required this.address});

  final String address;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final scheme = Theme.of(context).colorScheme;

    return Container(
      padding: AppSpace.cardPadding,
      decoration: BoxDecoration(
        color: scheme.surface,
        borderRadius: BorderRadius.circular(AppRadius.card),
        border: Border.all(color: scheme.outlineVariant),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.location_on_outlined, size: 20, color: scheme.onSurfaceVariant),
              const SizedBox(width: AppSpace.s),
              Text(l10n.addressSectionTitle, style: Theme.of(context).textTheme.titleMedium),
            ],
          ),
          const SizedBox(height: AppSpace.m),
          Text(address, style: Theme.of(context).textTheme.bodyLarge),
        ],
      ),
    );
  }
}
