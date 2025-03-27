import 'dart:async';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hola_mundo/common/services/error_service.dart';
import 'package:hola_mundo/injector.dart';

class PushNotificationProvider {
  final FirebaseMessaging _messaging = FirebaseMessaging.instance;
  final _messageStreamController = StreamController<RemoteMessage>.broadcast();
  final FlutterLocalNotificationsPlugin _localNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  final _errorLog = Injector.get<ErrorService>();

  Stream<RemoteMessage> get messageStream => _messageStreamController.stream;

  PushNotificationProvider() {
    _init();
  }

  Future<void> _init() async {
    try {
      await _initializeLocalNotifications();
      await _requestPermissions();
      await _setupMessageHandlers();
    } catch (e, stackTrace) {
      _errorLog.logError(e.toString(), stackTrace);
    }
  }

  Future<void> _requestPermissions() async {
    final settings = await _messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
      provisional: false,
    );

    debugPrint('User granted permission: ${settings.authorizationStatus}');
  }

  Future<void> _setupMessageHandlers() async {
    // Handle messages when app is in foreground
    FirebaseMessaging.onMessage.listen(_handleForegroundMessage);

    // Handle when user taps on notification when app is in background
    FirebaseMessaging.onMessageOpenedApp.listen(_handleBackgroundMessage);

    // Check if app was opened from a notification
    final initialMessage = await _messaging.getInitialMessage();
    if (initialMessage != null) {
      _handleInitialMessage(initialMessage);
    }
  }

  Future<String?> getUserToken() async {
    try {
      String? apnToken;
      if (Platform.isIOS) {
        apnToken = await _messaging.getAPNSToken();
      }

      if (apnToken != null) {
        return apnToken;
      }
      return null;
    } catch (e, stackTrace) {
      _errorLog.logError(e.toString(), stackTrace);
      return null;
    }
  }

  Future<void> _initializeLocalNotifications() async {
    const initSettings = InitializationSettings(
      android: AndroidInitializationSettings("@mipmap/ic_launcher"),
      iOS: DarwinInitializationSettings(
        requestAlertPermission: true,
        requestBadgePermission: true,
        requestSoundPermission: true,
      ),
    );

    await _localNotificationsPlugin.initialize(
      initSettings,
      onDidReceiveNotificationResponse: (details) {
        _handleLocalNotificationTap(details.payload);
      },
    );

    await _messaging.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  Future<void> _handleForegroundMessage(RemoteMessage message) async {
    _messageStreamController.add(message);

    if (message.notification != null) {
      await _showLocalNotification(message);
    }
  }

  Future<void> _handleBackgroundMessage(RemoteMessage message) async {
    _messageStreamController.add(message);
    // Add your background message handling logic here
  }

  Future<void> _handleInitialMessage(RemoteMessage message) async {
    _messageStreamController.add(message);
    // Add your initial message handling logic here
  }

  Future<void> _showLocalNotification(RemoteMessage message) async {
    final notification = message.notification;
    if (notification == null) return;

    const notificationDetails = NotificationDetails(
      android: AndroidNotificationDetails(
        "high_importance_channel",
        "High Importance Notifications",
        priority: Priority.max,
        importance: Importance.max,
      ),
      iOS: DarwinNotificationDetails(
        presentAlert: true,
        presentBadge: true,
        presentSound: true,
      ),
    );

    await _localNotificationsPlugin.show(
      message.hashCode,
      notification.title,
      notification.body,
      notificationDetails,
      payload: message.data.toString(),
    );
  }

  void _handleLocalNotificationTap(String? payload) {
    // Add your notification tap handling logic here
  }

  void dispose() {
    _messageStreamController.close();
  }
}
