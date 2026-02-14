import 'dart:async';
import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:ibiapabaapp/app/theme/theme.dart';
import 'package:ibiapabaapp/features/auth/presentation/controllers/register_controller.dart';

class EmailStep extends StatefulWidget {
  final RegisterController controller;
  final VoidCallback onNext;

  const EmailStep({super.key, required this.controller, required this.onNext});

  @override
  State<EmailStep> createState() => _EmailStepState();
}

class _EmailStepState extends State<EmailStep> {
  final _formKey = GlobalKey<FormState>();

  String _email = '';
  Timer? _debounce;
  String? _errorText;
  String? _successText;
  bool _isChecking = false;
  bool? _isAvailable;

  late final FTextFieldControl _emailControl;

  final RegExp _emailRegex = RegExp(
    r'^[a-z0-9.]+@[a-z0-9]+\.[a-z]+(\.[a-z]+)?$',
    caseSensitive: false,
  );

  bool get _canContinue =>
      _isAvailable == true &&
      !_isChecking &&
      _errorText == null &&
      _email.isNotEmpty;

  @override
  void initState() {
    super.initState();
    _email = widget.controller.formData.email;
    _emailControl = FTextFieldControl.managed(
      onChange: (v) {
        _email = v.text.trim();
        _onEmailChanged(_email);
      },
    );
  }

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  void _onEmailChanged(String value) {
    _debounce?.cancel();

    setState(() {
      _errorText = null;
      _successText = null;
      _isAvailable = null;
    });

    final trimmed = value.trim();
    if (!_emailRegex.hasMatch(trimmed)) return;

    _debounce = Timer(const Duration(milliseconds: 500), () {
      _checkEmailAvailability(trimmed);
    });
  }

  Future<void> _checkEmailAvailability(String email) async {
    setState(() {
      _isChecking = true;
      _isAvailable = null;
    });

    final available = await widget.controller.checkEmail(email);

    if (!mounted) return;

    setState(() {
      _isAvailable = available;
      _isChecking = false;

      final fieldError = widget.controller.getError('email');
      if (fieldError != null) {
        _errorText = fieldError;
      } else if (available == false) {
        _errorText = 'Este e-mail já está cadastrado.';
      } else if (available == true) {
        _successText = 'E-mail disponível!';
      }
    });

    _formKey.currentState?.validate();
  }

  void _submit() {
    FocusScope.of(context).unfocus();
    if (!_formKey.currentState!.validate()) return;
    if (_isAvailable != true) return;

    widget.controller.setEmail(_email);
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
        padding: const EdgeInsets.all(12),
        child: Icon(
          Icons.check_circle_outline,
          color: context.theme.colors.primary,
        ),
      );
    }

    if (_isAvailable == false) {
      return Padding(
        padding: const EdgeInsets.all(12),
        child: Icon(Icons.error_outline, color: context.theme.colors.error),
      );
    }

    return const SizedBox.shrink();
  }

  String? _validate(String? v) {
    if (v == null || v.trim().isEmpty) {
      return 'Digite um e-mail.';
    }

    final email = v.trim();

    if (!_emailRegex.hasMatch(email)) {
      return 'Digite um e-mail válido.';
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
              'Qual é o seu e-mail?',
              style: context.theme.typography.xl2.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),

            FTextFormField(
              control: _emailControl,
              suffixBuilder: (context, style, states) => _buildSuffix(context),
              style: (style) =>
                  style.withBaseFontSize(typography: context.theme.typography),
              hint: 'exemplo@email.com',
              keyboardType: TextInputType.emailAddress,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (v) => _validate(v),
              onSubmit: (_) => _canContinue ? _submit() : null,
            ),

            if (_successText != null && _errorText == null && !_isChecking)
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
