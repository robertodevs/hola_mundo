import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:hola_mundo/authentication/blocs/login_bloc.dart';
import 'package:hola_mundo/authentication/services/login_service.dart';
import 'package:hola_mundo/common/services/error_service.dart';
import 'package:hola_mundo/common/services/push_notifications_service.dart';
import 'package:hola_mundo/firebase_options.dart';
import 'package:hola_mundo/injector.dart';
import 'package:hola_mundo/custom_router.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print('Background message received: ${message.data}');
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  Injector.register(
    LoginBloc(
      loginService: LoginService(),
    ),
  );

  final errorService = ErrorService();
  Injector.register(
    errorService,
  );

  Injector.register(
    PushNotificationProvider(),
  );

  await runZonedGuarded(
    () async {
      runApp(
        EasyLocalization(
          supportedLocales: const [
            Locale('en', 'US'),
            Locale('es'),
          ],
          path: 'assets/translations',
          fallbackLocale: const Locale('en', 'US'),
          child: CustomRouter(
            child: const MyApp(),
          ),
        ),
      );
    },
    (error, stack) {
      errorService.logError(error.toString(), stack);
    },
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: CustomRouter.of(context),
      title: 'Flutter Demo',
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.purple),
        useMaterial3: true,
      ),
    );
  }
}
