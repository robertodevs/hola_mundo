import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hola_mundo/common/models/notification.dart';
import 'package:hola_mundo/common/models/product.dart';

class HomeService {
  final firestore = FirebaseFirestore.instance;

  Future<List<Product>> getProducts() async {
    final products = await firestore.collection('products').get();
    return products.docs
        .map(
          (doc) => Product.fromJson(
            doc.data()..addAll({'id': doc.id}),
          ),
        )
        .toList();
  }

  Stream<List<Product>> streamProducts() {
    final products = firestore.collection('products').snapshots().map(
          (snapshot) => snapshot.docs
              .map(
                (doc) => Product.fromJson(
                  doc.data()..addAll({'id': doc.id}),
                ),
              )
              .toList(),
        );
    return products;
  }

  Future<List<Notification>> getNotifications() async {
    final notifications = await firestore.collection('notifications').get();
    return notifications.docs
        .map(
          (doc) => Notification.fromJson(
            doc.data()..addAll({'id': doc.id}),
          ),
        )
        .toList();
  }

  Future<void> deleteNotification(String id) async {
    await firestore.collection('notifications').doc(id).delete();
  }

  Future<void> addProduct({
    required String name,
    required String description,
    required double price,
    String? imageUrl,
  }) async {
    await firestore.collection('products').add({
      'name': name,
      'description': description,
      'price': price,
      'imageUrl': imageUrl,
    });
  }
}
