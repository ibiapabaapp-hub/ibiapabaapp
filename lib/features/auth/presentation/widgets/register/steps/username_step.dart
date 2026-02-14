import 'dart:async';
import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:ibiapabaapp/app/theme/theme.dart';
import 'package:ibiapabaapp/features/auth/presentation/controllers/register_controller.dart';

class UsernameStep extends StatefulWidget {
  final RegisterController controller;
  final VoidCallback onNext;

  const UsernameStep({
    super.key,
    required this.controller,
    required this.onNext,
  });

  @override
  State<UsernameStep> createState() => _UsernameStepState();
}

class _UsernameStepState extends State<UsernameStep> {
  final _formKey = GlobalKey<FormState>();

  String _userName = '';
  Timer? _debounce;
  String? _errorText;
  String? _successText;

  final RegExp _usernameRegex = RegExp(
    r'^(?=.{4,30}$)(?![._])(?!.*[._]{2})[a-zA-Z0-9._]+(?<![._])$',
  );

  bool _isChecking = false;
  bool? _isAvailable;

  bool get _canContinue =>
      _isAvailable == true &&
      !_isChecking &&
      _errorText == null &&
      _userName.isNotEmpty;

  late final FTextFieldControl _userNameControl;

  @override
  void initState() {
    super.initState();
    _userName = widget.controller.formData.name;

    _userNameControl = FTextFieldControl.managed(
      onChange: (v) {
        _userName = v.text.trim();
        _onUsernameChanged(_userName);
      },
    );
  }

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  void _onUsernameChanged(String value) {
    _debounce?.cancel();

    setState(() {
      _errorText = null;
      _successText = null;
      _isAvailable = null;
    });

    final trimmed = value.trim();
    if (!_usernameRegex.hasMatch(trimmed)) {
      setState(() {
        _isAvailable = null;
      });
      return;
    }

    _debounce = Timer(const Duration(milliseconds: 500), () {
      _checkUsernameAvailability(trimmed);
    });
  }

  Future<void> _checkUsernameAvailability(String username) async {
    setState(() {
      _isChecking = true;
      _isAvailable = null;
      _errorText = null;
      _successText = null;
    });

    final available = await widget.controller.checkUsername(username);

    if (!mounted) return;

    setState(() {
      _isAvailable = available;
      _isChecking = false;

      final fieldError = widget.controller.getError('username');
      if (fieldError != null) {
        _errorText = fieldError;
      } else if (available == false) {
        _errorText = 'Nome de usuário já está em uso, por favor, use outro';
      } else if (available == true) {
        _successText = 'Nome de usuário disponível!';
      }
    });

    _formKey.currentState?.validate();
  }

  void _submit() {
    FocusScope.of(context).unfocus();
    if (!_formKey.currentState!.validate()) return;
    if (_isAvailable != true) return;

    widget.controller.setUsername(_userName);
    widget.onNext();
  }

  Widget _buildSuffix(BuildContext context) {
    if (_isChecking) {
      return const Padding(
        padding: EdgeInsets.all(12),
        child: SizedBox(
          width: 16,
          height: 16,
          child: CircularProgressIndicator(strokeWidth: 2),
        ),
      );
    }

    if (_isAvailable == true) {
      return Padding(
        padding: EdgeInsets.all(12),
        child: Icon(Icons.check, size: 24, color: context.theme.colors.primary),
      );
    }

    if (_isAvailable == false) {
      return Padding(
        padding: EdgeInsets.all(12),
        child: Icon(Icons.close, size: 24, color: context.theme.colors.error),
      );
    }

    return SizedBox.shrink();
  }

  String? _validate(String? v) {
    if (v == null || v.trim().isEmpty) {
      return 'Escolha um nome de usuário.';
    }

    final username = v.trim();

    if (username.length < 4) {
      return 'O nome deve ter pelo menos 4 caracteres.';
    }

    if (username.length > 30) {
      return 'O nome pode ter no máximo 30 caracteres.';
    }

    if (username.startsWith('.') || username.startsWith('_')) {
      return 'Não comece com "." ou "_".';
    }

    if (username.endsWith('.') || username.endsWith('_')) {
      return 'Não termine com "." ou "_".';
    }

    if (RegExp(r'[._]{2}').hasMatch(username)) {
      return 'Não use pontos ou underlines consecutivos.';
    }

    if (!RegExp(r'^[a-z0-9._]+$').hasMatch(username)) {
      return 'Use apenas letras minúsculas, números, ponto (.) ou underline (_).';
    }

    if (_errorText != null) {
      return _errorText;
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 16,
          children: [
            Text(
              'Como você quer ser encontrado no app?',
              style: context.theme.typography.xl2.copyWith(fontWeight: .w600),
            ),
            Text(
              'Use o nome de usuário que já usa em outras redes - ou crie um que te represente bem.',
              style: context.theme.typography.base.copyWith(
                fontWeight: .normal,
              ),
            ),

            FTextFormField(
              prefixBuilder: (context, style, states) => Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 4, 0),
                child: Text(
                  '@',
                  style: TextStyle(
                    fontSize: 16,
                    color: context.theme.colors.secondaryForeground,
                  ),
                ),
              ),
              suffixBuilder: (context, style, states) => _buildSuffix(context),
              control: _userNameControl,
              style: (style) =>
                  style.withBaseFontSize(typography: context.theme.typography),
              hint: 'Seu nome de usuário',
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (v) => _validate(v),
              onSubmit: (_) => _submit(),
            ),

            if (_successText != null)
              Text(
                _successText!,
                style: context.theme.typography.sm.copyWith(
                  color: context.theme.colors.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),

            const Spacer(),

            SizedBox(
              width: double.infinity,
              child: FButton(
                onPress: _canContinue ? _submit : null,
                child: const Text(
                  'Continuar',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
