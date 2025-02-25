import 'package:get_it/get_it.dart';

// ignore: avoid_classes_with_only_static_members
class Injector {
  static void register<T extends Object>(T service) {
    // Unregister if already registered to avoid double registration
    if (GetIt.instance.isRegistered<T>()) {
      GetIt.instance.unregister<T>();
    }
    GetIt.instance.registerSingleton<T>(service);
  }

  static T get<T extends Object>() => GetIt.instance.get<T>();
}
