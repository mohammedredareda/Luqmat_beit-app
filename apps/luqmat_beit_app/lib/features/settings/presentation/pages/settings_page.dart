import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:luqmat_beit_app/di/injection.dart';
import 'package:luqmat_beit_app/l10n/generated/app_localizations.dart';

import '../widgets/settings_list_tile.dart';

/// Settings — reached from the "حسابي" tab (R-03/R-04, no 5th bottom-nav
/// destination). No backlog story of its own; built from the `settings`
/// mockup. Holds the current phone number locally so its subtitle can
/// refresh after a successful Change Phone Number flow without a refetch.
class SettingsPage extends StatefulWidget {
  const SettingsPage({
    super.key,
    this.initialPhoneNumber,
    this.changePasswordRoute = '/cook/account/settings/change-password',
    this.changePhoneRoute = '/cook/account/settings/change-phone',
  });

  final String? initialPhoneNumber;

  /// Role-specific push targets — defaults to the cook routes so the cook
  /// call site needs no change; the customer call site passes its own
  /// `/settings/...` paths. `ChangePasswordPage`/`ChangePhoneNumberPage`
  /// themselves are role-agnostic (see their datasources' doc comments),
  /// only the route paths differ per role.
  final String changePasswordRoute;
  final String changePhoneRoute;

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  late String? _phoneNumber = widget.initialPhoneNumber;

  Future<void> _openChangePhoneNumber(BuildContext context) async {
    final result = await context.push<String>(widget.changePhoneRoute);
    if (result != null && mounted) {
      setState(() => _phoneNumber = result);
    }
  }

  Future<void> _pickLanguage(BuildContext context) async {
    final l10n = AppLocalizations.of(context)!;
    final localeCubit = context.read<LocaleCubit>();
    final selected = await showDialog<Locale>(
      context: context,
      builder: (dialogContext) => SimpleDialog(
        title: Text(l10n.languageLabel),
        children: [
          SimpleDialogOption(
            onPressed: () => Navigator.of(dialogContext).pop(const Locale('ar')),
            child: Text(l10n.arabicLanguageOption),
          ),
          SimpleDialogOption(
            onPressed: () => Navigator.of(dialogContext).pop(const Locale('en')),
            child: Text(l10n.englishLanguageOption),
          ),
        ],
      ),
    );
    if (selected != null) {
      await localeCubit.setLocale(selected);
    }
  }

  Future<void> _handleLogout(BuildContext context) async {
    final l10n = AppLocalizations.of(context)!;
    final confirmed = await ConfirmationDialog.show(
      context,
      title: l10n.logoutConfirmTitle,
      message: l10n.logoutConfirmBody,
      confirmLabel: l10n.logoutCta,
      cancelLabel: l10n.cancelLabel,
      isDestructive: true,
    );
    if (confirmed == true) {
      // The router's `refreshListenable` redirects to /login the moment
      // the session flips to unauthenticated — no manual navigation needed.
      await getIt<SessionCubit>().logOut();
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final scheme = Theme.of(context).colorScheme;
    final locale = context.watch<LocaleCubit>().state;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.settingsTitle)),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: AppSpace.l),
        children: [
          Padding(
            padding: const EdgeInsetsDirectional.symmetric(horizontal: AppSpace.l),
            child: Text(l10n.accountSettingsSectionTitle, style: Theme.of(context).textTheme.titleMedium),
          ),
          const SizedBox(height: AppSpace.s),
          Card(
            margin: const EdgeInsetsDirectional.symmetric(horizontal: AppSpace.l),
            child: Column(
              children: [
                SettingsListTile(
                  icon: Icons.smartphone,
                  title: l10n.changePhoneNumberRowTitle,
                  subtitle: _phoneNumber,
                  subtitleTextDirection: TextDirection.ltr,
                  onTap: () => _openChangePhoneNumber(context),
                ),
                const Divider(height: 1, indent: AppSpace.l, endIndent: AppSpace.l),
                SettingsListTile(
                  icon: Icons.lock_outline,
                  title: l10n.changePasswordRowTitle,
                  onTap: () => context.push(widget.changePasswordRoute),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpace.xl),
          Padding(
            padding: const EdgeInsetsDirectional.symmetric(horizontal: AppSpace.l),
            child: Text(l10n.preferencesSectionTitle, style: Theme.of(context).textTheme.titleMedium),
          ),
          const SizedBox(height: AppSpace.s),
          Card(
            margin: const EdgeInsetsDirectional.symmetric(horizontal: AppSpace.l),
            child: Column(
              children: [
                SettingsListTile(
                  icon: Icons.language,
                  title: l10n.languageLabel,
                  subtitle: locale.languageCode == 'ar' ? l10n.arabicLanguageOption : l10n.englishLanguageOption,
                  onTap: () => _pickLanguage(context),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpace.xxl),
          Padding(
            padding: const EdgeInsetsDirectional.symmetric(horizontal: AppSpace.l),
            child: SizedBox(
              height: 48,
              child: ElevatedButton.icon(
                onPressed: () => _handleLogout(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: scheme.errorContainer,
                  foregroundColor: scheme.onErrorContainer,
                  elevation: 0,
                ),
                icon: const Icon(Icons.logout),
                label: Text(l10n.logoutCta),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
