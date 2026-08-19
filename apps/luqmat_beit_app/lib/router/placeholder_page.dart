import 'package:flutter/material.dart';

import '../l10n/generated/app_localizations.dart';

/// Trivial stand-in for a screen that isn't built yet (Orders/Offers/
/// Account tabs, Edit Meal, Create Meal, Notifications) — exists purely so
/// navigation from the My Menu dashboard never dead-ends or crashes.
/// Building the real screens is out of scope for this feature.
class PlaceholderPage extends StatelessWidget {
  const PlaceholderPage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(
        child: Text(l10n.comingSoon,
            style: Theme.of(context).textTheme.headlineSmall),
      ),
    );
  }
}
