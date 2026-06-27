import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:forui/forui.dart';
import 'package:ibiapabaapp/features/auth/validation/auth_validator.dart';
import 'package:ibiapabaapp/shared/ui/layout/availability_suffix.dart';
import 'package:ibiapabaapp/shared/ui/forms/fields/slug/slug_checker.dart';

class SlugField extends ConsumerStatefulWidget {
  final SlugChecker slugChecker;

  const SlugField({super.key, required this.slugChecker});

  @override
  ConsumerState<SlugField> createState() => _SlugFieldState();
}

class _SlugFieldState extends ConsumerState<SlugField> {
  late final FTextFieldControl _slugController;
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    _slugController = FTextFieldControl.managed(
      onChange: (v) => _onSlugChanged(v.text),
    );
  }

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  void _onSlugChanged(String value) {
    _debounce?.cancel();

    final trimmed = value.trim();
    widget.slugChecker.setSlug(trimmed);

    if (ref
            .read(authValidatorProvider)
            .validateField(AuthFields.slug, trimmed) !=
        null) {
      return;
    }

    _debounce = Timer(const Duration(milliseconds: 500), () {
      widget.slugChecker.checkSlugAvailability(trimmed);
    });
  }

  @override
  Widget build(BuildContext context) {
    final authValidator = ref.watch(authValidatorProvider);
    final isAvailable = widget.slugChecker.isSlugAvailable();

    return Column(
      children: [
        FTextFormField(
          prefixBuilder: (context, style, states) => Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 4, 0),
            child: Text(
              '@',
              style: TextStyle(
                fontSize: 16,
                color: context.theme.colors.secondaryForeground,
              ),
            ),
          ),
          suffixBuilder: (context, style, states) => AvailabilitySuffix(
            isAvailable: isAvailable,
            isChecking: widget.slugChecker.isSlugChecking(),
          ),
          label: const Text('Nome de usuário'),
          control: _slugController,
          hint: 'john_doe',
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: (v) => authValidator.validateField(AuthFields.slug, v),
        ),
        if (isAvailable != null && isAvailable == true)
          Text(
            'Nome de usuário disponível!',
            style: context.theme.typography.sm.copyWith(
              color: context.theme.colors.primary,
              fontWeight: FontWeight.w600,
            ),
          ),
      ],
    );
  }
}
