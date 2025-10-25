import 'package:equatable/equatable.dart';

final class Session extends Equatable {
  const Session({
    required this.sessionToken,
    required this.refreshToken,
    required this.userId,
  });

  final String sessionToken;
  final String refreshToken;
  final String userId;

  Map<String, dynamic> toJson() => <String, dynamic>{
    'session_token': sessionToken,
    'refresh_token': refreshToken,
    'user_id': userId,
  };

  factory Session.fromJson(Map<String, dynamic> json) {
    final String? sessionToken = json['session_token'];
    final String? refreshToken = json['refresh_token'];

    if (sessionToken == null || sessionToken.toString().isEmpty) {
      throw ArgumentError('Missing or empty session token in JSON');
    }

    if (refreshToken == null || refreshToken.toString().isEmpty) {
      throw ArgumentError('Missing or refresh session token in JSON');
    }

    final String? userId = json['user_id'];

    if (userId == null || userId.toString().isEmpty) {
      throw ArgumentError('Missing or empty session token in JSON');
    }

    return Session(
      sessionToken: sessionToken.toString(),
      refreshToken: refreshToken.toString(),
      userId: userId.toString(),
    );
  }

  @override
  List<Object?> get props => [sessionToken, refreshToken, userId];
}
