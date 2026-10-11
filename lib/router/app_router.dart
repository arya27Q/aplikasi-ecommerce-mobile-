import 'package:go_router/go_router.dart';

import '../auth/auth_notifier.dart';
import '../models/product.dart';
import '../screens/shell/shell_screen.dart';
import '../screens/home/home_tab.dart';
import '../screens/wishlist/wishlist_tab.dart';
import '../screens/cart/cart_tab.dart';
import '../screens/profile/profile_tab.dart';
import '../screens/auth/login_screen.dart';
import '../screens/product/product_detail_screen.dart';
import '../screens/leaderboard/leaderboard_screen.dart';

class AppRouter {
  final AuthNotifier authNotifier;

  AppRouter(this.authNotifier);

  late final GoRouter router = GoRouter(
    initialLocation: '/home',
    refreshListenable: authNotifier,
    redirect: (context, state) {
      final isAuth = authNotifier.isAuthenticated;
      final isGoingToLogin = state.matchedLocation == '/login';
      final isGoingToProfile = state.matchedLocation.startsWith('/profile');

      if (!isAuth && isGoingToProfile) {
        return '/login';
      }

      if (isAuth && isGoingToLogin) {
        return '/home';
      }

      return null;
    },
    routes: [
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginScreen(),
      ),
      ShellRoute(
        builder: (context, state, child) {
          return ShellScreen(child: child);
        },
        routes: [
          GoRoute(
            path: '/home',
            builder: (context, state) => const HomeTab(),
            routes: [
              GoRoute(
                path: 'detail',
                builder: (context, state) {
                  final product = state.extra as Product;
                  return ProductDetailScreen(product: product);
                },
              ),
            ],
          ),
          GoRoute(
            path: '/wishlist',
            builder: (context, state) => const WishlistTab(),
          ),
          GoRoute(
            path: '/leaderboard',
            builder: (context, state) => const LeaderboardScreen(),
          ),
          GoRoute(
            path: '/cart',
            builder: (context, state) => const CartTab(),
          ),
          GoRoute(
            path: '/profile',
            builder: (context, state) => const ProfileTab(),
          ),
        ],
      ),
    ],
  );
}
