import 'package:cloud_firestore/cloud_firestore.dart';

class Notification {
  final String id;
  final String message;
  final Timestamp createdAt;

  Notification({
    required this.id,
    required this.message,
    required this.createdAt,
  });

  factory Notification.fromJson(Map<String, dynamic> json) {
    return Notification(
      id: json['id'],
      message: json['message'],
      createdAt: json['createdAt'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'message': message,
      'createdAt': createdAt,
    };
  }
}
