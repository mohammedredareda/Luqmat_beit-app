import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../di/injection.dart';
import '../../domain/usecases/get_notifications.dart';
import '../../domain/usecases/mark_notification_as_read.dart';
import '../cubit/notifications_cubit.dart';
import '../cubit/notifications_state.dart';
import '../widgets/notification_list_tile.dart';
import '../widgets/notifications_tab_bar.dart';

/// CU-24 — Notifications screen. No bottom nav bar on this screen per the
/// approved mockup (notifications_u10_wireframe_match/code.html).
class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => NotificationsCubit(
        GetNotifications(getIt()),
        MarkNotificationAsRead(getIt()),
      )..load(),
      child: const _NotificationsView(),
    );
  }
}

class _NotificationsView extends StatelessWidget {
  const _NotificationsView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surfaceContainerLow,
      body: SafeArea(
        child: BlocBuilder<NotificationsCubit, NotificationsState>(
          builder: (context, state) {
            return switch (state) {
              NotificationsInitial() ||
              NotificationsLoading() =>
                const _NotificationsLoadingSkeleton(),
              NotificationsFailure(:final exception) => EmptyState(
                  icon: Icons.wifi_off,
                  title: 'تعذر تحميل الإشعارات',
                  message: exception.message,
                  actionLabel: 'إعادة المحاولة',
                  onAction: () => context.read<NotificationsCubit>().load(),
                ),
              NotificationsLoaded(:final notifications, :final selectedTab) =>
                _NotificationsContent(
                  notifications: notifications,
                  selectedTab: selectedTab,
                ),
            };
          },
        ),
      ),
    );
  }
}

class _NotificationsContent extends StatelessWidget {
  const _NotificationsContent({
    required this.notifications,
    required this.selectedTab,
  });

  final List<NotificationEntity> notifications;
  final NotificationsTab selectedTab;

  @override
  Widget build(BuildContext context) {
    final filtered = notifications
        .where((n) => selectedTab == NotificationsTab.system
            ? n.type == NotificationType.system
            : n.type != NotificationType.system)
        .toList();

    return Column(
      children: [
        Padding(
          padding: const EdgeInsetsDirectional.symmetric(
            horizontal: AppSpace.l,
            vertical: AppSpace.l,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Align(
                alignment: AlignmentDirectional.centerEnd,
                child: Text(
                  'الإشعارات',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
              const SizedBox(height: AppSpace.l),
              NotificationsTabBar(
                selectedTab: selectedTab,
                onChanged: (tab) =>
                    context.read<NotificationsCubit>().selectTab(tab),
              ),
            ],
          ),
        ),
        Expanded(
          child: filtered.isEmpty
              ? const EmptyState(
                  icon: Icons.notifications_none,
                  title: 'لا توجد إشعارات هنا',
                  message: 'ستظهر إشعاراتك في هذا القسم فور وصولها.',
                )
              : ListView.separated(
                  padding: const EdgeInsetsDirectional.symmetric(
                    horizontal: AppSpace.l,
                    vertical: AppSpace.l,
                  ),
                  itemCount: filtered.length,
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: AppSpace.l),
                  itemBuilder: (context, index) {
                    final notification = filtered[index];
                    return NotificationListTile(
                      notification: notification,
                      onTap: () => context
                          .read<NotificationsCubit>()
                          .markAsRead(notification.id),
                    );
                  },
                ),
        ),
      ],
    );
  }
}

class _NotificationsLoadingSkeleton extends StatelessWidget {
  const _NotificationsLoadingSkeleton();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsetsDirectional.all(AppSpace.l),
      children: const [
        LoadingSkeleton(height: 30, width: 140),
        SizedBox(height: AppSpace.xl),
        LoadingSkeleton(height: 92, borderRadius: 16),
        SizedBox(height: AppSpace.l),
        LoadingSkeleton(height: 92, borderRadius: 16),
        SizedBox(height: AppSpace.l),
        LoadingSkeleton(height: 92, borderRadius: 16),
      ],
    );
  }
}
