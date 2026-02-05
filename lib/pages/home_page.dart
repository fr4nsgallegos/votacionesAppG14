import 'package:flutter/material.dart';
import 'package:votacionesappg14/utils/notification_service.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          NotificationService.initMessaging();
        },
      ),
    );
  }
}
