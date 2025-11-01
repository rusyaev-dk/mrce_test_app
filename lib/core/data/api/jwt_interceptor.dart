import 'package:dio/dio.dart';
import 'package:flutter_app_template/features/auth/data/data.dart';


class JWTInterceptor extends Interceptor {
  JWTInterceptor({required ISessionCacheRepo sessionCacheRepo})
    : _sessionCacheRepo = sessionCacheRepo;

  final ISessionCacheRepo _sessionCacheRepo;

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final session = await _sessionCacheRepo.loadSession();
    options.headers['Authorization'] = 'Bearer ${session.sessionToken}';
    handler.next(options);
  }
}
