import 'package:equatable/equatable.dart';

abstract class AuthPayload extends Equatable {
  const AuthPayload({required this.data});

  final String data;
}
