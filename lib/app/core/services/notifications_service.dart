import 'package:app/app/core/services/firebase_auth_service.dart';
import 'package:app/app/core/services/firestore_service.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_modular/flutter_modular.dart';

class NotificationService {
  static FirebaseMessaging _messaging = FirebaseMessaging.instance;
  static final _firestoreService = Modular.get<FirestoreService>();
  static final _firestoreAuth = Modular.get<FirebaseAuthService>();

  static Future<void> initNotification() async {
    _updateFcmToken(null);
    _messaging.onTokenRefresh.listen(_updateFcmToken);
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {});
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {});
  }

  static Future<void> _updateFcmToken(String? token) async {
    final tokenUser = await _firestoreAuth.getToken();
    final fcmToken = await _messaging.getToken();

    Map<String, dynamic> result =
        await _firestoreService.getDocument('users', tokenUser);
    result.addAll({'fcm': token != null ? token : fcmToken});

    await _firestoreService.updateDocument('users', tokenUser, result);
  }

  static Future<void> notificationLocalBackground() async {
    await FlutterLocalNotificationsPlugin().show(
        DateTime.now().millisecond,
        'Aplicativo Ativo em segundo plano.',
        'Em caso de emergência, clique 3 vezes no botão de volume para se proteger!',
        NotificationDetails(
          android: AndroidNotificationDetails(
            'ShhPrecisoAjuda',
            'shh',
            indeterminate: true,
            ongoing: true,
            autoCancel: false,
            icon: "mipmap/ic_launcher",
            priority: Priority.max,
            category: AndroidNotificationCategory.locationSharing,
            fullScreenIntent: true,
            playSound: true,
            visibility: NotificationVisibility.private,
            importance: Importance.max,
            enableVibration: true,
          ),
        ));
  }

  static Future<void> cancelAllNotificationsLocalBackground() async {
    await FlutterLocalNotificationsPlugin().cancelAll();
  }
}
