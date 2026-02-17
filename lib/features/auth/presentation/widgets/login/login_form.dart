import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:go_router/go_router.dart';
import 'package:ibiapabaapp/features/auth/presentation/controllers/login_controller.dart';
import 'package:ibiapabaapp/app/theme/theme.dart';
import 'package:ibiapabaapp/features/auth/presentation/states/login_state.dart';

class LoginForm extends StatefulWidget {
  final LoginController controller;
  const LoginForm({super.key, required this.controller});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();

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
    widget.controller.addListener(_controllerListener);
  }

  void _controllerListener() {
    final state = widget.controller.state;

    if (state is LoginSuccess) {
      showFToast(
        context: context,
        icon: Icon(Icons.check),
        title: Text(
          "Bem vindo(a) de volta!",
          style: TextStyle(color: context.theme.colors.foreground),
        ),
        alignment: FToastAlignment.bottomCenter,
        duration: const Duration(seconds: 4),
      );
      context.go('/app/home');
    }

    if (state is LoginError) {
      showFToast(
        context: context,
        icon: const Icon(Icons.gpp_maybe_outlined),
        title: const Text('Erro ao fazer login'),
        description: Text(state.message),
        alignment: FToastAlignment.bottomCenter,
        duration: const Duration(seconds: 4),
      );
    }

    setState(() {});
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    widget.controller.login(email: _email, password: _password);
  }

  @override
  void dispose() {
    widget.controller.removeListener(_controllerListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = widget.controller.state is LoginLoading;

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 16,
        children: [
          FTextFormField.email(
            control: _emailControl,
            style: (style) =>
                style.withBaseFontSize(typography: context.theme.typography),
            label: const Text("Email"),
            hint: "exemplo@email.com",
            enabled: !isLoading,
            autovalidateMode: .onUnfocus,
            validator: (v) {
              if (v == null || v.isEmpty) return 'Informe o email';
              if (!v.contains('@')) return 'Email inválido';
              return null;
            },
          ),

          FTextFormField.password(
            control: _passwordControl,
            style: (style) =>
                style.withBaseFontSize(typography: context.theme.typography),
            label: const Text("Senha"),
            hint: 'Senha',
            enabled: !isLoading,
            autovalidateMode: .onUnfocus,
            validator: (v) {
              if (v == null || v.isEmpty) return 'Informe a senha';
              if (v.length < 8) return 'No mínimo 8 caracteres';
              return null;
            },
          ),

          const SizedBox(height: 8),

          FButton(
            onPress: isLoading ? null : _submit,
            child: Text(isLoading ? 'Entrando…' : 'Entrar'),
          ),

          FButton(
            style: FButtonStyle.ghost(),
            onPress: () => context.push('/auth/register'),
            child: const Text('Criar conta'),
          ),
        ],
      ),
    );
  }
}
