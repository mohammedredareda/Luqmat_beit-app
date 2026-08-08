import 'package:core/core.dart';
import 'package:flutter/material.dart';

import '../cubit/notifications_state.dart' show NotificationsTab;

/// The "إشعاراتي" / "إشعارات النظام" segmented tab row from the mockup.
class NotificationsTabBar extends StatelessWidget {
  const NotificationsTabBar({
    super.key,
    required this.selectedTab,
    required this.onChanged,
  });

  final NotificationsTab selectedTab;
  final ValueChanged<NotificationsTab> onChanged;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Container(
      decoration: BoxDecoration(
        border: BorderDirectional(
          bottom: BorderSide(color: scheme.outlineVariant, width: 2),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: _Tab(
              label: 'إشعاراتي',
              isSelected: selectedTab == NotificationsTab.personal,
              onTap: () => onChanged(NotificationsTab.personal),
            ),
          ),
          Expanded(
            child: _Tab(
              label: 'إشعارات النظام',
              isSelected: selectedTab == NotificationsTab.system,
              onTap: () => onChanged(NotificationsTab.system),
            ),
          ),
        ],
      ),
    );
  }
}

class _Tab extends StatelessWidget {
  const _Tab({required this.label, required this.isSelected, required this.onTap});

  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsetsDirectional.symmetric(vertical: AppSpace.m),
            child: Text(
              label,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: isSelected ? scheme.primary : scheme.onSurfaceVariant,
                  ),
            ),
          ),
          Container(
            height: 2,
            color: isSelected ? scheme.primary : Colors.transparent,
          ),
        ],
      ),
    );
  }
}
