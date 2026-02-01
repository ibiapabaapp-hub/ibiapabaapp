import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:go_router/go_router.dart';
import 'package:ibiapabaapp/services/api_service.dart';
import 'package:ibiapabaapp/theme/theme.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final _apiService = ApiService();

  bool _isLoading = false;
  String _email = '';
  String _password = '';

  late final FTextFieldControl _emailControl;
  late final FTextFieldControl _passwordControl;

  @override
  void initState() {
    super.initState();
    _emailControl = FTextFieldControl.managed(onChange: (v) => _email = v.text);
    _passwordControl = FTextFieldControl.managed(
      onChange: (v) => _password = v.text,
    );
  }

  Future<void> _login() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      await _apiService.login(_email.trim(), _password);
      if (!mounted) return;
      context.go('/app/home');
    } catch (e) {
      if (!mounted) return;

      showFToast(
        context: context,
        icon: const Icon(FIcons.triangleAlert),
        title: const Text('Erro ao fazer login'),
        description: Text(e.toString()),
        alignment: FToastAlignment.bottomCenter,
        duration: const Duration(seconds: 4),
      );
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 16,
        children: [
          FTextFormField.email(
            control: _emailControl,
            style: (style) => style
                .withForeground(FTheme.of(context).colors)
                .withLabelPadding(bottom: 8),
            label: Text("Email"),
            hint: "exemplo@email.com",
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
              onPress: _isLoading ? null : _login,
              child: Text(
                _isLoading ? 'Entrando…' : 'Entrar',
                style: TextStyle(fontWeight: .bold),
              ),
            ),
          ),

          FButton(
            style: FButtonStyle.ghost(),
            onPress: () => context.replace('/auth/register'),
            child: const Text('Criar conta'),
          ),
        ],
      ),
    );
  }
}
