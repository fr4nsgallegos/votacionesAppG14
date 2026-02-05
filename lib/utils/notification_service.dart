import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

@pragma('vm:entry-point') //permite que el código sea accesible de manera nativa
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  NotificationService.handleBackground(message);
}

@pragma('vm:entry-point') //permite que el código sea accesible de manera nativa
class NotificationService {
  static FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
  static initMessaging() async {
    String token = await firebaseMessaging.getToken() ?? "-";
    print("TOKEN: $token");
    firebaseMessaging.onTokenRefresh.listen((newtroken) {
      // actualizar new rtoken
    });

    FirebaseMessaging.onMessage.listen(_onMessage);
  }

  // Obtener info cuando el app esta abierto
  static _onMessage(RemoteMessage message) {
    print("**************************************");
    print(message.notification);
    print(message.notification!.title);
    print(message.notification!.body);
    print("**************************************");
  }

  // Obtener info cuando el app esta en segundo plano
  @pragma(
    'vm:entry-point',
  ) //permite que esta seccion de código sea accesible de manera nativa
  static Future<void> handleBackground(RemoteMessage message) async {
    if (message.notification != null) {
      print("-----------------------------------");
      print(message.notification);
      print(message.notification!.title);
      print(message.notification!.body);
      print("-----------------------------------");
    }
  }
}
