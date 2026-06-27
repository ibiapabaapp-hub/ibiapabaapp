// ignore_for_file: unused_field

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:forui/forui.dart';
import 'package:ibivibe/features/auth/presentation/controllers/register_controller.dart';
import 'package:ibivibe/shared/ui/forms/fields/name/name_field.dart';
import 'package:ibivibe/shared/ui/forms/fields/slug/slug_field.dart';
import 'package:ibivibe/shared/ui/layout/form_topbar.dart';

class BasicInfoStep extends ConsumerStatefulWidget {
  final VoidCallback onNext;
  const BasicInfoStep({super.key, required this.onNext});

  @override
  ConsumerState<BasicInfoStep> createState() => _BasicInfoStepState();
}

class _BasicInfoStepState extends ConsumerState<BasicInfoStep> {
  final formKey = GlobalKey<FormState>();
  bool _isFormValid = false;

  String _name = '';
  late final FTextFieldControl _nameControl;

  @override
  void initState() {
    super.initState();
    _name = ref.read(registerControllerProvider).formData.name;
    _nameControl = FTextFieldControl.managed(onChange: (v) => _name = v.text);
  }

  void _validateForm() {
    setState(() {
      _isFormValid = formKey.currentState?.validate() ?? false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final controller = ref.read(registerControllerProvider.notifier);

    return Form(
      key: formKey,
      onChanged: _validateForm,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 16,
        children: [
          const FormTopbar(
            title: 'Credenciais',
            subtitle: 'Olá, vamos criar sua conta',
          ),

          NameField(nameControl: _nameControl),
          SlugField(slugChecker: controller),

          const Spacer(),
          FButton(
            onPress: _isFormValid ? widget.onNext : null,
            child: const Text('Continuar'),
          ),
        ],
      ),
    );
  }
}
