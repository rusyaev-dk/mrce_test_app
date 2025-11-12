import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_app_template/app/app.dart';
import 'package:flutter_app_template/core/core.dart';
import 'package:flutter_app_template/features/auth/domain/domain.dart';

part 'auth_state.dart';

final class AuthCubit extends Cubit<AuthState> {
  AuthCubit({required AuthInteractor authInteractor, required ILogger logger})
    : _authInteractor = authInteractor,
      _logger = logger,
      super(const AuthInitialState()) {
    _restoreOrFetch();
  }

  final AuthInteractor _authInteractor;
  final ILogger _logger;

  Future<void> _restoreOrFetch() async {
    try {
      if (state is! AuthLoadingState) {
        emit(const AuthLoadingState());
      }
      _logger.info("Trying to login...");

      // TODO: remove the delay
      await Future.delayed(const Duration(seconds: 7));

      final (Session, User) bundle = await _authInteractor.logIn();

      emit(AuthAuthenticatedState(user: bundle.$2));
    } catch (e, st) {
      emit(
        AuthFailureState(
          failure: e is AppException
              ? e
              : AppUnknownException(message: e.toString(), stackTrace: st),
        ),
      );
      _logger.exception(e, st);
    }
  }

  Future<void> logOut() async {
    try {
      await _authInteractor.logOut();
      emit(const AuthUnauthenticatedState());
    } catch (e, st) {
      emit(const AuthUnauthenticatedState());
      _logger.exception(e, st);
    }
  }
}
