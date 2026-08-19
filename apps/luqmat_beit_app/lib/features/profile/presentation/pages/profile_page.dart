import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../di/injection.dart';
import '../../../../l10n/generated/app_localizations.dart';
import '../../../../shared/widgets/customer_bottom_nav.dart';
// Reused directly from Settings — same row shape, same cross-feature leaf
// widget reuse already done for `ProfileAvatarPicker` this session.
import '../../../settings/presentation/widgets/settings_list_tile.dart';
import '../../domain/entities/customer_profile_entity.dart';
import '../../domain/repositories/profile_repository.dart';
import '../../domain/usecases/get_profile.dart';
import '../cubit/profile_cubit.dart';
import '../cubit/profile_state.dart';
import '../widgets/profile_details_card.dart';
import '../widgets/profile_header.dart';
import '../widgets/profile_skeleton.dart';
import '../widgets/profile_stat_card.dart';

/// Customer profile — mirrors the cook module's `view_profile` shell
/// exactly (branded AppBar + settings action, avatar/name header, stat
/// tiles, one details card, a single "Edit profile" button pushing a
/// dedicated route) rather than the old inline-edit layout. Reached from
/// the "حسابي" bottom-nav tab.
class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ProfileCubit(GetProfile(getIt<ProfileRepository>()))..load(),
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
            tooltip: l10n.settingsTitle,
            icon: const Icon(Icons.settings_outlined),
            onPressed: () {
              final state = context.read<ProfileCubit>().state;
              final phone = state is ProfileLoaded ? state.profile.phone : null;
              context.push('/settings', extra: phone);
            },
          ),
        ],
      ),
      body: BlocBuilder<ProfileCubit, ProfileState>(
        builder: (context, state) {
          return switch (state) {
            ProfileInitial() || ProfileLoading() => const ProfileSkeleton(),
            ProfileFailure(:final exception) => EmptyState(
                icon: Icons.wifi_off,
                title: l10n.genericErrorMessage,
                message: exception.message,
                actionLabel: l10n.retryLabel,
                onAction: () => context.read<ProfileCubit>().load(),
              ),
            ProfileLoaded(:final profile) => _LoadedBody(profile: profile),
          };
        },
      ),
      bottomNavigationBar: const CustomerBottomNav(currentTab: CustomerNavTab.profile),
    );
  }
}

class _LoadedBody extends StatelessWidget {
  const _LoadedBody({required this.profile});

  final CustomerProfileEntity profile;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return ListView(
      padding: const EdgeInsetsDirectional.all(AppSpace.l),
      children: [
        ProfileHeader(avatarUrl: profile.avatarUrl, name: profile.name),
        const SizedBox(height: AppSpace.xl),
        Row(
          children: [
            Expanded(
              child: ProfileStatCard(
                icon: Icons.check_circle_outline,
                label: l10n.completedOrdersStatLabel,
                value: '${profile.completedOrdersCount}',
              ),
            ),
            const SizedBox(width: AppSpace.m),
            Expanded(
              child: ProfileStatCard(
                icon: Icons.favorite_outline,
                label: l10n.favoritesStatLabel,
                value: '${profile.favoritesCount}',
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpace.xl),
        Card(
          margin: EdgeInsets.zero,
          child: SettingsListTile(
            icon: Icons.history,
            title: l10n.orderHistoryTitle,
            onTap: () => context.push('/order-history'),
          ),
        ),
        const SizedBox(height: AppSpace.xl),
        ProfileDetailsCard(address: profile.address),
        const SizedBox(height: AppSpace.xl),
        SizedBox(
          height: 48,
          child: ElevatedButton.icon(
            onPressed: () => context.push('/profile/edit').then((changed) {
              if (changed == true && context.mounted) {
                context.read<ProfileCubit>().load();
              }
            }),
            icon: const Icon(Icons.edit_outlined, size: 20),
            label: Text(l10n.editProfileCta),
          ),
        ),
      ],
    );
  }
}
