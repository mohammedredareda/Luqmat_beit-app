import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../di/injection.dart';
import '../features/auth/presentation/pages/forgot_password_page.dart';
import '../features/auth/presentation/pages/login_page.dart';
import '../features/auth/presentation/pages/otp_verification_page.dart';
import '../features/auth/presentation/pages/registration_page.dart';
import '../features/auth/presentation/pages/reset_password_page.dart';
import '../features/cart/presentation/pages/shopping_cart_page.dart';
import '../features/chef_profile/presentation/pages/chef_profile_page.dart';
import '../features/cook_profile/change_password/presentation/pages/change_password_page.dart';
import '../features/cook_profile/change_phone_number/presentation/pages/change_phone_number_page.dart';
// Aliased alongside the cook `ProfilePage` import below — `EditProfilePage`
// collides by name with the new customer `profile/edit_profile` feature's
// own page (see the unaliased import further down).
import '../features/cook_profile/edit_profile/presentation/pages/edit_profile_page.dart'
    as cook;
import '../features/cook_profile/view_profile/presentation/pages/profile_page.dart'
    as cook;
import '../features/delivery/presentation/pages/delivery_acceptance_page.dart';
import '../features/favorites/presentation/pages/favorites_follows_page.dart';
import '../features/home/presentation/pages/home_page.dart';
import '../features/meal_details/presentation/pages/meal_details_page.dart';
import '../features/meal_management/create_meal/presentation/pages/create_meal_page.dart';
import '../features/meal_management/edit_meal/presentation/pages/edit_meal_page.dart';
import '../features/meal_management/view_menu/presentation/pages/view_menu_page.dart';
import '../features/notifications/presentation/pages/notifications_page.dart';
import '../features/offer_details/presentation/pages/offer_details_page.dart';
import '../features/offers_management/create_discount/presentation/pages/create_discount_page.dart';
import '../features/offers_management/create_offer/presentation/pages/create_offer_page.dart';
import '../features/offers_management/edit_discount/presentation/pages/edit_discount_page.dart';
import '../features/offers_management/edit_offer/presentation/pages/edit_offer_page.dart';
import '../features/offers_management/view_offers/presentation/pages/view_offers_page.dart';
import '../features/onboarding/presentation/pages/onboarding_page.dart';
import '../features/order_history/presentation/pages/order_history_page.dart';
import '../features/order_management/order_details/presentation/pages/order_details_page.dart';
import '../features/order_management/view_orders/presentation/pages/orders_list_page.dart';
import '../features/orders/presentation/pages/checkout_review_page.dart';
import '../features/orders/presentation/pages/invoice_page.dart';
import '../features/orders/presentation/pages/my_orders_page.dart';
import '../features/orders/presentation/pages/order_confirmation_page.dart';
import '../features/orders/presentation/pages/receipt_page.dart';
import '../features/profile/edit_profile/presentation/pages/edit_profile_page.dart';
import '../features/profile/presentation/pages/profile_page.dart';
import '../features/ratings/presentation/pages/meal_rating_page.dart';
import '../features/search/domain/entities/search_result_type.dart';
import '../features/search/domain/entities/search_sort_option.dart';
import '../features/search/presentation/pages/search_filters_page.dart';
import '../features/settings/presentation/pages/settings_page.dart';
import '../features/shorts/presentation/pages/shorts_feed_page.dart';
import '../features/shorts_management/create_short/presentation/pages/create_short_page.dart';
import '../features/shorts_management/view_shorts/presentation/pages/my_shorts_page.dart';
import '../features/splash/presentation/pages/splash_page.dart';
import '../l10n/generated/app_localizations.dart';
import 'placeholder_page.dart';
import 'route_observer.dart';

/// Routes reachable with no active session — everything else redirects to
/// `/login` when unauthenticated, or to the appropriate role's shell
/// when authenticated (see `redirect` below). Shared by both roles — role
/// is chosen inside the registration form itself, not by the route.
const _authRoutes = {
  '/login',
  '/register',
  '/otp-verification',
  '/forgot-password',
  '/reset-password',
};

/// Splash makes its own one-shot navigation decision (onboarding vs
/// falling through to the normal session flow) and onboarding decides for
/// itself when it's done — neither should ever be redirected away from by
/// session/role logic, unlike every other route.
const _preSessionRoutes = {'/splash', '/onboarding'};

const _cookRoutePrefix = '/cook';

/// Pure decision function behind `appRouter`'s `redirect` — kept separate
/// from the `GoRouter` wiring (which needs a live `BuildContext`/`GoRouterState`
/// and reads [SessionCubit] from [getIt]) so the three-way branching itself
/// is unit-testable without a widget tree:
/// - `/splash` and `/onboarding` → never redirected away from.
/// - Unauthenticated + not on an auth route → `/login` (registration is one
///   tap away via the "Create new account" link on that screen).
/// - Authenticated as a customer + on an auth route or any `/cook/...`
///   route → `/` (customer home).
/// - Authenticated as a cook + on an auth route or any non-`/cook/...`
///   route → `/cook/menu`.
/// - Otherwise → `null` (stay on the requested route).
String? resolveRedirect(SessionState session, String matchedLocation) {
  if (_preSessionRoutes.contains(matchedLocation)) return null;

  final isGoingToAuthRoute = _authRoutes.contains(matchedLocation);
  final isGoingToCookRoute = matchedLocation.startsWith(_cookRoutePrefix);

  if (!session.isAuthenticated) {
    return isGoingToAuthRoute ? null : '/login';
  }
  if (session.role == UserRole.cook) {
    return (isGoingToAuthRoute || !isGoingToCookRoute) ? '/cook/menu' : null;
  }
  // Customer.
  return (isGoingToAuthRoute || isGoingToCookRoute) ? '/' : null;
}

