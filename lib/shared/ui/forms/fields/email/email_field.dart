import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:forui/forui.dart';
import 'package:ibivibe/features/auth/validation/auth_validator.dart';
import 'package:ibivibe/shared/ui/forms/fields/email/email_checker.dart';

class EmailField extends ConsumerStatefulWidget {
  final FTextFieldControl emailControl;
  final EmailChecker emailChecker;

  const EmailField({
    super.key,
    required this.emailControl,
    required this.emailChecker,
  });

  @override
  ConsumerState<EmailField> createState() => _EmailFieldState();
}

class _EmailFieldState extends ConsumerState<EmailField> {
  @override
  Widget build(BuildContext context) {
    final authValidator = ref.read(authValidatorProvider);

    return FTextFormField(
      label: const Text('E-mail'),
      control: widget.emailControl,
      hint: 'exemplo@email.com',
      keyboardType: TextInputType.emailAddress,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (v) => authValidator.validateField(AuthFields.email, v),
    );
  }
}
