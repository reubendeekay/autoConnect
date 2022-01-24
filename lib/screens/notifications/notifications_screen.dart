import 'package:flutter/material.dart';
import 'package:mechanic/helpers/constants.dart';
import 'package:mechanic/screens/notifications/notifications_tile.dart';

class NotificationsScreen extends StatelessWidget {
  static const routeName = '/notifications';
  const NotificationsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
        backgroundColor: kPrimaryColor,
        elevation: 0,
      ),
      body: ListView(
        children:const [
          NotificationsTile(),
          NotificationsTile(),
          NotificationsTile(),
          NotificationsTile(),
          NotificationsTile(),
          NotificationsTile(),
          NotificationsTile(),
          NotificationsTile(),
        ],
      ),
    );
  }
}

