import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import 'pages/registration_page.dart';
import 'services/notification_service.dart';

const _options = FirebaseOptions(
  apiKey: 'AIzaSyAE9IIqetTUfRgqf-Lcr_dwZdisX-CHMes',
  appId: '1:445710341280:android:b6b6b35b435d7ee891e5c5',
  messagingSenderId: '445710341280',
  projectId: 'lab7-firebase-c1f3f',
  databaseURL:
      'https://lab7-firebase-c1f3f-default-rtdb.europe-west1.firebasedatabase.app',
);

/// Обработчик push-уведомлений, пришедших в фоне/при закрытом приложении.
/// Должен быть top-level функцией.
@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(options: _options);
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Значения берутся в Firebase Console: Настройки проекта -> Ваши приложения
  // -> Android-приложение. Скачивать google-services.json не нужно.
  await Firebase.initializeApp(
    options: _options,
  );

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await NotificationService.instance.init();

  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Лаб. 7: Firebase',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(colorSchemeSeed: Colors.deepOrange, useMaterial3: true),
      home: const RegistrationPage(),
    );
  }
}
