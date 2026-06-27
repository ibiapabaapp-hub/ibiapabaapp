import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:forui/forui.dart';
import 'package:go_router/go_router.dart';
import 'package:ibivibe/features/auth/presentation/controllers/login_controller.dart';
import 'package:ibivibe/features/auth/presentation/states/login_state.dart';
import 'package:ibivibe/shared/ui/forms/fields/email/email_field.dart';
import 'package:ibivibe/shared/ui/fragments/toast/show_app_toast.dart';
import 'package:ibivibe/shared/utils/show_todo_toast.dart';

class LoginForm extends ConsumerStatefulWidget {
  final LoginController controller;
  const LoginForm({super.key, required this.controller});

  @override
  ConsumerState<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends ConsumerState<LoginForm> {
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
    widget.controller.setEmail(_email);
  }

  void _controllerListener() {
    final state = widget.controller.state;

    if (state is LoginSuccess) {
      showAppToast(
        context: context,
        icon: const Icon(Icons.check),
        title: "Bem vindo(a) de volta!",
        alignment: FToastAlignment.bottomCenter,
        duration: const Duration(seconds: 4),
      );
      context.go('/app/home');
    }

    if (state is LoginError) {
      showAppToast(
        context: context,
        icon: const Icon(Icons.gpp_maybe_outlined),
        title: 'Erro ao fazer login',
        description: state.message,
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
          EmailField(
            emailControl: _emailControl,
            emailChecker: widget.controller,
          ),

          FTextFormField.password(
            control: _passwordControl,
            label: const Text("Senha"),
            hint: 'Senha',
            enabled: !isLoading,
            autovalidateMode: .onUnfocus,
            onSubmit: (_) => _submit(),
            // validator: (v) =>
            //     authValidator.validateField(AuthFields.password, v),
          ),

          FButton.raw(
            style: FButtonStyle.ghost(),
            onPress: () {
              showTodoToast(context, 'Recuperação de senha');
            },
            child: Text(
              'Esqueci minha senha',
              style: context.theme.typography.sm,
            ),
          ),

          const SizedBox(height: 8),

          FButton(
            onPress: isLoading ? null : _submit,
            child: Text(isLoading ? 'Entrando…' : 'Entrar'),
          ),
        ],
      ),
    );
  }
}
