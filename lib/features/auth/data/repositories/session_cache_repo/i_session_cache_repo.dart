import 'package:flutter_app_template/features/auth/domain/domain.dart';

abstract interface class ISessionCacheRepo {
  Future<bool> saveSession({required Session session});
  Future<Session> loadSession();
  Future<bool> clearSession();
}
