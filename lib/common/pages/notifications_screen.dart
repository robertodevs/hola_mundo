import 'package:flutter/material.dart';
import 'package:hola_mundo/common/blocs/home_bloc.dart';
import 'package:hola_mundo/common/models/notification.dart' as notification;
import 'package:hola_mundo/injector.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  final notificationsBloc = Injector.get<HomeBloc>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
      ),
      body: FutureBuilder<List<notification.Notification>>(
        future: notificationsBloc.getNotifications(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return const Center(child: Text('Error fetching notifications'));
          }

          if (snapshot.data == null) {
            return const Center(child: Text('No notifications'));
          }

          if (snapshot.data!.isEmpty) {
            return const Center(child: Text('No notifications'));
          }

          final notifications = snapshot.data!;

          return ListView.builder(
            itemCount: notifications.length,
            itemBuilder: (context, index) {
              return Dismissible(
                key: Key(notifications[index].id),
                onDismissed: (direction) {
                  // Handle deletion logic here
                  notificationsBloc.deleteNotification(notifications[index].id);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Notification dismissed')),
                  );
                },
                background: Container(color: Colors.red),
                child: ListTile(
                  leading: Icon(Icons.notifications),
                  title: Text(notifications[index].message),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
