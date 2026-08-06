import 'package:core/core.dart';
import 'package:go_router/go_router.dart';

import '../di/injection.dart';
import 'go_router_refresh_stream.dart';
import '../features/auth/domain/repositories/auth_repository.dart' show OtpPurpose;
import '../features/auth/presentation/pages/forgot_password_page.dart';
import '../features/auth/presentation/pages/login_page.dart';
import '../features/auth/presentation/pages/otp_verification_page.dart';
import '../features/auth/presentation/pages/registration_page.dart';
import '../features/auth/presentation/pages/reset_password_page.dart';
import '../features/cart/presentation/pages/shopping_cart_page.dart';
import '../features/catering/presentation/pages/catering_review_page.dart';
import '../features/chef_profile/presentation/pages/chef_profile_page.dart';
import '../features/delivery/presentation/pages/delivery_acceptance_page.dart';
import '../features/favorites/presentation/pages/favorites_follows_page.dart';
import '../features/home/presentation/pages/home_page.dart';
import '../features/meal_details/presentation/pages/meal_details_page.dart';
import '../features/notifications/presentation/pages/notifications_page.dart';
import '../features/order_history/presentation/pages/order_history_page.dart';
import '../features/orders/presentation/pages/invoice_page.dart';
import '../features/orders/presentation/pages/my_orders_page.dart';
import '../features/orders/presentation/pages/order_confirmation_page.dart';
import '../features/profile/presentation/pages/profile_page.dart';
import '../features/ratings/presentation/pages/meal_rating_page.dart';
import '../features/search/presentation/pages/search_filters_page.dart';
import '../features/shorts/presentation/pages/shorts_feed_page.dart';

/// Routes that don't require an active session — everything else redirects
/// to `/register` when [SessionCubit] is unauthenticated.
const _authRoutes = {
  '/login',
  '/register',
  '/otp-verification',
  '/forgot-password',
  '/reset-password',
};

/// One router for customer_app. `redirect` gates every route on
/// [SessionCubit]'s state: a first-time (unauthenticated) user is sent
/// straight to Registration regardless of what path they hit, and an
/// authenticated user is kept out of the auth screens entirely.
/// `refreshListenable` re-runs that redirect the moment `SessionCubit`
/// changes — e.g. right after OTP verification calls `logIn()`, so the app
/// drops the user straight into Home with no extra manual navigation.
final appRouter = GoRouter(
  initialLocation: '/',
  refreshListenable: GoRouterRefreshStream(getIt<SessionCubit>().stream),
  redirect: (context, state) {
    final isAuthenticated = getIt<SessionCubit>().state;
    final isGoingToAuthRoute = _authRoutes.contains(state.matchedLocation);

    if (!isAuthenticated && !isGoingToAuthRoute) return '/register';
    if (isAuthenticated && isGoingToAuthRoute) return '/';
    return null;
  },
  routes: [
    GoRoute(path: '/', builder: (context, state) => const HomePage()),
    GoRoute(path: '/search', builder: (context, state) => const SearchFiltersPage()),
    GoRoute(
      path: '/meal/:mealId',
      builder: (context, state) =>
          MealDetailsPage(mealId: state.pathParameters['mealId']!),
    ),
    GoRoute(
      path: '/chef/:chefId',
      builder: (context, state) =>
          ChefProfilePage(chefId: state.pathParameters['chefId']!),
    ),
    GoRoute(path: '/cart', builder: (context, state) => const ShoppingCartPage()),
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
    GoRoute(path: '/order-history', builder: (context, state) => const OrderHistoryPage()),
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
    GoRoute(path: '/notifications', builder: (context, state) => const NotificationsPage()),
    GoRoute(path: '/favorites', builder: (context, state) => const FavoritesFollowsPage()),
    GoRoute(path: '/catering-review', builder: (context, state) => const CateringReviewPage()),
    GoRoute(path: '/shorts', builder: (context, state) => const ShortsFeedPage()),
    GoRoute(path: '/profile', builder: (context, state) => const ProfilePage()),
    GoRoute(path: '/login', builder: (context, state) => const LoginPage()),
    GoRoute(path: '/register', builder: (context, state) => const RegistrationPage()),
    GoRoute(
      path: '/otp-verification',
      // `extra` is a plain phone String when reached from Registration, or
      // a `(phone, purpose)` record when reached from Forgot Password.
      builder: (context, state) {
        final extra = state.extra;
        if (extra is ({String phone, OtpPurpose purpose})) {
          return OtpVerificationPage(phone: extra.phone, purpose: extra.purpose);
        }
        return OtpVerificationPage(phone: extra as String? ?? '');
      },
    ),
    GoRoute(path: '/forgot-password', builder: (context, state) => const ForgotPasswordPage()),
    GoRoute(
      path: '/reset-password',
      builder: (context, state) => ResetPasswordPage(phone: state.extra as String? ?? ''),
    ),
  ],
);
