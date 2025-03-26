import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';

class ErrorService {
  final FirebaseCrashlytics _crashlytics = FirebaseCrashlytics.instance;

  void logError(String message, StackTrace stackTrace) {
    _crashlytics.log(message);
    _crashlytics.recordError(message, stackTrace);
  }

  void logFatalError(String message, StackTrace stackTrace) {
    _crashlytics.log(message);
    _crashlytics.recordError(message, stackTrace, fatal: true);
  }

  void logNonFatalError(String message, StackTrace stackTrace) {
    _crashlytics.log(message);
    _crashlytics.recordError(message, stackTrace);
  }

  void logFlutterError(FlutterErrorDetails errorDetails) {
    _crashlytics.log(errorDetails.summary.toString());
    _crashlytics.recordFlutterError(errorDetails);
  }
}
