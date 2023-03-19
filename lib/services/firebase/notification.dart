import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';

class PushNotification {
  static final PushNotification _instance = PushNotification._internal();
  FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  factory PushNotification() {
    return _instance;
  }

  PushNotification._internal() {
    _firebaseMessaging.onTokenRefresh.listen((fcmToken) {
      //If necessary send token to application server.
      // Note: This callback is fired at each app startup and whenever a new
      // token is generated.
    }).onError((err) {
      // Error getting token.
    });
    requestPermissions();
    foregroundRemoteMessage();
    getToken();
  }

  requestPermissions() async {
    NotificationSettings permissions =
        await _firebaseMessaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    await _firebaseMessaging.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
    log(permissions.authorizationStatus.toString());
  }

  foregroundRemoteMessage() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Got a message whilst in the foreground!');
      print('Message data: ${message.data}');
      if (message.notification != null) {
        print('Message also contained a notification: ${message.notification}');
      }
    });
  }

  Future<String>? getToken() async {
    final fcmToken = await _firebaseMessaging.getToken();
    return fcmToken ?? '';
  }

  void subscribeToTopic(String topic) {
    _firebaseMessaging.subscribeToTopic(topic);
  }

  void unsubscribeFromTopic(String topic) {
    _firebaseMessaging.unsubscribeFromTopic(topic);
  }
}

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print("Handling a background message: ${message.messageId}");
}
