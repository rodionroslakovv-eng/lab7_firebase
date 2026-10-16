import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/services.dart';

/// FCM (firebase_messaging) + показ уведомления на устройстве через
/// нативный канал (MainActivity.kt), без сторонних плагинов.
class NotificationService {
  NotificationService._();
  static final instance = NotificationService._();

  static const _native = MethodChannel('lab7/notify');
  final _fcm = FirebaseMessaging.instance;

  String? token;

  Future<void> init() async {
    // Разрешение на уведомления (Android 13+).
    await _fcm.requestPermission();
    await _native.invokeMethod('requestPermission');

    // FCM-токен устройства: по нему Firebase Console шлёт тестовый push.
    token = await _fcm.getToken();
    // ignore: avoid_print
    print('FCM TOKEN: $token');
    _fcm.onTokenRefresh.listen((t) => token = t);

    // Push, пришедший, пока приложение открыто: рисуем уведомление сами.
    FirebaseMessaging.onMessage.listen((message) {
      final n = message.notification;
      if (n != null) show(n.title ?? 'Уведомление', n.body ?? '');
    });
  }

  /// Показывает уведомление на устройстве.
  Future<void> show(String title, String body) {
    return _native.invokeMethod('show', {'title': title, 'body': body});
  }
}
