import 'package:app/app/core/services/firebase_auth_service.dart';
import 'package:app/app/core/services/firestore_service.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_modular/flutter_modular.dart';

class NotificationService {
  static FirebaseMessaging _messaging = FirebaseMessaging.instance;
  static final _firestoreService = Modular.get<FirestoreService>();
  static final _firestoreAuth = Modular.get<FirebaseAuthService>();
  static Future<void> initNotification() async {
    await _initializeAwesomeNotifications();
    await _updateFcmToken(null);
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
    await AwesomeNotifications().createNotification(
        content: NotificationContent(
            id: DateTime.now().millisecond,
            channelKey: 'alerts',
            locked: true,
            title: 'Aplicativo Ativo em segundo plano.',
            body:
                "Em caso de emergência, clique 3 vezes no botão de volume para pedir ajuda!",
            notificationLayout: NotificationLayout.BigPicture,
            payload: {'notificationId': '${DateTime.now().millisecond}'}),
        actionButtons: [
          NotificationActionButton(
              key: 'Desactive',
              label: 'Desativar segundo plano',
              actionType: ActionType.SilentBackgroundAction,
              autoDismissible: true),
        ]);

    await AwesomeNotifications().setListeners(
      onActionReceivedMethod: onActionReceivedMethod,
      onDismissActionReceivedMethod: onActionReceivedMethod,
    );
  }

  static Future<void> onActionReceivedMethod(
      ReceivedAction receivedAction) async {
    debugPrint('Received $receivedAction');
  }

  static Future<void> _initializeAwesomeNotifications() async {
    await AwesomeNotifications().initialize(
        "mipmap/ic_launcher",
        [
          NotificationChannel(
            channelKey: 'alerts',
            channelName: 'ShhPrecisoAjuda',
            channelDescription: 'Notification shh',
            playSound: true,
            onlyAlertOnce: true,
            groupAlertBehavior: GroupAlertBehavior.Children,
            importance: NotificationImportance.High,
            defaultPrivacy: NotificationPrivacy.Private,
          )
        ],
        debug: true);
  }

  static Future<void> cancelAllNotificationsLocalBackground() async =>
      await AwesomeNotifications().cancelAll();
}
