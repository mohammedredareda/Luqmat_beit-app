import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:cook_app/di/injection.dart';
import 'package:cook_app/l10n/generated/app_localizations.dart';

import '../../../domain/cook_profile_details.dart';
import '../bloc/profile_cubit.dart';
import '../bloc/profile_state.dart';
import '../widgets/profile_details_card.dart';
import '../widgets/profile_header.dart';
import '../widgets/profile_skeleton.dart';
import '../widgets/profile_stats_row.dart';

/// CK-21 View Profile — the cook's own profile, reached from the "حسابي"
/// (My Account) bottom-nav tab.
class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<ProfileCubit>()..loadProfile(),
      child: const _ProfileView(),
    );
  }
}

class _ProfileView extends StatelessWidget {
  const _ProfileView();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Luqmat Beit',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: Theme.of(context).colorScheme.primary,
              ),
        ),
        actions: [
          IconButton(
            onPressed: () => context.push('/notifications'),
            icon: const Icon(Icons.notifications_outlined),
            tooltip: l10n.notificationsTitle,
          ),
          IconButton(
            onPressed: () {
              final state = context.read<ProfileCubit>().state;
              final phoneNumber = state is ProfileLoaded ? state.profile.phoneNumber : null;
              context.push('/account/settings', extra: phoneNumber);
            },
            icon: const Icon(Icons.settings_outlined),
            tooltip: l10n.settingsTitle,
          ),
        ],
      ),
      body: BlocBuilder<ProfileCubit, ProfileState>(
        builder: (context, state) => state.when(
          initial: () => const SizedBox.shrink(),
          loading: () => const ProfileSkeleton(),
          loaded: (profile) => _LoadedBody(profile: profile),
          error: (exception) => _ErrorBody(message: exception.message),
        ),
      ),
    );
  }
}

class _LoadedBody extends StatelessWidget {
  const _LoadedBody({required this.profile});

  final CookProfileDetails profile;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return ListView(
      padding: const EdgeInsets.all(AppSpace.l),
      children: [
        ProfileHeader(
          photoUrl: profile.profile.photoUrl,
          name: profile.profile.name,
          rate: profile.profile.rate,
          ratingCount: profile.profile.ratingCount,
        ),
        const SizedBox(height: AppSpace.xl),
        ProfileStatsRow(phoneNumber: profile.phoneNumber),
        const SizedBox(height: AppSpace.xl),
        ProfileDetailsCard(
          bio: profile.profile.description,
          availabilityTime: profile.profile.availabilityTime,
          address: profile.address,
        ),
        const SizedBox(height: AppSpace.xl),
        SizedBox(
          width: double.infinity,
          height: 48,
          child: ElevatedButton.icon(
            onPressed: () => context.push('/account/edit').then((_) {
              if (context.mounted) context.read<ProfileCubit>().loadProfile();
            }),
            icon: const Icon(Icons.edit_outlined),
            label: Text(l10n.editProfileCta),
          ),
        ),
      ],
    );
  }
}

class _ErrorBody extends StatelessWidget {
  const _ErrorBody({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final scheme = Theme.of(context).colorScheme;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpace.xl),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.error_outline, size: 48, color: scheme.error),
            const SizedBox(height: AppSpace.m),
            Text(message, textAlign: TextAlign.center),
            const SizedBox(height: AppSpace.l),
            OutlinedButton(
              onPressed: () => context.read<ProfileCubit>().loadProfile(),
              child: Text(l10n.retryLabel),
            ),
          ],
        ),
      ),
    );
  }
}
