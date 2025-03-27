import 'package:hola_mundo/common/models/notification.dart';
import 'package:hola_mundo/common/models/product.dart';
import 'package:hola_mundo/common/services/error_service.dart';
import 'package:hola_mundo/common/services/home_service.dart';
import 'package:hola_mundo/injector.dart';

class HomeBloc {
  final HomeService _homeService = HomeService();
  final ErrorService _errorService = Injector.get<ErrorService>();
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
      // mock error
      throw Exception('Error adding product');
    } catch (e) {
      _errorService.logNonFatalError(e.toString(), StackTrace.current);
      rethrow;
    }
  }
}
