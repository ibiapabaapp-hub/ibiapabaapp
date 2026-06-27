import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:forui/forui.dart';
import 'package:ibivibe/features/auth/presentation/controllers/register_controller.dart';
import 'package:ibivibe/shared/ui/forms/fields/password/create_password_fields.dart';
import 'package:ibivibe/shared/ui/forms/fields/email/create_email_field.dart';
import 'package:ibivibe/features/auth/presentation/widgets/shared/google_oauth_button.dart';
import 'package:ibivibe/features/auth/presentation/widgets/shared/text_between_dividers.dart';
import 'package:ibivibe/shared/ui/layout/form_topbar.dart';

class CredentialsStep extends ConsumerStatefulWidget {
  final VoidCallback onNext;
  const CredentialsStep({super.key, required this.onNext});

  @override
  ConsumerState<CredentialsStep> createState() => _CredentialsStepState();
}

class _CredentialsStepState extends ConsumerState<CredentialsStep> {
  final formKey = GlobalKey<FormState>();
  bool _isFormValid = false;

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

          CreateEmailField(emailChecker: controller),
          const CreatePasswordFields(),

          const SizedBox(height: 4),
          const TextBetweenDividers(text: 'ou'),
          const SizedBox(height: 4),
          const GoogleOAuthButton(),

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
