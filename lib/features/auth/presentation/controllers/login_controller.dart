import 'package:flutter/material.dart';
import 'package:ibiapabaapp/core/errors/failures/failures.dart';
import 'package:ibiapabaapp/core/logger/handlers/controller_log_handler.dart';
import 'package:ibiapabaapp/core/logger/log_tags.dart';
import 'package:ibiapabaapp/features/auth/domain/repositories/auth_repository.dart';
import 'package:ibiapabaapp/features/auth/domain/tags/auth_logtags.dart';
import 'package:ibiapabaapp/features/auth/presentation/providers/auth_state_provider.dart';
import 'package:ibiapabaapp/features/auth/presentation/states/login_state.dart';
import 'package:ibiapabaapp/shared/ui/forms/fields/email/email_checker.dart';
import 'package:logger/logger.dart';

class LoginController extends ChangeNotifier
    with ControllerLogHandler
    implements EmailChecker {
  @override
  final Logger logger;
  final AuthRepository repository;
  final AuthState authState;

  LoginController({
    required this.repository,
    required this.authState,
    required this.logger,
  });

  @override
  LogFeature get feature => LogFeature.auth;

  LoginState _state = LoginInitial();
  LoginState get state => _state;

  String _email = '';
  String get email => _email;

  // ─── Email ─────────────────────────────────────────────────────────────────
  @override
  Future<bool> checkEmailAvailability(String email) async {
    return false;
  }

  @override
  void setEmail(String email) {
    _email = email;
  }

  @override
  bool? isEmailAvailable() => null;

  @override
  bool isEmailChecking() => false;


  // ─── Submit ────────────────────────────────────────────────────────────────
  Future<void> login({required String email, required String password}) async {
    _state = LoginLoading();
    notifyListeners();

    try {
      final authResult = await repository.login(
        email: email.trim(),
        password: password,
      );
      logControllerSuccess(action: AuthAction.login);
      await authState.initSession(authResult);
      _state = LoginSuccess();
    } catch (e) {
      final message = e is AppFailure ? e.message : 'Erro inesperado';
      logControllerError(
        action: AuthAction.login,
        failure: e is AppFailure ? e : InternalFailure(message),
      );
      _state = LoginError(message);
    }

    notifyListeners();
  }
}
