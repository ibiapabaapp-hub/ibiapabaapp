import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:forui/forui.dart';
import 'package:ibivibe/features/auth/validation/auth_validator.dart';
import 'package:ibivibe/shared/ui/layout/availability_suffix.dart';
import 'package:ibivibe/shared/ui/forms/fields/email/email_checker.dart';

class CreateEmailField extends ConsumerStatefulWidget {
  final EmailChecker emailChecker;

  const CreateEmailField({super.key, required this.emailChecker});

  @override
  ConsumerState<CreateEmailField> createState() => _CreateEmailFieldState();
}

class _CreateEmailFieldState extends ConsumerState<CreateEmailField> {
  Timer? _debounce;
  late final FTextFieldControl _emailControl;

  @override
  void initState() {
    super.initState();
    _emailControl = FTextFieldControl.managed(
      onChange: (v) => _onEmailChanged(v.text),
    );
  }

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  void _onEmailChanged(String value) {
    _debounce?.cancel();
    widget.emailChecker.setEmail(value);

    if (ref
            .read(authValidatorProvider)
            .validateField(AuthFields.email, value) !=
        null) {
      return;
    }

    _debounce = Timer(const Duration(milliseconds: 500), () {
      widget.emailChecker.checkEmailAvailability(value);
    });
  }

  @override
  Widget build(BuildContext context) {
    final isAvailable = widget.emailChecker.isEmailAvailable();
    final isChecking = widget.emailChecker.isEmailChecking();
    final authValidator = ref.read(authValidatorProvider);

    return FTextFormField(
      label: const Text('E-mail'),
      control: _emailControl,
      hint: 'exemplo@email.com',
      keyboardType: TextInputType.emailAddress,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (v) => authValidator.validateField(AuthFields.email, v),
      suffixBuilder: (context, style, states) =>
          AvailabilitySuffix(isAvailable: isAvailable, isChecking: isChecking),
    );
  }
}