/// One router for the whole app. `redirect` gates every route on
/// [SessionCubit]'s state via [resolveRedirect] — not just *whether* there's
/// a session, but *which role* it belongs to, since an authenticated cook
/// and an authenticated customer see entirely disjoint route trees.
///
/// `refreshListenable` re-runs that check the moment [SessionCubit] changes
/// — e.g. right after OTP verification calls `logIn()` — so the app lands
/// in the correct shell with no manual navigation call anywhere in the auth
/// flow itself.
final appRouter = GoRouter(
  initialLocation: '/splash',
  observers: [routeObserver],
  refreshListenable: GoRouterRefreshStream(getIt<SessionCubit>().stream),
  redirect: (context, state) =>
      resolveRedirect(getIt<SessionCubit>().state, state.matchedLocation),
  routes: [
    // ── Pre-session (splash decides where to send the user next) ──────
    GoRoute(path: '/splash', builder: (context, state) => const SplashPage()),
    GoRoute(
        path: '/onboarding',
        builder: (context, state) => const OnboardingPage()),

    // ── Customer routes (unprefixed) ──────────────────────────────────
    GoRoute(path: '/', builder: (context, state) => const HomePage()),
    GoRoute(
      path: '/search',
      builder: (context, state) => SearchFiltersPage(
        initialCategoryId: state.uri.queryParameters['categoryId'],
        initialSortOption: SearchSortOption.values
            .asNameMap()[state.uri.queryParameters['sort']],
        initialTypes:
            parseSearchResultTypes(state.uri.queryParameters['types']),
      ),
    ),
    GoRoute(
      path: '/meal/:mealId',
      builder: (context, state) => MealDetailsPage(
        mealId: state.pathParameters['mealId']!,
        returnedMeal: state.extra as ReturnedMealEntity?,
      ),
    ),
    GoRoute(
      path: '/chef/:chefId',
      builder: (context, state) =>
          ChefProfilePage(chefId: state.pathParameters['chefId']!),
    ),
    GoRoute(
      // No `GET offer by id` endpoint exists — the bundle is whatever
      // Home/Search already fetched, passed through `extra` (same pattern
      // as `/meal/:mealId`'s `returnedMeal`). `:offerId` in the path exists
      // for URL/deep-link shape only.
      path: '/offer/:offerId',
      builder: (context, state) =>
          OfferDetailsPage(bundle: state.extra as OfferBundleEntity),
    ),
    GoRoute(
        path: '/cart', builder: (context, state) => const ShoppingCartPage()),
    GoRoute(
      path: '/checkout-review',
      builder: (context, state) {
        final extra = state.extra as ({
          CartCookGroupEntity group,
          double deliveryFee,
          String? deliveryAddress,
          double? latitude,
          double? longitude,
        });
        return CheckoutReviewPage(
          group: extra.group,
          deliveryFee: extra.deliveryFee,
          deliveryAddress: extra.deliveryAddress,
          latitude: extra.latitude,
          longitude: extra.longitude,
        );
      },
    ),
    GoRoute(
      path: '/receipt/:orderId',
      builder: (context, state) =>
          ReceiptPage(orderId: state.pathParameters['orderId']!),
    ),
    GoRoute(
      path: '/order-confirmation/:orderId',
      builder: (context, state) =>
          OrderConfirmationPage(orderId: state.pathParameters['orderId']!),
    ),
    GoRoute(
      path: '/invoice/:orderId',
      builder: (context, state) =>
          InvoicePage(orderId: state.pathParameters['orderId']!),
    ),
    GoRoute(path: '/orders', builder: (context, state) => const MyOrdersPage()),
    GoRoute(
        path: '/order-history',
        builder: (context, state) => const OrderHistoryPage()),
    GoRoute(
      path: '/delivery-acceptance/:orderId',
      builder: (context, state) =>
          DeliveryAcceptancePage(orderId: state.pathParameters['orderId']!),
    ),
    GoRoute(
      path: '/meal-rating/:orderId',
      builder: (context, state) =>
          MealRatingPage(orderId: state.pathParameters['orderId']!),
    ),
    GoRoute(
        path: '/notifications',
        builder: (context, state) => const NotificationsPage()),
    GoRoute(
        path: '/favorites',
        builder: (context, state) => const FavoritesFollowsPage()),
    GoRoute(
        path: '/shorts', builder: (context, state) => const ShortsFeedPage()),
    GoRoute(path: '/profile', builder: (context, state) => const ProfilePage()),
    GoRoute(
        path: '/profile/edit',
        builder: (context, state) => const EditProfilePage()),
    GoRoute(
      path: '/settings',
      builder: (context, state) => SettingsPage(
        initialPhoneNumber: state.extra as String?,
        changePasswordRoute: '/settings/change-password',
        changePhoneRoute: '/settings/change-phone',
      ),
    ),
    GoRoute(
      path: '/settings/change-password',
      builder: (context, state) => const ChangePasswordPage(),
    ),
    GoRoute(
      path: '/settings/change-phone',
      builder: (context, state) => const ChangePhoneNumberPage(),
    ),

    // ── Cook routes (prefixed /cook/... — see class doc for why) ──────
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) =>
          _CookAppScaffold(navigationShell: navigationShell),
      branches: [
        StatefulShellBranch(routes: [
          GoRoute(
              path: '/cook/menu',
              builder: (context, state) => const ViewMenuPage()),
        ]),
        StatefulShellBranch(routes: [
          GoRoute(
              path: '/cook/orders',
              builder: (context, state) => const OrdersListPage()),
        ]),
        StatefulShellBranch(routes: [
          GoRoute(
              path: '/cook/offers',
              builder: (context, state) => const ViewOffersPage()),
        ]),
        StatefulShellBranch(routes: [
          GoRoute(
              path: '/cook/shorts',
              builder: (context, state) => const MyShortsPage()),
        ]),
        StatefulShellBranch(routes: [
          GoRoute(
              path: '/cook/account',
              builder: (context, state) => const cook.ProfilePage()),
        ]),
      ],
    ),
    GoRoute(
      path: '/cook/orders/:id',
      builder: (context, state) =>
          OrderDetailsPage(orderId: state.pathParameters['id']!),
    ),
    GoRoute(
        path: '/cook/meals/create',
        builder: (context, state) => const CreateMealPage()),
    GoRoute(
      path: '/cook/meals/:id/edit',
      builder: (context, state) =>
          EditMealPage(mealId: state.pathParameters['id']!),
    ),
    GoRoute(
        path: '/cook/offers/create',
        builder: (context, state) => const CreateOfferPage()),
    GoRoute(
      path: '/cook/offers/:id/edit',
      builder: (context, state) =>
          EditOfferPage(offerId: state.pathParameters['id']!),
    ),
    GoRoute(
      path: '/cook/discounts/create',
      builder: (context, state) => const CreateDiscountPage(),
    ),
    GoRoute(
      path: '/cook/discounts/:id/edit',
      builder: (context, state) =>
          EditDiscountPage(discountId: state.pathParameters['id']!),
    ),
    GoRoute(
        path: '/cook/shorts/create',
        builder: (context, state) => const CreateShortPage()),
    GoRoute(
        path: '/cook/account/edit',
        builder: (context, state) => const cook.EditProfilePage()),
    GoRoute(
      path: '/cook/account/settings',
      builder: (context, state) =>
          SettingsPage(initialPhoneNumber: state.extra as String?),
    ),
    GoRoute(
      path: '/cook/account/settings/change-password',
      builder: (context, state) => const ChangePasswordPage(),
    ),
    GoRoute(
      path: '/cook/account/settings/change-phone',
      builder: (context, state) => const ChangePhoneNumberPage(),
    ),
    GoRoute(
      path: '/cook/notifications',
      builder: (context, state) => PlaceholderPage(
          title: AppLocalizations.of(context)!.notificationsTitle),
    ),

    // ── Shared auth routes (role chosen inside the registration form) ─
    GoRoute(path: '/login', builder: (context, state) => const LoginPage()),
    GoRoute(
        path: '/register',
        builder: (context, state) => const RegistrationPage()),
    GoRoute(
      path: '/otp-verification',
      // `extra` is a plain phone String when reached from Registration, or
      // a `(phone, purpose)` record when reached from Forgot Password.
      builder: (context, state) {
        final extra = state.extra;
        if (extra is ({String phone, OtpPurpose purpose})) {
          return OtpVerificationPage(
              phone: extra.phone, purpose: extra.purpose);
        }
        return OtpVerificationPage(phone: extra as String? ?? '');
      },
    ),
    GoRoute(
        path: '/forgot-password',
        builder: (context, state) => const ForgotPasswordPage()),
    GoRoute(
      path: '/reset-password',
      builder: (context, state) =>
          ResetPasswordPage(phone: state.extra as String? ?? ''),
    ),
  ],
);

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
          NavigationDestination(
              icon: const Icon(Icons.restaurant_menu), label: l10n.navMenu),
          NavigationDestination(
              icon: const Icon(Icons.receipt_long), label: l10n.navOrders),
          NavigationDestination(
              icon: const Icon(Icons.local_offer), label: l10n.navOffers),
          NavigationDestination(
              icon: const Icon(Icons.play_circle_outline),
              label: l10n.navShorts),
          NavigationDestination(
              icon: const Icon(Icons.person), label: l10n.navAccount),
        ],
      ),
    );
  }
}
