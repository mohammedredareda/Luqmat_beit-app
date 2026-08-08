import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

enum CustomerNavTab { home, orders, shorts, favorites, profile }

/// Bottom navigation shared by Home, My Orders, Shorts, Favorites and
/// Profile — matches the translated nav bar in every customer_app mockup.
class CustomerBottomNav extends StatelessWidget {
  const CustomerBottomNav({super.key, required this.currentTab});

  final CustomerNavTab currentTab;

  static const _tabs = [
    (tab: CustomerNavTab.home, icon: Icons.home, label: 'الرئيسية', path: '/'),
    (tab: CustomerNavTab.orders, icon: Icons.reorder, label: 'طلباتي', path: '/orders'),
    (tab: CustomerNavTab.shorts, icon: Icons.play_circle, label: 'الشورتس', path: '/shorts'),
    (tab: CustomerNavTab.favorites, icon: Icons.favorite, label: 'المفضلة', path: '/favorites'),
    (tab: CustomerNavTab.profile, icon: Icons.person, label: 'حسابي', path: '/profile'),
  ];

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Material(
      color: scheme.surface,
      elevation: 8,
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: 72,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              for (final entry in _tabs)
                _NavItem(
                  icon: entry.icon,
                  label: entry.label,
                  isSelected: entry.tab == currentTab,
                  onTap: () => context.go(entry.path),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  const _NavItem({
    required this.icon,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsetsDirectional.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: isSelected ? scheme.primaryContainer : Colors.transparent,
          borderRadius: BorderRadius.circular(999),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: isSelected ? scheme.onPrimaryContainer : scheme.onSurfaceVariant,
            ),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: isSelected ? scheme.onPrimaryContainer : scheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
