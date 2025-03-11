import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hola_mundo/authentication/blocs/login_bloc.dart';
import 'package:hola_mundo/authentication/pages/login_screen.dart';
import 'package:hola_mundo/common/pages/notifications_screen.dart';
import 'package:hola_mundo/common/pages/add_product_screen.dart';
import 'package:hola_mundo/root_screen.dart';
import 'package:hola_mundo/injector.dart';

class CustomRouter extends InheritedWidget {
  final _data = CustomerRouterData();

  CustomRouter({super.key, required super.child});

  static CustomerRouterData of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<CustomRouter>()!._data;

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => false;
}

class CustomerRouterData extends ChangeNotifier
    implements RouterConfig<Object> {
  final _router = GoRouter(
    initialLocation: '/home',
    routes: <GoRoute>[
      GoRoute(
        path: '/home',
        builder: (BuildContext context, GoRouterState state) {
          final loginBloc = Injector.get<LoginBloc>();
          return StreamBuilder<User?>(
            stream: loginBloc.onAuthStateChanged,
            builder: (context, snapshot) {
              final user = snapshot.data;
              if (user == null) {
                return const LoginScreen();
              }

              Injector.register<User>(user);
              return const RootScreen();
            },
          );
        },
      ),
      GoRoute(
        path: '/notifications',
        builder: (BuildContext context, GoRouterState state) {
          return const NotificationsScreen();
        },
      ),
      GoRoute(
        path: '/add-product',
        builder: (BuildContext context, GoRouterState state) {
          return const AddProductScreen();
        },
      ),
    ],
  );

  Future<T?> push<T>(String location, {Object? extra}) =>
      _router.push(location, extra: extra);

  void go(String location, {Object? extra}) =>
      _router.go(location, extra: extra);

  void pop<T>([T? result]) => _router.pop(result);

  @override
  RouteInformationParser<Object>? get routeInformationParser =>
      _router.routeInformationParser;

  @override
  RouteInformationProvider? get routeInformationProvider =>
      _router.routeInformationProvider;

  @override
  RouterDelegate<Object> get routerDelegate => _router.routerDelegate;

  @override
  void dispose() {
    _router.dispose();
    super.dispose();
  }

  @override
  BackButtonDispatcher? get backButtonDispatcher =>
      _router.backButtonDispatcher;
}
