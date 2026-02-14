import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:ibiapabaapp/app/theme/theme.dart';
import 'package:ibiapabaapp/features/auth/presentation/controllers/register_controller.dart';
import 'package:ibiapabaapp/features/auth/presentation/states/register_state.dart';

class PasswordStep extends StatefulWidget {
  final RegisterController controller;
  final VoidCallback onSubmit;

  const PasswordStep({
    super.key,
    required this.controller,
    required this.onSubmit,
  });

  @override
  State<PasswordStep> createState() => _PasswordStepState();
}

class _PasswordStepState extends State<PasswordStep> {
  final _formKey = GlobalKey<FormState>();

  String _password = '';
  String _confirmPassword = '';

  late final FTextFieldControl _passwordControl;
  late final FTextFieldControl _confirmPasswordControl;

  @override
  void initState() {
    super.initState();

    // 1. Pegamos os valores iniciais
    _password = widget.controller.formData.password;
    _confirmPassword = widget.controller.formData.confirmPassword;

    // 2. Inicializamos os controles já com o texto (se houver)
    _passwordControl = FTextFieldControl.managed(
      initial: TextEditingValue(text: _password),
      onChange: (v) => setState(
        () => _password = v.text,
      ), // setState aqui ajuda na validação em tempo real
    );

    _confirmPasswordControl = FTextFieldControl.managed(
      initial: TextEditingValue(text: _confirmPassword),
      onChange: (v) => setState(() => _confirmPassword = v.text),
    );

    widget.controller.addListener(_controllerListener);
  }

  void _controllerListener() {
    if (mounted) setState(() {});
  }

  void _submit() {
    FocusScope.of(context).unfocus();
    if (!_formKey.currentState!.validate()) return;

    widget.controller.setPassword(_password);
    widget.controller.setConfirmPassword(_confirmPassword);
    widget.onSubmit();
  }

  @override
  void dispose() {
    widget.controller.removeListener(_controllerListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = widget.controller.state is RegisterLoading;

    return Padding(
      padding: const EdgeInsets.all(24),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 16,
          children: [
            Text(
              'Para terminar, defina uma senha',
              style: context.theme.typography.xl2.copyWith(fontWeight: .w600),
            ),

            Text(
              'Crie uma senha forte, de preferência com letras, números e caracteres especiais',
              style: context.theme.typography.base.copyWith(
                fontWeight: .normal,
              ),
            ),

            FTextFormField.password(
              control: _passwordControl,
              style: (style) =>
                  style.withBaseFontSize(typography: context.theme.typography),
              label: const Text('Senha'),
              hint: 'Mínimo 8 caracteres',
              enabled: !isLoading,
              autovalidateMode: AutovalidateMode.onUnfocus,
              validator: (v) {
                if (v == null || v.isEmpty) {
                  return 'Informe a senha';
                }
                if (v.length < 8) {
                  return 'No mínimo 8 caracteres';
                }
                if (!RegExp(r'[A-Z]').hasMatch(v)) {
                  return 'Inclua pelo menos 1 letra maiúscula';
                }
                if (!RegExp(r'[0-9]').hasMatch(v)) {
                  return 'Inclua pelo menos 1 número';
                }
                return null;
              },
            ),

            FTextFormField.password(
              control: _confirmPasswordControl,
              style: (style) =>
                  style.withBaseFontSize(typography: context.theme.typography),
              label: const Text('Confirmar senha'),
              hint: 'Digite novamente',
              enabled: !isLoading,
              autovalidateMode: AutovalidateMode.onUnfocus,
              validator: (v) {
                if (v == null || v.isEmpty) {
                  return 'Confirme a senha';
                }
                if (v != _password) {
                  return 'As senhas não coincidem';
                }
                return null;
              },
              onSubmit: (_) => _submit(),
            ),

            const Spacer(),

            SizedBox(
              width: double.infinity,
              child: isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : FButton(onPress: _submit, child: const Text('Criar conta')),
            ),
          ],
        ),
      ),
    );
  }
}
