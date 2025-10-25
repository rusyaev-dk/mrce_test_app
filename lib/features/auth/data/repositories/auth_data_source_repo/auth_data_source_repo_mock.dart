import 'dart:async';

import 'package:flutter_app_template/features/auth/data/data.dart';
import 'package:flutter_app_template/features/auth/domain/domain.dart';

final class AuthDataSourceRepoMock implements IAuthDataSourceRepo {
  const AuthDataSourceRepoMock();

  @override
  Future<AuthPayload> getAuthPayload() async {
    return const TelegramAuthPayload(
      initData: 'mock_init_data_1234567890',
      userId: 'usr-admin',
      username: 'mock_user',
      data: '{"mock":true}',
    );
  }
}
