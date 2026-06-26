import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:forui/forui.dart';
import 'package:ibiapabaapp/features/auth/presentation/controllers/register_controller.dart';
import 'package:ibiapabaapp/features/auth/presentation/states/register_state.dart';
import 'package:ibiapabaapp/features/auth/validation/auth_validator.dart';

class CreatePasswordFields extends ConsumerStatefulWidget {
  const CreatePasswordFields({super.key});

  @override
  ConsumerState<CreatePasswordFields> createState() =>
      _CreatePasswordFieldsState();
}

class _CreatePasswordFieldsState extends ConsumerState<CreatePasswordFields> {
  late final FTextFieldControl _passwordControl;
  late final FTextFieldControl _confirmPasswordControl;

  @override
  void initState() {
    super.initState();
    _passwordControl = FTextFieldControl.managed(
      onChange: (v) =>
          ref.read(registerControllerProvider.notifier).setPassword(v.text),
    );
    _confirmPasswordControl = FTextFieldControl.managed(
      onChange: (v) => ref
          .read(registerControllerProvider.notifier)
          .setConfirmPassword(v.text),
    );
  }

  @override
  Widget build(BuildContext context) {
    final authValidator = ref.watch(authValidatorProvider);
    final status = ref.watch(
      registerControllerProvider.select((s) => s.status),
    );
    final isLoading = status == RegisterStatus.loading;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 16,
      children: [
        FTextFormField.password(
          control: _passwordControl,
          label: const Text('Senha'),
          hint: 'Mínimo 8 caracteres',
          enabled: !isLoading,
          autovalidateMode: AutovalidateMode.onUnfocus,
          validator: (v) => authValidator.validateField(AuthFields.password, v),
        ),

        FTextFormField.password(
          control: _confirmPasswordControl,
          label: const Text('Confirmar senha'),
          hint: 'Digite novamente',
          enabled: !isLoading,
          autovalidateMode: AutovalidateMode.onUnfocus,
          validator: (v) =>
              authValidator.validateField(AuthFields.confirmPassword, v),
        ),
      ],
    );
  }
}
