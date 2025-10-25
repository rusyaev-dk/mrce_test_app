part of 'auth_cubit.dart';

sealed class AuthState extends Equatable {
  const AuthState({this.message});

  final AppMessage? message;
}

final class AuthInitialState extends AuthState {
  const AuthInitialState({required super.message});

  @override
  List<Object?> get props => <Object?>[];
}

final class AuthLoadingState extends AuthState {
  const AuthLoadingState({required super.message});

  @override
  List<Object?> get props => <Object?>[];
}

final class AuthAuthenticatedState extends AuthState {
  const AuthAuthenticatedState({required this.user, super.message});

  final User user;

  AuthAuthenticatedState copyWith({User? user, AppMessage? message}) {
    return AuthAuthenticatedState(user: user ?? this.user, message: message);
  }

  @override
  List<Object?> get props => <Object?>[user];
}

final class AuthUnauthenticatedState extends AuthState {
  const AuthUnauthenticatedState({required super.message});

  @override
  List<Object?> get props => <Object?>[message];
}

final class AuthFailureState extends AuthState {
  const AuthFailureState({required this.failure, super.message});

  final Object failure;

  @override
  List<Object?> get props => <Object?>[failure, message];
}
