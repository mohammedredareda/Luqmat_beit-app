import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../di/injection.dart';
import '../../../../shared/widgets/customer_bottom_nav.dart';
import '../../domain/entities/customer_profile_entity.dart';
import '../../domain/repositories/profile_repository.dart';
import '../../domain/usecases/get_profile.dart';
import '../../domain/usecases/update_profile.dart';
import '../cubit/profile_cubit.dart';
import '../cubit/profile_state.dart';
import '../widgets/profile_stat_card.dart';

/// Customer counterpart of the cook module's shared `profile_with_stats` /
/// `edit_profile` mockups — same shell (avatar, stat cards, editable
/// details, one primary edit/save action), with cook-only fields
/// (availability hours, bio, rating) dropped and a delivery `address` kept
/// instead. Reached from the "حسابي" bottom-nav tab.
class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ProfileCubit(
        GetProfile(getIt<ProfileRepository>()),
        UpdateProfile(getIt<ProfileRepository>()),
      )..load(),
      child: const _ProfileView(),
    );
  }
}

class _ProfileView extends StatelessWidget {
  const _ProfileView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('حسابي'),
        actions: [
          IconButton(
            tooltip: 'تسجيل الخروج',
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await getIt<SessionCubit>().logOut();
              if (context.mounted) context.go('/login');
            },
          ),
        ],
      ),
      body: BlocBuilder<ProfileCubit, ProfileState>(
        builder: (context, state) {
          return switch (state) {
            ProfileInitial() || ProfileLoading() => const Center(
                child: Padding(
                  padding: EdgeInsetsDirectional.all(AppSpace.xxl),
                  child: LoadingSkeleton(height: 200),
                ),
              ),
            ProfileFailure(:final exception) => EmptyState(
                icon: Icons.wifi_off,
                title: 'تعذر تحميل الملف الشخصي',
                message: exception.message,
                actionLabel: 'إعادة المحاولة',
                onAction: () => context.read<ProfileCubit>().load(),
              ),
            ProfileLoaded(:final profile, :final isEditing, :final isSaving) =>
              _ProfileContent(profile: profile, isEditing: isEditing, isSaving: isSaving),
          };
        },
      ),
      bottomNavigationBar: const CustomerBottomNav(currentTab: CustomerNavTab.profile),
    );
  }
}

class _ProfileContent extends StatefulWidget {
  const _ProfileContent({
    required this.profile,
    required this.isEditing,
    required this.isSaving,
  });

  final CustomerProfileEntity profile;
  final bool isEditing;
  final bool isSaving;

  @override
  State<_ProfileContent> createState() => _ProfileContentState();
}

class _ProfileContentState extends State<_ProfileContent> {
  late final TextEditingController _nameController =
      TextEditingController(text: widget.profile.name);
  late final TextEditingController _addressController =
      TextEditingController(text: widget.profile.address);

  @override
  void didUpdateWidget(covariant _ProfileContent oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!widget.isEditing && oldWidget.isEditing) {
      // Edit was cancelled or a save just landed — reset the fields back to
      // whatever the (possibly reverted) profile now holds.
      _nameController.text = widget.profile.name;
      _addressController.text = widget.profile.address;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final profile = widget.profile;
    final isEditing = widget.isEditing;

    return SingleChildScrollView(
      padding: const EdgeInsetsDirectional.all(AppSpace.l),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Center(
            child: Column(
              children: [
                CircleAvatar(
                  radius: 56,
                  backgroundColor: scheme.surfaceContainerHigh,
                  backgroundImage:
                      profile.avatarUrl != null ? NetworkImage(profile.avatarUrl!) : null,
                  child: profile.avatarUrl == null
                      ? Icon(Icons.person, size: 56, color: scheme.onSurfaceVariant)
                      : null,
                ),
                const SizedBox(height: AppSpace.l),
                if (isEditing)
                  SizedBox(
                    width: 260,
                    child: TextField(
                      controller: _nameController,
                      textAlign: TextAlign.center,
                      style: textTheme.headlineSmall,
                      decoration: const InputDecoration(border: OutlineInputBorder()),
                    ),
                  )
                else
                  Text(profile.name, style: textTheme.headlineSmall),
              ],
            ),
          ),
          const SizedBox(height: AppSpace.xl),
          Row(
            children: [
              Expanded(
                child: ProfileStatCard(
                  icon: Icons.check_circle_outline,
                  label: 'الطلبات المكتملة',
                  value: '${profile.completedOrdersCount}',
                ),
              ),
              const SizedBox(width: AppSpace.m),
              Expanded(
                child: ProfileStatCard(
                  icon: Icons.favorite_outline,
                  label: 'المفضلة',
                  value: '${profile.favoritesCount}',
                ),
              ),
              const SizedBox(width: AppSpace.m),
              Expanded(
                child: ProfileStatCard(
                  icon: Icons.call_outlined,
                  label: 'رقم الهاتف',
                  value: profile.phone,
                  textDirection: TextDirection.ltr,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpace.xl),
          Container(
            padding: const EdgeInsetsDirectional.all(AppSpace.l),
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
                    const SizedBox(width: AppSpace.xs),
                    Text('العنوان', style: textTheme.labelLarge),
                  ],
                ),
                const SizedBox(height: AppSpace.s),
                if (isEditing)
                  TextField(
                    controller: _addressController,
                    maxLines: 2,
                    decoration: const InputDecoration(border: OutlineInputBorder()),
                  )
                else
                  Text(profile.address, style: textTheme.bodyLarge),
              ],
            ),
          ),
          const SizedBox(height: AppSpace.xl),
          if (isEditing)
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: widget.isSaving
                        ? null
                        : () => context.read<ProfileCubit>().save(
                              name: _nameController.text.trim(),
                              address: _addressController.text.trim(),
                            ),
                    child: widget.isSaving
                        ? const SizedBox(
                            width: 18,
                            height: 18,
                            child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                          )
                        : const Text('حفظ التغييرات'),
                  ),
                ),
                const SizedBox(width: AppSpace.m),
                Expanded(
                  child: OutlinedButton(
                    onPressed: widget.isSaving
                        ? null
                        : () => context.read<ProfileCubit>().cancelEdit(),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: scheme.onSurface,
                      side: BorderSide(color: scheme.outline),
                    ),
                    child: const Text('إلغاء'),
                  ),
                ),
              ],
            )
          else
            ElevatedButton.icon(
              onPressed: () => context.read<ProfileCubit>().toggleEdit(),
              icon: const Icon(Icons.edit_outlined, size: 20),
              label: const Text('تعديل الملف الشخصي'),
            ),
        ],
      ),
    );
  }
}
