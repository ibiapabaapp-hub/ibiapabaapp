import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:forui/forui.dart';
import 'package:go_router/go_router.dart';
import 'package:ibiapabaapp/features/auth/presentation/controllers/login_controller.dart';
import 'package:ibiapabaapp/features/auth/validation/auth_validator.dart';
import 'package:ibiapabaapp/app/theme/theme.dart';
import 'package:ibiapabaapp/features/auth/presentation/states/login_state.dart';
import 'package:ibiapabaapp/shared/ui/fragments/toast/show_app_toast.dart';

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
  }

  void _controllerListener() {
    final state = widget.controller.state;

    if (state is LoginSuccess) {
      showAppToast(
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
      showAppToast(
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
    final authValidator = ref.watch(authValidatorProvider);
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
            validator: (v) => authValidator.validateField(AuthFields.email, v),
          ),

          FTextFormField.password(
            control: _passwordControl,
            style: (style) =>
                style.withBaseFontSize(typography: context.theme.typography),
            label: const Text("Senha"),
            hint: 'Senha',
            enabled: !isLoading,
            autovalidateMode: .onUnfocus,
            onSubmit: (_) => _submit(),
            // validator: (v) =>
            //     authValidator.validateField(AuthFields.password, v),
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
