import 'package:flutter/material.dart';
import 'package:ibiapabaapp/core/logger/handlers/controller_log_handler.dart';
import 'package:ibiapabaapp/core/logger/log_tags.dart';
import 'package:ibiapabaapp/features/auth/domain/tags/auth_logtags.dart';
import 'package:ibiapabaapp/features/auth/domain/usecases/login_with_email.dart';
import 'package:ibiapabaapp/features/auth/presentation/providers/auth_state_provider.dart';
import 'package:ibiapabaapp/features/auth/presentation/states/login_state.dart';
import 'package:ibiapabaapp/shared/ui/forms/fields/email/email_checker.dart';
import 'package:logger/logger.dart';

class LoginController extends ChangeNotifier
    with ControllerLogHandler
    implements EmailChecker {
  @override
  final Logger logger;
  final LoginWithEmail loginWithEmail;
  final AuthState authState;

  LoginController({
    required this.loginWithEmail,
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

    final result = await loginWithEmail(
      LoginWithEmailParams(email: email.trim(), password: password),
    );

    final authResult = result.fold(
      (failure) {
        logControllerError(action: AuthAction.login, failure: failure);
        _state = LoginError(failure.message);
        return null;
      },
      (authResult) {
        logControllerSuccess(action: AuthAction.login);
        return authResult;
      },
    );

    if (authResult != null) {
      await authState.initSession(authResult);
      _state = LoginSuccess();
    }

    notifyListeners();
  }
}
