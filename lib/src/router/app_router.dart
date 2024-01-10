import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hareeg/src/features/home/views/home.dart';

class RouteName {
  static const homeView = "/";
  static const loginView = "/login-view";
  static const registerView = "/register-view";
  static const orderDetailsView = "/order-details-view";
  static const deliveryOrderRequestView = "/delivery-order-request-view";
  static const addNewProductView = "/add-new-product-view";
}

class AppRouter {
  late final router = GoRouter(
    initialLocation: RouteName.homeView, // "/"
    routes: <RouteBase>[
      GoRoute(
        path: RouteName.homeView,
        name: RouteName.homeView,
        builder: (context, state) => const HomeView(),
      ),

      // pageBuilder: (context, state) => CustomTransitionPage<void>(
      //   key: state.pageKey,
      //   restorationId: state.pageKey.value,
      //   child: const InspectionReportView(),
      //   transitionsBuilder: (
      //     context,
      //     animation,
      //     secondaryAnimation,
      //     child,
      //   ) =>
      //       FadeTransition(
      //     opacity: animation,
      //     child: child,
      //   ),
      // ),
      // ),
    ],
  );
// redirect: ((BuildContext context, GoRouterState state) {
//   bool isTryLoginOrRegister = authCubit.state == const AuthState.isTryLoginOrRegister();
//   bool isAuthenticated = authCubit.state == const AuthState.authenticated();
//
//   print("isAuthenticated $isAuthenticated");
//   print('isTryLogin $isTryLoginOrRegister');
//
//   final bool isLoginView = state.path == RouteName.loginView;
//
//   if (isAuthenticated) {
//     return null;
//   }
//
//   if (!isAuthenticated && isTryLoginOrRegister) {
//     return null;
//   }
//
//   if (!isAuthenticated) {
//     return isLoginView ? null : RouteName.loginView;
//   }
//
//   return null;
// }),
// refreshListenable: GoRouterRefreshStream(authCubit.stream));
}

class GoRouterRefreshStream extends ChangeNotifier {
  /// Creates a [GoRouterRefreshStream].
  ///
  /// Every time the [stream] receives an event the [GoRouter] will refresh its
  /// current route.
  ///
  GoRouterRefreshStream(Stream<dynamic> stream) {
    notifyListeners();
    _subscription = stream.asBroadcastStream().listen((dynamic _) => notifyListeners());
  }

  late final StreamSubscription<dynamic> _subscription;

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
