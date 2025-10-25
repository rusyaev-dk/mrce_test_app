import 'package:flutter_app_template/core/domain/domain.dart';
import 'package:flutter_app_template/features/auth/domain/domain.dart';

final class AuthInteractor {
  AuthInteractor();

  Future<bool> hasValidSession() async {
    throw UnimplementedError();
  }

  Future<Session> getCachedSession() async {
    throw UnimplementedError();
  }

  Future<User> getCachedUser() async {
    throw UnimplementedError();
  }

  Future<(Session, User)> login() async {
    throw UnimplementedError();
  }

  Future<void> signOut() async {
    throw UnimplementedError();
  }
}
