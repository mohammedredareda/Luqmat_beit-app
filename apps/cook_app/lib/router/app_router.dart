import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../features/meal_management/create_meal/presentation/pages/create_meal_page.dart';
import '../features/meal_management/edit_meal/presentation/pages/edit_meal_page.dart';
import '../features/meal_management/view_menu/presentation/pages/view_menu_page.dart';
import '../features/offers_management/create_discount/presentation/pages/create_discount_page.dart';
import '../features/order_management/order_details/presentation/pages/order_details_page.dart';
import '../features/order_management/view_orders/presentation/pages/orders_list_page.dart';
import '../features/offers_management/create_offer/presentation/pages/create_offer_page.dart';
import '../features/offers_management/edit_discount/presentation/pages/edit_discount_page.dart';
import '../features/offers_management/edit_offer/presentation/pages/edit_offer_page.dart';
import '../features/offers_management/view_offers/presentation/pages/view_offers_page.dart';
import '../features/profile/change_password/presentation/pages/change_password_page.dart';
import '../features/profile/change_phone_number/presentation/pages/change_phone_number_page.dart';
import '../features/profile/edit_profile/presentation/pages/edit_profile_page.dart';
import '../features/profile/view_profile/presentation/pages/profile_page.dart';
import '../features/settings/presentation/pages/settings_page.dart';
import '../l10n/generated/app_localizations.dart';
import 'placeholder_page.dart';

/// Four bottom-nav tabs (Menu/Orders/Offers/Account, R-03/R-04) wrapped in
/// a [StatefulShellRoute] so each tab keeps its own navigation stack, plus
/// top-level pushed routes for Add/Edit meal, Create/Edit offer, Create/Edit
/// discount, and notifications. Delete has no route of its own — CK-09/
/// CK-15's confirmations are dialogs shown directly from the calling widget
/// (`showDeleteMealConfirmation`/`showDeleteOfferConfirmation`/
/// `showDeleteDiscountConfirmation`), never a navigable screen.
GoRouter buildRouter() {
  return GoRouter(
    initialLocation: '/menu',
    routes: [
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) =>
            _CookAppScaffold(navigationShell: navigationShell),
        branches: [
          StatefulShellBranch(routes: [
            GoRoute(path: '/menu', builder: (context, state) => const ViewMenuPage()),
          ]),
          StatefulShellBranch(routes: [
            GoRoute(path: '/orders', builder: (context, state) => const OrdersListPage()),
          ]),
          StatefulShellBranch(routes: [
            GoRoute(path: '/offers', builder: (context, state) => const ViewOffersPage()),
          ]),
          StatefulShellBranch(routes: [
            GoRoute(path: '/account', builder: (context, state) => const ProfilePage()),
          ]),
        ],
      ),
      GoRoute(
        path: '/orders/:id',
        builder: (context, state) => OrderDetailsPage(orderId: state.pathParameters['id']!),
      ),
      GoRoute(
        path: '/meals/create',
        builder: (context, state) => const CreateMealPage(),
      ),
      GoRoute(
        path: '/meals/:id/edit',
        builder: (context, state) => EditMealPage(mealId: state.pathParameters['id']!),
      ),
      GoRoute(
        path: '/offers/create',
        builder: (context, state) => const CreateOfferPage(),
      ),
      GoRoute(
        path: '/offers/:id/edit',
        builder: (context, state) => EditOfferPage(offerId: state.pathParameters['id']!),
      ),
      GoRoute(
        path: '/discounts/create',
        builder: (context, state) => const CreateDiscountPage(),
      ),
      GoRoute(
        path: '/discounts/:id/edit',
        builder: (context, state) => EditDiscountPage(discountId: state.pathParameters['id']!),
      ),
      GoRoute(
        path: '/account/edit',
        builder: (context, state) => const EditProfilePage(),
      ),
      GoRoute(
        path: '/account/settings',
        builder: (context, state) => SettingsPage(initialPhoneNumber: state.extra as String?),
      ),
      GoRoute(
        path: '/account/settings/change-password',
        builder: (context, state) => const ChangePasswordPage(),
      ),
      GoRoute(
        path: '/account/settings/change-phone',
        builder: (context, state) => const ChangePhoneNumberPage(),
      ),
      GoRoute(
        path: '/notifications',
        builder: (context, state) =>
            PlaceholderPage(title: AppLocalizations.of(context)!.notificationsTitle),
      ),
      GoRoute(
        path: '/login',
        builder: (context, state) =>
            PlaceholderPage(title: AppLocalizations.of(context)!.loginTitle),
      ),
    ],
  );
}

class _CookAppScaffold extends StatelessWidget {
  const _CookAppScaffold({required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: NavigationBar(
        selectedIndex: navigationShell.currentIndex,
        onDestinationSelected: (index) => navigationShell.goBranch(
          index,
          initialLocation: index == navigationShell.currentIndex,
        ),
        destinations: [
          NavigationDestination(icon: const Icon(Icons.restaurant_menu), label: l10n.navMenu),
          NavigationDestination(icon: const Icon(Icons.receipt_long), label: l10n.navOrders),
          NavigationDestination(icon: const Icon(Icons.local_offer), label: l10n.navOffers),
          NavigationDestination(icon: const Icon(Icons.person), label: l10n.navAccount),
        ],
      ),
    );
  }
}
