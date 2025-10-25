import 'package:flutter_app_template/features/auth/domain/domain.dart';

abstract interface class IAuthDataSourceRepo {
  Future<AuthPayload> getAuthPayload();
}
