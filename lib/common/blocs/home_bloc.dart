import 'package:hola_mundo/common/models/notification.dart';
import 'package:hola_mundo/common/models/product.dart';
import 'package:hola_mundo/common/services/home_service.dart';
import 'package:flutter/foundation.dart';

class HomeBloc {
  final HomeService _homeService = HomeService();

  Future<List<Product>> getProducts() async {
    final products = await _homeService.getProducts();
    return products;
  }

  Stream<List<Product>> streamProducts() {
    return _homeService.streamProducts();
  }

  Future<List<Notification>> getNotifications() async {
    final notifications = await _homeService.getNotifications();
    return notifications;
  }

  Future<void> deleteNotification(String id) async {
    await _homeService.deleteNotification(id);
  }

  Future<void> addProduct({
    required String name,
    required String description,
    required double price,
    String? imageUrl,
  }) async {
    try {
      await _homeService.addProduct(
        name: name,
        description: description,
        price: price,
        imageUrl: imageUrl,
      );
    } catch (e) {
      debugPrint('Error adding product: $e');
      rethrow;
    }
  }
}
