import 'package:firebase_database/firebase_database.dart';

/// Сохранение пользователей в Firebase Realtime Database: узел /users.
class UserRepository {
  final _users = FirebaseDatabase.instance.ref('users');

  /// Возвращает id созданной записи.
  Future<String> register({
    required String name,
    required String email,
    required String phone,
    String? fcmToken,
  }) async {
    final ref = _users.push(); // уникальный ключ
    await ref.set({
      'name': name,
      'email': email,
      'phone': phone,
      'fcmToken': fcmToken,
      'createdAt': ServerValue.timestamp,
    });
    return ref.key!;
  }
}
