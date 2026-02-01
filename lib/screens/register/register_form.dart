import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:go_router/go_router.dart';

import 'package:ibiapabaapp/services/api_service.dart';
import 'package:ibiapabaapp/theme/theme.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final _formKey = GlobalKey<FormState>();
  final _apiService = ApiService();

  String _name = '';
  String _email = '';
  String _password = '';

  FTextFieldControl get _nameControl =>
      FTextFieldControl.managed(onChange: (v) => _name = v.text);

  FTextFieldControl get _emailControl =>
      FTextFieldControl.managed(onChange: (v) => _email = v.text);

  FTextFieldControl get _passwordControl =>
      FTextFieldControl.managed(onChange: (v) => _password = v.text);

  bool _isLoading = false;

  Future<void> _register() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      await _apiService.register(_name.trim(), _email.trim(), _password);

      if (!mounted) return;
      context.go('/home');
    } catch (e) {
      if (!mounted) return;

      showFToast(
        context: context,
        icon: const Icon(FIcons.triangleAlert),
        title: const Text('Erro ao criar conta'),
        description: Text(e.toString()),
        alignment: FToastAlignment.bottomCenter,
        duration: const Duration(seconds: 4),
      );
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        spacing: 16,
        children: [
          FTextFormField(
            control: _nameControl,
            style: (style) => style
                .withForeground(FTheme.of(context).colors)
                .withLabelPadding(bottom: 8),
            label: Text("Nome completo"),
            hint: 'Nome completo',
            enabled: !_isLoading,
            autovalidateMode: .onUnfocus,
            validator: (v) =>
                (v == null || v.isEmpty) ? 'Informe seu nome' : null,
          ),

          FTextFormField.email(
            control: _emailControl,
            style: (style) => style
                .withForeground(FTheme.of(context).colors)
                .withLabelPadding(bottom: 8),
            label: Text("Email"),
            hint: 'exemplo@email.com',
            enabled: !_isLoading,
            autovalidateMode: .onUnfocus,
            validator: (v) {
              if (v == null || v.isEmpty) return 'Informe o email';
              if (!v.contains('@')) return 'Email inválido';
              return null;
            },
          ),

          FTextFormField.password(
            control: _passwordControl,
            style: (style) => style
                .withForeground(FTheme.of(context).colors)
                .withLabelPadding(bottom: 8),
            label: Text("Senha"),
            hint: 'Senha',
            enabled: !_isLoading,
            autovalidateMode: .onUnfocus,
            validator: (v) {
              if (v == null || v.isEmpty) return 'Informe a senha';
              if (v.length < 6) return 'Mínimo 6 caracteres';
              return null;
            },
          ),

          const SizedBox(height: 8),

          SizedBox(
            width: double.infinity,
            child: FButton(
              onPress: _isLoading ? null : _register,
              child: Text(
                _isLoading ? 'Registrando…' : 'Registrar',
                style: TextStyle(fontWeight: .bold),
              ),
            ),
          ),

          FButton(
            onPress: () => context.replace('/auth/login'),
            style: FButtonStyle.ghost(),
            child: const Text('Já tenho conta'),
          ),
        ],
      ),
    );
  }
}
